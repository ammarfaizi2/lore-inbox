Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLPWiY>; Mon, 16 Dec 2002 17:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLPWiY>; Mon, 16 Dec 2002 17:38:24 -0500
Received: from mail.michigannet.com ([208.49.116.30]:51730 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S261934AbSLPWiR>; Mon, 16 Dec 2002 17:38:17 -0500
Date: Mon, 16 Dec 2002 17:46:08 -0500
From: Paul <set@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Oops 2.5.51] PnPBIOS: cat /proc/bus/pnp/escd
Message-ID: <20021216224608.GA29852@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021215230344.GE1432@squish.home.loc> <20021216135813.GD11616@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216135813.GD11616@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk>, on Mon Dec 16, 2002 [01:58:13 PM] said:
>  > 	'cat /proc/bus/pnp/escd' consistantly produces this:
> 
>  > EIP:    0088:[<00007b74>]    Not tainted
> 
> You blew up in BIOS code. Your BIOS has a crap PNPBIOS implementation.
> Send the output of dmidecode[1] and it can get added to the blacklist.
> 
> [1] http://people.redhat.com/arjanv/dmidecode.c
> 
> 		Dave
> 

	Hi;

DMI 2.0 present.
29 structures occupying 946 bytes.
DMI table at 0x000F545A.
Handle 0x0000
	DMI type 0, 18 bytes.
	BIOS Information Block
		Vendor: Award Software, Inc.
		Version: ASUS P5A-B ACPI BIOS Revision 1004 
		Release: 10/14/98
		BIOS base: 0xF0000
		ROM size: 64K
		Capabilities:
			Flags: 0x000000007FDBDE90
Handle 0x0001
	DMI type 1, 8 bytes.
	System Information Block
		Vendor: System Manufacturer
		Product: System Name
		Version: System Version
		Serial Number: SYS-1234567890
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor: ASUSTeK Computer INC.
		Product: P5A-B
		Version: REV 1.XX
		Serial Number: MB-1234567890
Handle 0x0003
	DMI type 3, 9 bytes.
	Chassis Information Block
		Vendor: Chassis Manufacture
		Chassis Type: Unknown
		Version: Chassis Version
		Serial Number: Chassis Serial Number
		Asset Tag: Asset-1234567890
Handle 0x0004
	DMI type 4, 26 bytes.
	Processor
		Socket Designation: SOCKET 7
		Processor Type: Central Processor
		Processor Family: K5 Family
		Processor Manufacturer: AMD
		Processor Version: AMD K6-2
Handle 0x0005
	DMI type 5, 27 bytes.
	Memory Controller
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM1-2  
		Banks: 0 1
		Speed: 70nS
		Type: EDO DIMM 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM2-1  
		Banks: 2 3
		Speed: 70nS
		Type: OTHER DIMM 
		Installed Size: 64Mbyte
		Enabled Size: 64Mbyte
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM2-2  
		Banks: 2 3
		Speed: 70nS
		Type: EDO DIMM 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM3-1  
		Banks: 4 5
		Speed: 70nS
		Type: EDO DIMM 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: DIMM3-2  
		Banks: 4 5
		Speed: 70nS
		Type: EDO DIMM 
		Installed Size: Not Installed
		Enabled Size: Not Installed
Handle 0x000C
	DMI type 7, 15 bytes.
	Cache
		Socket: L1 Cache
		L1 Internal Cache: write-back
		L1 Cache Size: 64K
		L1 Cache Maximum: 64K
		L1 Cache Type: 
Handle 0x000D
	DMI type 7, 15 bytes.
	Cache
		Socket: L2 Cache
		L2 External Cache: write-back
		L2 Cache Size: 1024K
		L2 Cache Maximum: 0K
		L2 Cache Type: Pipeline burst 
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator: COM A
		External Connector Type: DB-9 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Designator: COM B
		External Connector Type: DB-25 pin male
		Port Type: Serial Port 16650A Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PRINTER
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Designator: LPT
		External Connector Type: DB-25 pin female
		Port Type: Parallel Port ECP/EPP
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: KEY
		Internal Connector Type: None
		External Designator: KEYBOARD
		External Connector Type: Micro-DIN
		Port Type: Keyboard Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Designator: IDE-1
		External Connector Type: None
		Port Type: None
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Designator: IDE-2
		External Connector Type: None
		Port Type: None
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector
		Internal Designator: FLOPPY
		Internal Connector Type: On Board Floppy
		External Designator: FLOPPY
		External Connector Type: None
		Port Type: None
Handle 0x0015
	DMI type 9, 12 bytes.
	Card Slot
		Slot: PCI Slot1
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 
Handle 0x0016
	DMI type 9, 12 bytes.
	Card Slot
		Slot: PCI Slot2
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 5v 
Handle 0x0017
	DMI type 9, 12 bytes.
	Card Slot
		Slot: PCI Slot3
		Type: 32bit PCI 
		Status: Available.
		Slot Features: 5v Shared 
Handle 0x0018
	DMI type 9, 12 bytes.
	Card Slot
		Slot: ISA Slot1
		Type: 16bit ISA 
		Slot Features: 5v Shared 
Handle 0x0019
	DMI type 9, 12 bytes.
	Card Slot
		Slot: ISA Slot2
		Type: 16bit ISA 
		Slot Features: 5v 
Handle 0x001A
	DMI type 11, 5 bytes.
	OEM Data
		OEM String
Handle 0x001B
	DMI type 12, 5 bytes.
	Configuration Information
		System String
Handle 0x001C
	DMI type 13, 22 bytes.
	BIOS Language Information
Handle 0x0C49
	DMI type 0, 0 bytes.
	BIOS Information Block
		Vendor: 
		Version: 
		Release: 
		BIOS base: 0x00000
		ROM size: 0K
		Capabilities:
			Flags: 0x0000000000000000
	
