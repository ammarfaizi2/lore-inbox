Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVBOQS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVBOQS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVBOQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 11:18:59 -0500
Received: from postman.ripe.net ([193.0.0.199]:64444 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S261779AbVBOQPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 11:15:38 -0500
Message-ID: <42122054.8010408@colitti.com>
Date: Tue, 15 Feb 2005 17:16:20 +0100
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
References: <20050214211105.GA12808@elf.ucw.cz>	 <200502150605.11683.s0348365@sms.ed.ac.uk>  <4211E729.1090305@colitti.com> <1108482083.12031.10.camel@elrond.flymine.org>
In-Reply-To: <1108482083.12031.10.camel@elrond.flymine.org>
Content-Type: multipart/mixed;
 boundary="------------020107050707020103030607"
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_50,HOT_NASTY
X-RIPE-Spam-Status: U 0.500000 / -3.2
X-RIPE-Signature: d7b88472491378e821ec894304ea6ac4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107050707020103030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Garrett wrote:
>>I beg to differ: it works for me on 2.6.11-rc3 (even with the swsusp2 
>>patch). However, I need to use acpi_sleep=s3_bios, and I can't use 
>>radeonfb or it will lock up on resume.
> 
> Could you grab dmidecode from http://www.nongnu.org/dmidecode/ and
> provide the output? It'd be interesting to compare working with
> non-working machines. It might also be good to see lspci and acpidmp
> output.

Ok, here is the output from dmidecode (Debian package) and from lspci. I 
don't have acpidmp and I don't know where to get it, but if you think 
it's necessary I can download it if you tell me where to find it.


Cheers,
Lorenzo


--------------020107050707020103030607
Content-Type: text/plain;
 name="dmidecode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmidecode"

# dmidecode 2.5
SMBIOS 2.3 present.
31 structures occupying 1354 bytes.
Table at 0x000FF2EB.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: Hewlett-Packard
		Version: 68BDD Ver. F.0F
		Release Date: 07/23/2004
		Address: 0xE0000
		Runtime Size: 128 kB
		ROM Size: 1024 kB
		Characteristics:
			PCI is supported
			PC Card (PCMCIA) is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			Boot from CD is supported
			Selectable boot is supported
			EDD is supported
			3.5"/720 KB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			ACPI is supported
			USB legacy is supported
			AGP is supported
			LS-120 boot is supported
			Smart battery is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: Hewlett-Packard
		Product Name: HP Compaq nc6000 (DJ254A#ABB)   
		Version: F.0F
		Serial Number: XXXXXXXXXX                      
		UUID: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: Hewlett-Packard
		Product Name: 0890
		Version: 8051 Version 1A.19
		Serial Number: Not Specified
Handle 0x0003
	DMI type 3, 13 bytes.
	Chassis Information
		Manufacturer: Hewlett-Packard
		Type: Notebook
		Lock: Not Present
		Version: Not Specified
		Serial Number: XXXXXXXXXX                      
		Asset Tag:                 
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: External Interface Enabled
Handle 0x0004
	DMI type 4, 35 bytes.
	Processor Information
		Socket Designation: U10
		Type: Central Processor
		Family: Pentium M
		Manufacturer: Intel(R)
		ID: XX XX XX XX XX XX XX XX
		Signature: Type 0, Family 6, Model 9, Stepping 5
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			SEP (Fast system call)
			MTRR (Memory type range registers)
			PGE (Page global enable)
			MCA (Machine check architecture)
			CMOV (Conditional move instruction supported)
			PAT (Page attribute table)
			CLFSH (CLFLUSH instruction supported)
			DS (Debug store)
			ACPI (ACPI supported)
			MMX (MMX technology supported)
			FXSR (Fast floating-point save and restore)
			SSE (Streaming SIMD extensions)
			SSE2 (Streaming SIMD extensions 2)
			TM (Thermal monitor supported)
			SBF (Signal break on FERR)
		Version: Intel(R) Pentium(R) M processor 1400MHz        
		Voltage: 1.8 V
		External Clock: 100 MHz
		Max Speed: 1400 MHz
		Current Speed: 1400 MHz
		Status: Populated, Enabled
		Upgrade: None
		L1 Cache Handle: 0x0005
		L2 Cache Handle: 0x0006
		L3 Cache Handle: Not Provided
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x0005
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 64 KB
		Maximum Size: 64 KB
		Supported SRAM Types:
			Burst
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: Unknown
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0006
	DMI type 7, 19 bytes.
	Cache Information
		Socket Designation: Internal L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 1024 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Burst
		Installed SRAM Type: Burst
		Speed: Unknown
		Error Correction Type: None
		System Type: Unified
		Associativity: 4-way Set-associative
Handle 0x0007
	DMI type 9, 13 bytes.
	System Slot Information
		Designation: PC CARD-Slot 0
		Type: 32-bit PC Card (PCMCIA)
		Current Usage: Available
		Length: Short
		ID: Adapter 0, Socket 0
		Characteristics:
			5.0 V is provided
			3.3 V is provided
			PC Card-16 is supported
			Cardbus is supported
			Modem ring resume is supported
			PME signal is supported
Handle 0x0008
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: www.compaq.com
Handle 0x0009
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			en|US|iso8859-1
		Currently Installed Language: en|US|iso8859-1
Handle 0x000A
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: System Memory
		Error Correction Type: None
		Maximum Capacity: 1 GB
		Error Information Handle: No Error
		Number Of Devices: 2
Handle 0x000B
	DMI type 16, 15 bytes.
	Physical Memory Array
		Location: System Board Or Motherboard
		Use: Flash Memory
		Error Correction Type: None
		Maximum Capacity: 1 MB
		Error Information Handle: Not Provided
		Number Of Devices: 1
Handle 0x000C
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000A
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: None
		Locator: DIMM #1
		Bank Locator: 030B2C25
		Type: DDR
		Type Detail: Synchronous
		Speed: 142 MHz (7.0 ns)
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000D
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000A
		Error Information Handle: No Error
		Total Width: 64 bits
		Data Width: 64 bits
		Size: 256 MB
		Form Factor: SODIMM
		Set: None
		Locator: DIMM #2
		Bank Locator: 051FD180
		Type: DDR
		Type Detail: Synchronous
		Speed: 142 MHz (7.0 ns)
		Manufacturer: Not Specified
		Serial Number: XXXXXXXXXXXX-XXXXX
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000E
	DMI type 17, 27 bytes.
	Memory Device
		Array Handle: 0x000B
		Error Information Handle: Not Provided
		Total Width: 8 bits
		Data Width: 8 bits
		Size: 1024 kB
		Form Factor: Chip
		Set: None
		Locator: SST49F008A
		Bank Locator: Not Specified
		Type: Flash
		Type Detail: Non-Volatile
		Speed: Unknown
		Manufacturer: Not Specified
		Serial Number: Not Specified
		Asset Tag: Not Specified
		Part Number: Not Specified
Handle 0x000F
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 512 MB
		Physical Array Handle: 0x000A
		Partition Width: 0
Handle 0x0010
	DMI type 19, 15 bytes.
	Memory Array Mapped Address
		Starting Address: 0x000FFFF0000
		Ending Address: 0x001000003FF
		Range Size: 65 kB
		Physical Array Handle: 0x000B
		Partition Width: 0
Handle 0x0011
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00000000000
		Ending Address: 0x0000FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000C
		Memory Array Mapped Address Handle: 0x000F
		Partition Row Position: 1
Handle 0x0012
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x00010000000
		Ending Address: 0x0001FFFFFFF
		Range Size: 256 MB
		Physical Device Handle: 0x000D
		Memory Array Mapped Address Handle: 0x000F
		Partition Row Position: 2
Handle 0x0013
	DMI type 20, 19 bytes.
	Memory Device Mapped Address
		Starting Address: 0x000FFFF0000
		Ending Address: 0x001000003FF
		Range Size: 65 kB
		Physical Device Handle: 0x000E
		Memory Array Mapped Address Handle: 0x0010
		Partition Row Position: 1
Handle 0x0014
	DMI type 21, 7 bytes.
	Built-in Pointing Device
		Type: Touch Pad
		Interface: PS/2
		Buttons: 2
Handle 0x0015
	DMI type 22, 26 bytes.
	Portable Battery
		Location: Primary
		Manufacturer: Hewlett-Packard
		Manufacture Date: 12/12/2003
		Serial Number: 00001       
		Name: Not Specified
		Chemistry: Lithium Ion
		Design Capacity: 2700 mWh
		Design Voltage: 14400 mV
		SBDS Version: Not Specified
		Maximum Error: 0%
		OEM-specific Information: 0x00000000
Handle 0x0016
	DMI type 126, 26 bytes.
	Inactive
Handle 0x0017
	DMI type 24, 5 bytes.
	Hardware Security
		Power-On Password Status: Disabled
		Keyboard Password Status: Disabled
		Administrator Password Status: Disabled
		Front Panel Reset Status: Not Implemented
Handle 0x0018
	DMI type 28, 20 bytes.
	Temperature Probe
		Description: Not Specified
		Location: Processor
		Status: OK
		Maximum Value: 100.0 deg C
		Minimum Value 0.0 deg C
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x0019
	DMI type 28, 20 bytes.
	Temperature Probe
		Description: Not Specified
		Location: Add-in Card
		Status: OK
		Maximum Value: 100.0 deg C
		Minimum Value 0.0 deg C
		Resolution: Unknown
		Tolerance: Unknown
		Accuracy: Unknown
		OEM-specific Information: 0x00000000
Handle 0x001A
	DMI type 32, 11 bytes.
	System Boot Information
		Status: No errors detected
Handle 0x0080
	DMI type 128, 114 bytes.
	OEM-specific Type
		Header and Data:
			80 72 80 00 21 4B 45 4E 01 10 44 00 0C 00 00 00
			00 00 00 00 02 00 00 00 00 82 02 14 00 01 02 03
			04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13
			03 20 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D
			0E 0F 10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D
			1E 1F 04 12 00 01 02 03 04 05 06 07 08 09 0A 0B
			0C 0D 0E 0F 10 11 09 0A 00 00 00 64 64 00 00 00
			64 64
Handle 0x0085
	DMI type 133, 34 bytes.
	OEM-specific Type
		Header and Data:
			85 22 85 00 01 30 11 1F 0D CE 0B 02 00 6E 00 15
			00 24 30 B2 00 5C 2B 02 80 00 00 00 0D 10 13 10
			05 10
		Strings:
			00001 12/12/2003
			HP                
Handle 0x0086
	DMI type 126, 34 bytes.
	Inactive
Handle 0x001B
	DMI type 127, 4 bytes.
	End Of Table

--------------020107050707020103030607
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
0000:02:04.0 Ethernet controller: Atheros Communications, Inc. AR5212 802.11abg NIC (rev 01)
0000:02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
0000:02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
0000:02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay Accelerator
0000:02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus MultiMediaBay Controller
0000:02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705M_2 Gigabit Ethernet (rev 03)

--------------020107050707020103030607--
