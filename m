Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755243AbWKMTsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbWKMTsb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755244AbWKMTsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:48:31 -0500
Received: from ext-nj2ut-7.online-age.net ([64.14.54.237]:19299 "EHLO
	ext-nj2ut-7.online-age.net") by vger.kernel.org with ESMTP
	id S1755243AbWKMTsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:48:30 -0500
Date: Mon, 13 Nov 2006 20:48:05 +0100
From: Karl Kiniger <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Subject: laptop (Quanta) does not power off
Message-ID: <20061113194805.GA17755@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-GEHealthcare-MailScanner: Found to be clean
X-GEHealthcare-MailScanner-From: karl.kiniger@med.ge.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this laptop - it is a quite new one from Quanta - running an 
uptodate Fedora 6 does not power off after a halt -p.

The last message displayed is: "acpi power off" and then I have to
press the power button for some seconds to really power off.

(I have already tried a vanilla kernel 2.6.18 - same result)

Any help is very welcome since it is easy to forget about that feature.

Greetings,
Karl

============ lspci -v ==================

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 04)
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: c1000000-c7ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c8000000-c80fffff
	Prefetchable memory behind bridge: 0000000052000000-0000000052000000
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 233
	I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 50
	I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at 1840 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 233
	Memory at c0004000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=0a, sec-latency=216
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c8100000-c81fffff
	Prefetchable memory behind bridge: 0000000050000000-0000000051f00000
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 0, IRQ 185
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1880 [size=16]

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: medium devsel, IRQ 50
	I/O ports at 18e0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce Go 6600] (rev a2) (prog-if 00 [VGA])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at c4000000 (32-bit, non-prefetchable) [size=64M]
	Memory at d0000000 (64-bit, prefetchable) [size=128M]
	Memory at c1000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at c2000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 19)
	Subsystem: QUANTA Computer Inc Unknown device 0733
	Flags: bus master, fast devsel, latency 0, IRQ 58
	Memory at c8000000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at 2000 [size=256]
	[virtual] Expansion ROM at 52000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

06:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)
	Subsystem: Intel Corporation Unknown device 2702
	Flags: bus master, medium devsel, latency 32, IRQ 177
	Memory at c8106000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

06:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 168, IRQ 169
	Memory at c8107000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-51fff000 (prefetchable)
	Memory window 1: 54000000-55fff000
	I/O window 0: 00003000-000030ff
	I/O window 1: 00003400-000034ff
	16-bit legacy interface ports at 0001

06:09.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 32, IRQ 169
	Memory at c8108000 (32-bit, non-prefetchable) [size=2K]
	Memory at c8100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

06:09.3 Mass storage controller: Texas Instruments PCIxx21 Integrated FlashMedia Controller
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 57, IRQ 10
	Memory at c8104000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [44] Power Management version 2

06:09.4 Class 0805: Texas Instruments PCI6411/6421/6611/6621/7411/7421/7611/7621 Secure Digital Controller
	Subsystem: QUANTA Computer Inc Unknown device 0748
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at c8108800 (32-bit, non-prefetchable) [size=256]
	Memory at c8108900 (32-bit, non-prefetchable) [size=256]
	Memory at c8108a00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2


============== dmidecode ======================================

# dmidecode 2.7
SMBIOS 2.31 present.
36 structures occupying 1083 bytes.
Table at 0x000DC010.

Handle 0x0000, DMI type 0, 20 bytes.
BIOS Information
	Vendor: QCI    
	Version: Q3B61  
	Release Date: 09/07/05
	Address: 0xE59D0
	Runtime Size: 108080 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		ACPI is supported
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes.
System Information
	Manufacturer: Quanta inc
	Product Name: MW1/HW1         
	Version: Not Applicable
	Serial Number: MW1TFCCZP6070002      
	UUID: 80B1DAC6-5A64-0010-A750-7D00FD004F00
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
	Manufacturer: Quanta inc
	Product Name: MW1/HW1         
	Version: Not Applicable
	Serial Number: MW1TFCCZP6070002      

Handle 0x0003, DMI type 3, 21 bytes.
Chassis Information
	Manufacturer:     ta inc
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: None
	Asset Tag: No Asset Tag  XXX                
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000
	Heigth: 52 U
	Number Of Power Cords: 18
	Contained Elements: 0

Handle 0x0004, DMI type 4, 35 bytes.
Processor Information
	Socket Designation: U1
	Type: Central Processor
	Family: Unknown
	Manufacturer: Intel
	ID: D6 06 00 00 BF FB E9 AF
	Version: A0
	Voltage: 3.3 V
	External Clock: 400 MHz
	Max Speed: 1800 MHz
	Current Speed: 1800 MHz
	Status: Populated, Enabled
	Upgrade: Slot 1
	L1 Cache Handle: 0x0008
	L2 Cache Handle: 0x0009
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 5, 20 bytes.
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 1024 MB
	Maximum Total Memory Size: 2048 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		FPM
		EDO
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 2
		0x0006
		0x0007
	Enabled Error Correcting Capabilities:
		Unknown

Handle 0x0006, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: M1
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Single-bank Connection)
	Enabled Size: 512 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0007, DMI type 6, 12 bytes.
Memory Module Information
	Socket Designation: M2
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: DIMM SDRAM
	Installed Size: 512 MB (Single-bank Connection)
	Enabled Size: 512 MB (Single-bank Connection)
	Error Status: OK

Handle 0x0008, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 16 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x0009, DMI type 7, 19 bytes.
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: External
	Installed Size: 2048 KB
	Maximum Size: 512 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000A, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J19
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000B, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J23
	Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000C, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J11
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000D, DMI type 8, 9 bytes.
Port Connector Information
	Internal Reference Designator: J12
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000E, DMI type 9, 13 bytes.
System Slot Information
	Designation: PCI Slot J11
	Type: 32-bit PCI
	Current Usage: Unknown
	Length: Long
	ID: 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x000F, DMI type 10, 6 bytes.
On Board Device Information
	Type: Sound
	Status: Disabled
	Description: ADI

Handle 0x0010, DMI type 11, 5 bytes.
OEM Strings
	String 1: This is the Intel Alviso
	String 2: Chipset CRB Platform

Handle 0x0011, DMI type 12, 5 bytes.
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0012, DMI type 15, 29 bytes.
System Event Log
	Area Length: 16 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x00000001
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0013, DMI type 16, 15 bytes.
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 3 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0014, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0013
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 1
	Locator: M1
	Bank Locator: Bank 0
	Type: DDR
	Type Detail: Synchronous
	Speed: 533 MHz (1.9 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0015, DMI type 17, 27 bytes.
Memory Device
	Array Handle: 0x0013
	Error Information Handle: No Error
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 512 MB
	Form Factor: DIMM
	Set: 1
	Locator: DIMM 2
	Bank Locator: Bank 1
	Type: DDR
	Type Detail: Synchronous
	Speed: 533 MHz (1.9 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0016, DMI type 19, 15 bytes.
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Array Handle: 0x0013
	Partition Width: 0

Handle 0x0017, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0001FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0014
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0018, DMI type 20, 19 bytes.
Memory Device Mapped Address
	Starting Address: 0x00020000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 512 MB
	Physical Device Handle: 0x0015
	Memory Array Mapped Address Handle: 0x0016
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0019, DMI type 23, 13 bytes.
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x001A, DMI type 24, 5 bytes.
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x001B, DMI type 25, 9 bytes.
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x001C, DMI type 26, 20 bytes.
Voltage Probe
	Description: Voltage Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001D, DMI type 27, 12 bytes.
Cooling Device
	Temperature Probe Handle: 0x001E
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x001E, DMI type 28, 20 bytes.
Temperature Probe
	Description: Temperature Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x001F, DMI type 29, 20 bytes.
Electrical Current Probe
	Description: Electrical Current Probe
	Location: Processor
	Status: OK
	Maximum Value: Unknown
	Minimum Value: Unknown
	Resolution: Unknown
	Tolerance: Unknown
	Accuracy: Unknown
	OEM-specific Information: 0x00000000

Handle 0x0020, DMI type 30, 6 bytes.
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0021, DMI type 32, 20 bytes.
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x0022, DMI type 136, 8 bytes.
OEM-specific Type
	Header and Data:
		88 08 22 00 FF FF 00 00
	Strings:
		..#

Handle 0x0023, DMI type 127, 4 bytes.
End Of Table

-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
