//
//  ContentView.swift
//  BasicApp
//
//  Created by VOLKAN EFE on 23.03.2024.
//

import SwiftUI

struct Option: Hashable{
    
    let title: String
    let imageName: String
}

struct ContentView: View {
    @State var currentOption = 0
    let options: [Option]=[
        .init(title: "Home", imageName: "house"),
        .init(title: "About", imageName: "info.circle"),
        .init(title: "Settings", imageName: "gear"),
        .init(title: "Social", imageName: "message")
    ]
    
    var body: some View {
        NavigationView{
            
            ListView(
                options: options,
                currentSelection: $currentOption
            )
            
            switch currentOption{
            case 1:
                Text("About View")
                    .font(.title)
                    .foregroundColor(.green)
            case 2:
                Text("Settings View")
                    .font(.title)
                    .foregroundColor(.red)
            case 3:
                Text("Social View")
                    .font(.title)
                    .foregroundColor(.yellow)
            default:
                MainView()
            }
            
        }
        .frame(minWidth: 600, minHeight: 400)
        .preferredColorScheme(.dark)
    }
}

struct ListView: View {
    let options: [Option]
    @Binding var currentSelection : Int
    var body: some View {
        VStack{
            let current = options[currentSelection]
            ForEach(options, id: \.self) { option in
                HStack{
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text(option.title)
                        .foregroundColor(current == option ? Color.blue : Color.white)
                    Spacer()
                }
                .padding(8)
                .onTapGesture {
                    if let selectedIndex = options.firstIndex(where: { $0 == option }) {
                        currentSelection = selectedIndex
                    }
                }

            }
            Spacer()
        }
    }
}

struct MainView: View {
    
    let cols: [GridItem] = [
    
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
        
    ]
    
    let images = Array(1...6).map {"image\($0)"}
    
    var body: some View {
        Image("header")
            .resizable()
            .aspectRatio(contentMode: .fit)
        Spacer()
        
        LazyVGrid(columns: cols){
            ForEach(images, id: \.self){ imageName in
                VStack{
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text("Video Title")
                        .bold()
                }
                .padding(5)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
