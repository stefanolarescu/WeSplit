//
//  ContentView.swift
//  WeSplit
//
//  Created by Stefan Olarescu on 12.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @State private var checkAmount = Double.zero
    @State private var numberOfPeopleSelection = Int.zero
    @State private var tipPercentage = Int.zero
    
    @FocusState private var amountIsFocused: Bool
    
    // MARK: - COMPUTED PROPERTIES
    private var totalAmount: Double {
        let tipAmount = checkAmount * Double(tipPercentage) / 100
        return checkAmount + tipAmount
    }
    
    private var amountPerPerson: Double {
        let numberOfPeople = Double(numberOfPeopleSelection + 2)
        return totalAmount / numberOfPeople
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeopleSelection) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == .zero ? .red : .primary)
                }
                
                Section("Amount per person") {
                    Text(amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
