Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWH2MzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWH2MzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWH2MzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:55:22 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14457 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964795AbWH2MzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:55:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGKZfwOV2wKSQ5W42CUcBsqQct1NWmcNklV+wuIvNK2P5CdPTHSuc7IeOwrzKR8cxswUcYXySbwoNdJ7VFCo9i6qsY6Bcw1sD1OgQp6VRgEEGNrIZKHMFj74uVIzsd7cSWn1E3z/B0Lmd2t6tHBcR1aXqBmiyX3dTuUTVPnTUBg=
Message-ID: <85e0e3140608290555k31aadba5l8ecf814bae0a7484@mail.gmail.com>
Date: Tue, 29 Aug 2006 18:55:20 +0600
From: Niklaus <niklaus@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: SDRAM or DDRAM in linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1156849696.6271.99.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <85e0e3140608281040k61305f88m3f6cd4fcfddadaca@mail.gmail.com>
	 <85e0e3140608290004u94da11dr99c4dbcc0e417d7d@mail.gmail.com>
	 <1156849696.6271.99.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Maw, 2006-08-29 am 12:34 +0530, ysgrifennodd Niklaus:
> > 1) How do i find out when the machine is online , if it is SDRAM or
> > DDRAM. I tried dmidecode utility but i was not sure about the type.
> > Can someone help me out by pasting the output for both DDR and SDRAM
> > in dmidecode or similar.
>
> Except for very high quality server boxes don't trust the dmidecode data
> for the RAM. Get the motherboard/system name from dmidecode then look it
> up manually
>
Can you tell anything about it ? I have IBM x-series 206 server. Here
is the dmidecode information. Is SDRAM or DDRAM installed on it. It
would be great if you can tell me where to look.

# dmidecode 2.8
SMBIOS 2.33 present.
46 structures occupying 1419 bytes.
Table at 0x0FF77000.

Handle 0x0000, DMI type 0, 20 bytes
BIOS Information
	Vendor: IBM
	Version: -[KEE124AUS-1.24]-
	Release Date: 08/05/2004
	Address: 0xE0F40
	Runtime Size: 127168 bytes
	ROM Size: 1024 kB
	Characteristics:
		ISA is supported
		PCI is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		5.25"/360 KB floppy services are supported (int 13h)
		5.25"/1.2 MB floppy services are supported (int 13h)
		3.5"/720 KB floppy services are supported (int 13h)
		3.5"/2.88 MB floppy services are supported (int 13h)
		Print screen service is supported (int 5h)
		8042 keyboard services are supported (int 9h)
		Serial services are supported (int 14h)
		Printer services are supported (int 17h)
		CGA/mono video services are supported (int 10h)
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported

Handle 0x0001, DMI type 1, 25 bytes
System Information
	Manufacturer: IBM CORPORATION
	Product Name: -[848225X]-
	Version: IBM CORPORATION
	Serial Number: 99N0186
	UUID: A175F69D-0042-9D11-ABCA-0E7E66E64D8F
	Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: IBM
	Product Name: M71IX
	Version: -1
	Serial Number: J1XGV49W1PF

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: IBM
	Type: Other
	Lock: Not Present
	Version: N/A
	Serial Number: 123456
	Asset Tag: No Asset Tag
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00001234

Handle 0x0004, DMI type 4, 35 bytes
Processor Information
	Socket Designation: WMT478/NWD
	Type: Central Processor
	Family: Pentium 4
	Manufacturer: Intel
	ID: 34 0F 00 00 FF FB EB BF
	Signature: Type 0, Family 15, Model 3, Stepping 4
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: D0
	Voltage: 1.8 V
	External Clock: 200 MHz
	Max Speed: 3400 MHz
	Current Speed: 3000 MHz
	Status: Populated, Enabled
	Upgrade: Slot 1
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000B
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0005, DMI type 5, 22 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 256 MB
	Maximum Total Memory Size: 768 MB
	Supported Speeds:
		70 ns
		60 ns
	Supported Memory Types:
		FPM
		EDO
		DIMM
		SDRAM
	Memory Module Voltage: 3.3 V
	Associated Memory Slots: 3
		0x0006
		0x0007
		0x0008
	Enabled Error Correcting Capabilities:
		None

Handle 0x0006, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM0
	Bank Connections: 0 1
	Current Speed: Unknown
	Type: ECC DIMM SDRAM
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: See Event Log

Handle 0x0007, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM1
	Bank Connections: 2 3
	Current Speed: Unknown
	Type: ECC DIMM SDRAM
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: See Event Log

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM2
	Bank Connections: 4 5
	Current Speed: Unknown
	Type: ECC DIMM SDRAM
	Installed Size: Not Installed
	Enabled Size: Not Installed
	Error Status: See Event Log

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM3
	Bank Connections: 6 7
	Current Speed: Unknown
	Type: ECC DIMM SDRAM
	Installed Size: 256 MB (Single-bank Connection)
	Enabled Size: 256 MB (Single-bank Connection)
	Error Status: See Event Log

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 16 KB
	Maximum Size: 32 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Asynchronous
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Data
	Associativity: 4-way Set-associative

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 1024 KB
	Maximum Size: 1024 KB
	Supported SRAM Types:
		Burst
		Pipeline Burst
		Asynchronous
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Unknown
	System Type: Unknown
	Associativity: Unknown

Handle 0x000C, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J2A1
	Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
	External Reference Designator: COM 1
	External Connector Type: DB-9 male
	Port Type: Serial Port 16550A Compatible

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J3A1
	Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
	External Reference Designator: Parallel
	External Connector Type: DB-25 female
	Port Type: Parallel Port ECP/EPP

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: Keyboard
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: J1A1
	Internal Connector Type: None
	External Reference Designator: PS/2 Mouse
	External Connector Type: Circular DIN-8 male
	Port Type: Keyboard Port

Handle 0x0010, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #1 - J6B3
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 1
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0011, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #2 - J6B2
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 2
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0012, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #3 - J7B1
	Type: 32-bit PCI
	Current Usage: Available
	Length: Long
	ID: 3
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0013, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #4 - J7B1
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 4
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0014, DMI type 9, 13 bytes
System Slot Information
	Designation: PCI Slot #5 - J7B1
	Type: 32-bit PCI
	Current Usage: In Use
	Length: Long
	ID: 5
	Characteristics:
		5.0 V is provided
		3.3 V is provided

Handle 0x0015, DMI type 10, 14 bytes
On Board Device 1 Information
	Type: Ethernet
	Status: Enabled
	Description: 82547
On Board Device 2 Information
	Type: Ethernet
	Status: Enabled
	Description: 82541
On Board Device 3 Information
	Type: SCSI Controller
	Status: Enabled
	Description: 7901
On Board Device 4 Information
	Type: Video
	Status: Enabled
	Description: ATI
On Board Device 5 Information
	Type: Other
	Status: Enabled
	Description: IBM Automatic Server Restart - Machine Type 8482

Handle 0x0016, DMI type 11, 5 bytes
OEM Strings
	String 1: This is the Intel NBVV-G
	String 2: System Validation Platform

Handle 0x0017, DMI type 12, 5 bytes
System Configuration Options
	Option 1: Jumper settings can be described here.

Handle 0x0018, DMI type 15, 29 bytes
System Event Log
	Area Length: 1024 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Invalid
	Change Token: 0x00000029
	Header Format: Type 1
	Supported Log Type Descriptors: 3
	Descriptor 1: POST error
	Data Format 1: POST results bitmap
	Descriptor 2: Single-bit ECC memory error
	Data Format 2: Multiple-event
	Descriptor 3: Multi-bit ECC memory error
	Data Format 3: Multiple-event

Handle 0x0019, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: Single-bit ECC
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 4

Handle 0x001A, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: J5G2
	Bank Locator: DIMM 0
	Type: DDR
	Type Detail: Synchronous
	Speed: 133 MHz (7.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001B, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: J5G3
	Bank Locator: DIMM 1
	Type: DDR
	Type Detail: Synchronous
	Speed: 133 MHz (7.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001C, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: DIMM
	Set: 1
	Locator: J5H1
	Bank Locator: DIMM 2
	Type: DDR
	Type Detail: Synchronous
	Speed: 133 MHz (7.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001D, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0019
	Error Information Handle: No Error
	Total Width: 72 bits
	Data Width: 64 bits
	Size: 256 MB
	Form Factor: DIMM
	Set: 1
	Locator: J5H2
	Bank Locator: DIMM 3
	Type: DDR
	Type Detail: Synchronous
	Speed: 133 MHz (7.5 ns)
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x001E, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0000FFFFFFF
	Range Size: 256 MB
	Physical Array Handle: 0x0019
	Partition Width: 0

Handle 0x001F, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x001A
	Memory Array Mapped Address Handle: 0x001E
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0020, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000000003FF
	Range Size: 1 kB
	Physical Device Handle: 0x001B
	Memory Array Mapped Address Handle: 0x001E
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x0021, DMI type 23, 13 bytes
System Reset
	Status: Enabled
	Watchdog Timer: Present
	Boot Option: Do Not Reboot
	Boot Option On Limit: Do Not Reboot
	Reset Count: Unknown
	Reset Limit: Unknown
	Timer Interval: Unknown
	Timeout: Unknown

Handle 0x0022, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Unknown
	Administrator Password Status: Enabled
	Front Panel Reset Status: Unknown

Handle 0x0023, DMI type 25, 9 bytes
	System Power Controls
	Next Scheduled Power-on: 12-31 23:59:59

Handle 0x0024, DMI type 26, 20 bytes
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

Handle 0x0025, DMI type 27, 12 bytes
Cooling Device
	Temperature Probe Handle: 0x0026
	Type: Fan
	Status: OK
	OEM-specific Information: 0x00000000

Handle 0x0026, DMI type 28, 20 bytes
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

Handle 0x0027, DMI type 29, 20 bytes
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

Handle 0x0028, DMI type 30, 6 bytes
Out-of-band Remote Access
	Manufacturer Name: Intel
	Inbound Connection: Enabled
	Outbound Connection: Disabled

Handle 0x0029, DMI type 32, 20 bytes
System Boot Information
	Status: <OUT OF SPEC>

Handle 0x002A, DMI type 126, 4 bytes
Inactive

Handle 0x002B, DMI type 129, 28 bytes
OEM-specific Type
	Header and Data:
		81 1C 2B 00 01 01 02 01 00 00 00 01 00 00 18 01
		00 02 08 01 00 00 E0 01 01 03 10 01
	Strings:
		Intel_ASF_001
		Intel_ASF_001

Handle 0x002C, DMI type 127, 4 bytes
End Of Table

Handle 0x002D, DMI type 127, 4 bytes
End Of Table



>
>
