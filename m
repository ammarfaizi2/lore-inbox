Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWJQXgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWJQXgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWJQXgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:36:37 -0400
Received: from wizardsworks.org ([71.216.230.3]:40357 "EHLO
	constellation.wizardsworks.org") by vger.kernel.org with ESMTP
	id S1751027AbWJQXgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:36:36 -0400
Date: Tue, 17 Oct 2006 17:48:46 -0500 (CDT)
From: Greg Chandler <chandleg@constellation.wizardsworks.org>
To: dmitry.torokhov@gmail.com
cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: RE: Touchscreen hardware hacking/driver hacking.
Message-ID: <Pine.LNX.4.64.0610171743530.952@constellation.wizardsworks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure this will help all too much, but at least I have the 
strings...


Here is what dmidecode spat out:

# dmidecode 2.8
SMBIOS 2.3 present.
23 structures occupying 646 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
 	Vendor: Phoenix Technologies Ltd.
 	Version: 1.06VB
 	Release Date: 03/13/2003
 	Address: 0xE7A00
 	Runtime Size: 99840 bytes
 	ROM Size: 512 kB
 	Characteristics:
 		ISA is supported
 		PCI is supported
 		PC Card (PCMCIA) is supported
 		PNP is supported
 		APM is supported
 		BIOS is upgradeable
 		BIOS shadowing is allowed
 		Selectable boot is supported
 		EDD is supported
 		Print screen service is supported (int 5h)
 		8042 keyboard services are supported (int 9h)
 		Serial services are supported (int 14h)
 		Printer services are supported (int 17h)
 		CGA/mono video services are supported (int 10h)
 		ACPI is supported
 		USB legacy is supported
 		Smart battery is supported
 		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
 	Manufacturer: HITACHI
 	Product Name: FLORA-ie 55mi
 	Version: crusoe/ALi1535
 	Serial Number: 0
 	UUID: 00000000-0000-0000-0000-FFFFFFFFFFFF
 	Wake-up Type: Power Switch

Handle 0x0002, DMI type 3, 17 bytes
Chassis Information
 	Manufacturer: HITACHI
 	Type: Portable
 	Lock: Not Present
 	Version: crusoe/ALi1535
 	Serial Number: XXXXXXXXXXXXXXXX
 	Asset Tag: 0
 	Boot-up State: Safe
 	Power Supply State: Safe
 	Thermal State: Safe
 	Security Status: None
 	OEM Information: 0x00001234

Handle 0x0003, DMI type 4, 32 bytes
Processor Information
 	Socket Designation: CPU
 	Type: Central Processor
 	Family: K6-3
 	Manufacturer: Transmeta
 	ID: 43 05 00 00 3F 89 84 00
 	Signature: Family 5, Model 4, Stepping 3
 	Flags:
 		FPU (Floating-point unit on-chip)
 		VME (Virtual mode extension)
 		DE (Debugging extension)
 		PSE (Page size extension)
 		TSC (Time stamp counter)
 		MSR (Model specific registers)
 		CX8 (CMPXCHG8 instruction supported)
 		SEP (Fast system call)
 		CMOV (Conditional move instruction supported)
 		PSN (Processor serial number present and enabled)
 		MMX (MMX technology supported)
 	Version: Crusoe(tm)
 	Voltage: 1.6 V
 	External Clock: 66 MHz
 	Max Speed: 400 MHz
 	Current Speed: 400 MHz
 	Status: Populated, Enabled
 	Upgrade: None
 	L1 Cache Handle: 0x0004
 	L2 Cache Handle: 0x0005
 	L3 Cache Handle: Not Provided

Handle 0x0004, DMI type 7, 19 bytes
Cache Information
 	Socket Designation: Cache1
 	Configuration: Enabled, Not Socketed, Level 1
 	Operational Mode: Write Back
 	Location: Internal
 	Installed Size: 128 KB
 	Maximum Size: 128 KB
 	Supported SRAM Types:
 		Pipeline Burst
 	Installed SRAM Type: Pipeline Burst
 	Speed: Unknown
 	Error Correction Type: None
 	System Type: Unknown
 	Associativity: Unknown

Handle 0x0005, DMI type 7, 19 bytes
Cache Information
 	Socket Designation: Cache2
 	Configuration: Enabled, Not Socketed, Level 2
 	Operational Mode: Write Back
 	Location: Internal
 	Installed Size: 256 KB
 	Maximum Size: 256 KB
 	Supported SRAM Types:
 		Pipeline Burst
 	Installed SRAM Type: None
 	Speed: Unknown
 	Error Correction Type: None
 	System Type: Unknown
 	Associativity: Unknown

Handle 0x0006, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: SERIAL
 	External Connector Type: None
 	Port Type: Serial Port 16550A Compatible

Handle 0x0007, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: USB1
 	External Connector Type: Access Bus (USB)
 	Port Type: USB

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: USB2
 	External Connector Type: Access Bus (USB)
 	Port Type: USB

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: MICROPHONE MINI JACK
 	External Connector Type: Other
 	Port Type: Other

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
 	Internal Reference Designator: Not Specified
 	Internal Connector Type: None
 	External Reference Designator: AUDIO OUT MINI JACK
 	External Connector Type: Mini Jack (headphones)
 	Port Type: Audio Port

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
 	Designation: PCCARD SLOT1
 	Type: 16-bit PC Card (PCMCIA)
 	Current Usage: Unknown
 	Length: Other
 	ID: Adapter 0, Socket 1
 	Characteristics:
 		5.0 V is provided
 		3.3 V is provided
 		PC Card-16 is supported
 		Modem ring resume is supported

Handle 0x000E, DMI type 16, 15 bytes
Physical Memory Array
 	Location: System Board Or Motherboard
 	Use: System Memory
 	Error Correction Type: None
 	Maximum Capacity: 128 MB
 	Error Information Handle: Not Provided
 	Number Of Devices: 1

Handle 0x000F, DMI type 17, 23 bytes
Memory Device
 	Array Handle: 0x000E
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 128 MB
 	Form Factor: DIMM
 	Set: 1
 	Locator: Socket
 	Bank Locator: Bank0
 	Type: SDRAM
 	Type Detail: Synchronous
 	Speed: 100 MHz (10.0 ns)

Handle 0x0010, DMI type 17, 23 bytes
Memory Device
 	Array Handle: 0x000E
 	Error Information Handle: Not Provided
 	Total Width: 64 bits
 	Data Width: 64 bits
 	Size: 112 MB
 	Form Factor: DIMM
 	Set: 2
 	Locator: Base
 	Bank Locator: Bank1
 	Type: SDRAM
 	Type Detail: Synchronous
 	Speed: 100 MHz (10.0 ns)

Handle 0x0011, DMI type 19, 15 bytes
Memory Array Mapped Address
 	Starting Address: 0x00000000000
 	Ending Address: 0x0000EFFFFFF
 	Range Size: 240 MB
 	Physical Array Handle: 0x000E
 	Partition Width: 0

Handle 0x0012, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x00000000000
 	Ending Address: 0x00007FFFFFF
 	Range Size: 128 MB
 	Physical Device Handle: 0x000F
 	Memory Array Mapped Address Handle: 0x0011
 	Partition Row Position: Unknown

Handle 0x0013, DMI type 20, 19 bytes
Memory Device Mapped Address
 	Starting Address: 0x00008000000
 	Ending Address: 0x0000EFFFFFF
 	Range Size: 112 MB
 	Physical Device Handle: 0x0010
 	Memory Array Mapped Address Handle: 0x0011
 	Partition Row Position: Unknown

Handle 0x0014, DMI type 21, 7 bytes
Built-in Pointing Device
 	Type: Track Ball
 	Interface: PS/2
 	Buttons: 0

Handle 0x0015, DMI type 32, 20 bytes
System Boot Information
 	Status: <OUT OF SPEC>

Handle 0x0016, DMI type 127, 4 bytes
End Of Table

Wrong DMI structures count: 23 announced, only 21 decoded.
