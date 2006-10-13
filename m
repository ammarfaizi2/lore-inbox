Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWJMPZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWJMPZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWJMPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:25:51 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:18841 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751163AbWJMPZu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:25:50 -0400
Date: Fri, 13 Oct 2006 17:25:46 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: Aleksey Gorelov <dared1st@yahoo.com>, linux-kernel@vger.kernel.org,
       magnus.damm@gmail.com, pavel@suse.cz
Subject: Re: Machine reboot
Message-ID: <20061013152546.GF3039@mail.muni.cz>
References: <20061013000556.89570.qmail@web83108.mail.mud.yahoo.com> <452F1142.3000400@intel.com> <20061013091608.GH18163@mail.muni.cz> <452FA451.6090702@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <452FA451.6090702@intel.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 13, 2006 at 07:36:01AM -0700, Auke Kok wrote:
> >For i965 chipsets, the BIOS is *a lot* buggy :(
> 
> that's depressing, can you send me the output of `dmidecode` of the latest 
> BIOS? Perhaps I can reproduce it myself with that version.

output of dmidecode is attached.

-- 
Luká¹ Hejtmánek

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=dmidecode

# dmidecode 2.8
SMBIOS 2.4 present.
35 structures occupying 1629 bytes.
Table at 0x000E4390.

Handle 0x0000, DMI type 4, 35 bytes
Processor Information
	Socket Designation: LGA 775
	Type: Central Processor
	Family: <OUT OF SPEC>
	Manufacturer: Intel(R) Corporation
	ID: F6 06 00 00 FF FB EB BF
	Version: Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz
	Voltage: 1.6 V
	External Clock: 266 MHz
	Max Speed: 4000 MHz
	Current Speed: 2133 MHz
	Status: Populated, Enabled
	Upgrade: Other
	L1 Cache Handle: 0x0003
	L2 Cache Handle: 0x0001
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0001, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 2048 KB
	Maximum Size: 2048 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0002, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x0003, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Unknown
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 32 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x0004, DMI type 0, 24 bytes
BIOS Information
	Vendor: Intel Corp.
	Version: MQ96510J.86A.1250.2006.1005.1532
	Release Date: 10/05/2006
	Address: 0xF0000
	Runtime Size: 64 kB
	ROM Size: 1024 kB
	Characteristics:
		PCI is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		ATAPI Zip drive boot is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 0.0
	Firmware Revision: 0.0

Handle 0x0005, DMI type 1, 27 bytes
System Information
	Manufacturer:                                 
	Product Name:                                 
	Version:                         
	Serial Number:                                 
	UUID: 52871F95-040B-11DB-AFD2-0013200B4F9E
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0006, DMI type 2, 20 bytes
Base Board Information
	Manufacturer: Intel Corporation
	Product Name: DP965LT
	Version: AAD41694-203
	Serial Number: AZLT62600926
	Asset Tag: Base Board Asset Tag
	Features:
		Board is a hosting board
		Board is replaceable
	Location In Chassis: Base Board Chassis Location
	Chassis Handle: 0x0007
	Type: Unknown
	Contained Object Handles: 0

Handle 0x0007, DMI type 3, 17 bytes
Chassis Information
	Manufacturer:                                 
	Type: Unknown
	Lock: Not Present
	Version:                         
	Serial Number:                                 
	Asset Tag:                                 
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Other
	Security Status: Other
	OEM Information: 0x00000000

Handle 0x0008, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: PRIMARY
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x0009, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: SECONDARY
	Internal Connector Type: On Board IDE
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000A, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: ATX_PWR
	Internal Connector Type: Other
	External Reference Designator: Not Specified
	External Connector Type: None
	Port Type: Other

Handle 0x000B, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE X16 SLOT
	Type: x16 PCI Express
	Current Usage: In Use
	Length: Short
	Characteristics:
		3.3 V is provided

Handle 0x000C, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE X1 SLOT 1
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x000D, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE X1 SLOT 2
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x000E, DMI type 9, 13 bytes
System Slot Information
	Designation: PCIE X1 SLOT 3
	Type: x1 PCI Express
	Current Usage: Available
	Length: Short
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x000F, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI SLOT 1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0010, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI SLOT 2
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 2
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0011, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI SLOT 3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		3.3 V is provided
		PME signal is supported
		SMBus signal is supported

Handle 0x0012, DMI type 10, 6 bytes
On Board Device Information
	Type: Video
	Status: Disabled
	Description: Intel(R) Extreme Graphics 3 Controller

Handle 0x0013, DMI type 10, 6 bytes
On Board Device Information
	Type: Ethernet
	Status: Enabled
	Description: Intel (R) 82562 Ethernet Device

Handle 0x0014, DMI type 10, 6 bytes
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: Intel(R) Azalia Audio Device

Handle 0x0015, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x0016, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0017, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 8 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x0018, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0017
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: J6H1
	Bank Locator: CHAN A DIMM 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0x7F98000000000000
	Serial Number: 0x6C2F674F
	Asset Tag: Unknown
	Part Number: 0x000000000000000000000000000000000000

Handle 0x0019, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0018
	Memory Array Mapped Address Handle: 0x001E
	Partition Row Position: 1
	Interleave Position: 1
	Interleaved Data Depth: 1

Handle 0x001A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0017
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: J6H2
	Bank Locator: CHAN A DIMM 1
	Type: DDR2
	Type Detail: None
	Speed: Unknown
	Manufacturer: NO DIMM
	Serial Number: NO DIMM
	Asset Tag: NO DIMM
	Part Number: NO DIMM

Handle 0x001B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0017
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: None
	Locator: J6J1
	Bank Locator: CHAN B DIMM 0
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz (1.5 ns)
	Manufacturer: 0x7F98000000000000
	Serial Number: 0x6C2F724F
	Asset Tag: Unknown
	Part Number: 0x000000000000000000000000000000000000

Handle 0x001C, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x001B
	Memory Array Mapped Address Handle: 0x001E
	Partition Row Position: 2
	Interleave Position: 2
	Interleaved Data Depth: 1

Handle 0x001D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0017
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: None
	Locator: J6J2
	Bank Locator: CHAN B DIMM 1
	Type: DDR2
	Type Detail: None
	Speed: Unknown
	Manufacturer: NO DIMM
	Serial Number: NO DIMM
	Asset Tag: NO DIMM
	Part Number: NO DIMM

Handle 0x001E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0017
	Partition Width: 0

Handle 0x001F, DMI type 187, 9 bytes
OEM-specific Type
	Header and Data:
		BB 09 1F 00 18 00 03 9B 02

Handle 0x0020, DMI type 187, 9 bytes
OEM-specific Type
	Header and Data:
		BB 09 20 00 1B 00 03 9B 02

Handle 0x0021, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 21 00 5A 5A

Handle 0xFEFF, DMI type 127, 4 bytes
End Of Table


--sm4nu43k4a2Rpi4c--
