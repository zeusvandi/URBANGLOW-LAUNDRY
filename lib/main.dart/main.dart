import 'package:flutter/material.dart';

void main() => runApp(UrbanGlowApp());

class Config {
  static const String businessName = "UrbanGlow Laundry";
  static const String tagline = "Fresh. Clean. Delivered.";
  static const String phone = "07088741990";
  static const String whatsapp = "2347088741990";
  static const String address = "Mazzaram Topp, Rayfield, Jos, Plateau State";
  static const String promo = "20% OFF with code GLOW20";
  static const Color teal = Color(0xFF00B4A6);
  static const Color yellow = Color(0xFFFFC93C);
}

class UrbanGlowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrbanGlow Laundry',
      theme: ThemeData(primaryColor: Config.teal, colorScheme: ColorScheme.fromSeed(seedColor: Config.teal)),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  String _status = "Received";
  String _name = "";
  String _service = "Wash & Iron";
  String _address = "";
  final List<String> _stages = ["Received", "Washing", "Ironing", "Ready", "Delivered"];

  final List<Map<String, dynamic>> prices = [
    {"item": "Shirt / T-Shirt", "price": "₦800"},
    {"item": "Trouser / Jean", "price": "₦1,000"},
    {"item": "Native Wear (Complete)", "price": "₦2,500"},
    {"item": "Suit (Complete)", "price": "₦4,000"},
    {"item": "Bedsheet / Duvet", "price": "₦3,000"},
    {"item": "Wash & Fold (Per Kg)", "price": "₦1,200"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Config.teal, title: Text(Config.businessName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), centerTitle: true),
      body: _index == 0 ? _home() : _index == 1 ? _book() : _index == 2 ? _track() : _prices(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: Config.teal,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.local_laundry_service), label: "Book"),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: "Track"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Prices"),
        ],
      ),
    );
  }

  Widget _home() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: double.infinity, padding: EdgeInsets.all(20), decoration: BoxDecoration(color: Config.teal, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Fresh. Clean. Delivered.", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(Config.address, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 12),
          Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Config.yellow, borderRadius: BorderRadius.circular(20)), child: Text("🎉 ${Config.promo}", style: TextStyle(fontWeight: FontWeight.bold))),
        ])),
        SizedBox(height: 20),
        Text("What do you need?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: _card("Book Laundry", "In 30 seconds", Icons.local_laundry_service, () => setState(() => _index = 1))),
          SizedBox(width: 12),
          Expanded(child: _card("Track Order", "Live Status: $_status", Icons.track_changes, () => setState(() => _index = 2))),
        ]),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: _card("Price List", "See all prices", Icons.list_alt, () => setState(() => _index = 3))),
          SizedBox(width: 12),
          Expanded(child: _card("WhatsApp Us", "07088741990", Icons.chat, () {})),
        ]),
        SizedBox(height: 20),
        Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(Icons.delivery_dining, color: Config.teal), SizedBox(width: 10), Expanded(child: Text("Free Pickup & Delivery in Jos\nMazzaram Topp, Rayfield, Jos"))])),
      ]),
    );
  }

  Widget _card(String t, String s, IconData i, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(i, color: Config.teal, size: 28), SizedBox(height: 8), Text(t, style: TextStyle(fontWeight: FontWeight.bold)), Text(s, style: TextStyle(color: Colors.grey, fontSize: 12))])));
  }

  Widget _book() {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Book Your Laundry", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      TextField(decoration: InputDecoration(labelText: "Your Name", border: OutlineInputBorder()), onChanged: (v) => _name = v),
      SizedBox(height: 12),
      DropdownButtonFormField<String>(value: _service, decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Service"), items: ["Wash & Iron", "Wash & Fold", "Dry Cleaning", "Express 6 Hours"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _service = v!)),
      SizedBox(height: 12),
      TextField(decoration: InputDecoration(labelText: "Pickup Address", border: OutlineInputBorder()), onChanged: (v) => _address = v),
      SizedBox(height: 20),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Config.teal, padding: EdgeInsets.symmetric(vertical: 16)), onPressed: () {
        setState(() { _status = "Received"; _index = 2; });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Order Booked! We will call 07088741990 shortly. Use code GLOW20 for 20% OFF")));
      }, child: Text("Book Now - Use GLOW20", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      SizedBox(height: 12),
      Text("Or WhatsApp us directly: 07088741990", textAlign: TextAlign.center),
    ]));
  }

  Widget _track() {
    int cur = _stages.indexOf(_status);
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Track Your Order", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text("Hello ${_name.isEmpty ? 'Customer' : _name} - Service: $_service"),
      SizedBox(height: 20),
      ..._stages.asMap().entries.map((e) {
        bool done = e.key <= cur;
        return ListTile(leading: CircleAvatar(backgroundColor: done ? Config.teal : Colors.grey.shade300, child: Icon(done ? Icons.check : Icons.circle, color: Colors.white, size: 16)), title: Text(e.value, style: TextStyle(fontWeight: done ? FontWeight.bold : FontWeight.normal)), subtitle: Text(done ? "Completed" : "Waiting"));
      }),
      SizedBox(height: 20),
      Text("Admin Demo: Tap to move order forward", style: TextStyle(color: Colors.grey)),
      SizedBox(height: 8),
      Wrap(spacing: 8, children: _stages.map((s) => ActionChip(label: Text(s), onPressed: () => setState(() => _status = s))).toList()),
    ]));
  }

  Widget _prices() {
    return ListView.builder(padding: EdgeInsets.all(16), itemCount: prices.length, itemBuilder: (c, i) {
      return Card(child: ListTile(leading: Icon(Icons.checkroom, color: Config.teal), title: Text(prices[i]["item"]), trailing: Text(prices[i]["price"], style: TextStyle(fontWeight: FontWeight.bold, color: Config.teal))));
    });
  }
}
