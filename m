Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTHYQA5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 12:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTHYQA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 12:00:57 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:14819 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S261973AbTHYQAV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 12:00:21 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Fwd: Re: via rhine network failure on 2.6.0-test4]
Date: Mon, 25 Aug 2003 08:59:42 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AECF@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Fwd: Re: via rhine network failure on 2.6.0-test4]
Thread-Index: AcNrHszGn77SwjU5RNab+pa5bAizVgAAcHCw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Steve French" <smfrench@austin.rr.com>, <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>
X-OriginalArrivalTime: 25 Aug 2003 15:59:43.0276 (UTC) FILETIME=[E5F6DEC0:01C36B21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No. Just boot the system with a kernel that works, then run those
commands. 

Thanks,
Jun
> -----Original Message-----
> From: Steve French [mailto:smfrench@austin.rr.com]
> Sent: Monday, August 25, 2003 8:37 AM
> To: linux-kernel@vger.kernel.org; Jeff Garzik; Nakajima, Jun
> Subject: [Fwd: Re: via rhine network failure on 2.6.0-test4]
> 
>    Do dmidecode and acpidump have to be run while booted to the
failing
> kernel (2.6.0-test4)?  If so I will need to rebuild test4 with ACPI on
> again tonight to get it to fail.  Otherwise here is the output from
> dmidecode run on the same system while booted to 2.4.    I will open a
> bug on bugzilla later today if I can track down my bugzilla id.
> 
> # dmidecode 2.2
> SMBIOS 2.2 present.
> 36 structures occupying 961 bytes.
> Table at 0x000F0800.
> Handle 0x0000
>     DMI type 0, 19 bytes.
>     BIOS Information
>         Vendor: Award Software International, Inc.
>         Version: 6.00 PG
>         Release Date: 11/13/2001
>         Address: 0xE0000
>         Runtime Size: 128 kB
>         ROM Size: 256 kB
>         Characteristics:
>             ISA is supported
>             PCI is supported
>             PNP is supported
>             APM is supported
>             BIOS is upgradeable
>             BIOS shadowing is allowed
>             ESCD support is available
>             Boot from CD is supported
>             Selectable boot is supported
>             BIOS ROM is socketed
>             EDD is supported
>             5.25"/360 KB floppy services are supported (int 13h)
>             5.25"/1.2 MB floppy services are supported (int 13h)
>             3.5"/720 KB floppy services are supported (int 13h)
>             3.5"/2.88 MB floppy services are supported (int 13h)
>             Print screen service is supported (int 5h)
>             8042 keyboard services are supported (int 9h)
>             Serial services are supported (int 14h)
>             Printer services are supported (int 17h)
>             CGA/mono video services are supported (int 10h)
>             ACPI is supported
>             USB legacy is supported
>             AGP is supported
>             LS-120 boot is supported
>             ATAPI Zip drive boot is supported
> Handle 0x0001
>     DMI type 1, 25 bytes.
>     System Information
>         Manufacturer: VIA Technologies, Inc.
>         Product Name: VT8366-8233
>         Version:
>         Serial Number:
>         UUID: Not Present
>         Wake-up Type: Power Switch
> Handle 0x0002
>     DMI type 2, 8 bytes.
>     Base Board Information
>         Manufacturer:
>         Product Name: VT8366-8233
>         Version:
>         Serial Number:
> Handle 0x0003
>     DMI type 3, 13 bytes.
>     Chassis Information
>         Manufacturer:
>         Type: Desktop
>         Lock: Not Present
>         Version:
>         Serial Number:
>         Asset Tag:
>         Boot-up State: Unknown
>         Power Supply State: Unknown
>         Thermal State: Unknown
>         Security Status: Unknown
> Handle 0x0004
>     DMI type 4, 32 bytes.
>     Processor Information
>         Socket Designation: Socket A
>         Type: Central Processor
>         Family: Duron
>         Manufacturer: AMD
>         ID: 62 06 00 00 FF F9 83 03
>         Signature: Type 0, Family 6, Model 6, Stepping 2
>         Flags:
>             FPU (Floating-point unit on-chip)
>             VME (Virtual mode extension)
>             DE (Debugging extension)
>             PSE (Page size extension)
>             TSC (Time stamp counter)
>             MSR (Model specific registers)
>             PAE (Physical address extension)
>             MCE (Machine check exception)
>             CX8 (CMPXCHG8 instruction supported)
>             SEP (Fast system call)
>             MTRR (Memory type range registers)
>             PGE (Page global enable)
>             MCA (Machine check architecture)
>             CMOV (Conditional move instruction supported)
>             PAT (Page attribute table)
>             PSE-36 (36-bit page size extension)
>             MMX (MMX technology supported)
>             FXSR (Fast floating-point save and restore)
>             SSE (Streaming SIMD extensions)
>         Version: AMD Athlon(tm) XP
>         Voltage: 3.3 V
>         External Clock: 133 MHz
>         Max Speed: 1500 MHz
>         Current Speed: 1600 MHz
>         Status: Populated, Enabled
>         Upgrade: ZIF Socket
>         L1 Cache Handle: 0x0009
>         L2 Cache Handle: 0x000A
>         L3 Cache Handle: No L3 Cache
> Handle 0x0005
>     DMI type 5, 22 bytes.
>     Memory Controller Information
>         Error Detecting Method: None
>         Error Correcting Capabilities:
>             None
>         Supported Interleave: One-way Interleave
>         Current Interleave: Four-way Interleave
>         Maximum Memory Module Size: 32 MB
>         Maximum Total Memory Size: 96 MB
>         Supported Speeds:
>             70 ns
>             60 ns
>         Supported Memory Types:
>             Standard
>             EDO
>         Memory Module Voltage: 5.0 V
>         Associated Memory Slots: 3
>             0x0006
>             0x0007
>             0x0008
>         Enabled Error Correcting Capabilities: None
> Handle 0x0006
>     DMI type 6, 12 bytes.
>     Memory Module Information
>         Socket Designation: A0
>         Bank Connections: 0 1
>         Current Speed: 60 ns
>         Type: Unknown
>         Installed Size: 512 MB (Double-bank Connection)
>         Enabled Size: 512 MB (Double-bank Connection)
>         Error Status: OK
> Handle 0x0007
>     DMI type 6, 12 bytes.
>     Memory Module Information
>         Socket Designation: A1
>         Bank Connections: 2
>         Current Speed: 60 ns
>         Type: Unknown
>         Installed Size: 512 MB (Single-bank Connection)
>         Enabled Size: 512 MB (Single-bank Connection)
>         Error Status: OK
> Handle 0x0008
>     DMI type 6, 12 bytes.
>     Memory Module Information
>         Socket Designation: A2
>         Bank Connections: None
>         Current Speed: 60 ns
>         Type: Unknown
>         Installed Size: Not Installed (Single-bank Connection)
>         Enabled Size: Not Installed (Single-bank Connection)
>         Error Status: OK
> Handle 0x0009
>     DMI type 7, 19 bytes.
>     Cache Information
>         Socket Designation: Internal Cache
>         Configuration: Enabled, Not Socketed, Level 1
>         Operational Mode: Write Back
>         Location: Internal
>         Installed Size: 128 KB
>         Maximum Size: 128 KB
>         Supported SRAM Types:
>             Synchronous
>         Installed SRAM Type: Synchronous
>         Speed: Unknown
>         Error Correction Type: Unknown
>         System Type: Unknown
>         Associativity: Unknown
> Handle 0x000A
>     DMI type 7, 19 bytes.
>     Cache Information
>         Socket Designation: External Cache
>         Configuration: Enabled, Not Socketed, Level 2
>         Operational Mode: Write Back
>         Location: External
>         Installed Size: 256 KB
>         Maximum Size: 256 KB
>         Supported SRAM Types:
>             Synchronous
>         Installed SRAM Type: Synchronous
>         Speed: Unknown
>         Error Correction Type: Unknown
>         System Type: Unknown
>         Associativity: Unknown
> Handle 0x000B
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: PRIMARY IDE
>         Internal Connector Type: On Board IDE
>         External Reference Designator:
>         External Connector Type: None
>         Port Type: Other
> Handle 0x000C
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: SECONDARY IDE
>         Internal Connector Type: On Board IDE
>         External Reference Designator:
>         External Connector Type: None
>         Port Type: Other
> Handle 0x000D
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: FDD
>         Internal Connector Type: On Board Floppy
>         External Reference Designator:
>         External Connector Type: None
>         Port Type: 8251 FIFO Compatible
> Handle 0x000E
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: COM1
>         Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
>         External Reference Designator:
>         External Connector Type: DB-9 male
>         Port Type: Serial Port 16450 Compatible
> Handle 0x000F
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: COM2
>         Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
>         External Reference Designator:
>         External Connector Type: DB-9 male
>         Port Type: Serial Port 16450 Compatible
> Handle 0x0010
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: LPT1
>         Internal Connector Type: DB-25 female
>         External Reference Designator:
>         External Connector Type: DB-25 female
>         Port Type: Parallel Port ECP/EPP
> Handle 0x0011
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: Keyboard
>         Internal Connector Type: PS/2
>         External Reference Designator:
>         External Connector Type: PS/2
>         Port Type: Keyboard Port
> Handle 0x0012
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: PS/2 Mouse
>         Internal Connector Type: PS/2
>         External Reference Designator:
>         External Connector Type: PS/2
>         Port Type: Mouse Port
> Handle 0x0013
>     DMI type 9, 13 bytes.
>     System Slot Information
>         Designation: PCI0
>         Type: 32-bit PCI
>         Current Usage: Available
>         Length: Long
>         ID: 1
>         Characteristics:
>             5.0 V is provided
>             PME signal is supported
> Handle 0x0014
>     DMI type 9, 13 bytes.
>     System Slot Information
>         Designation: PCI1
>         Type: 32-bit PCI
>         Current Usage: Available
>         Length: Long
>         ID: 2
>         Characteristics:
>             5.0 V is provided
>             PME signal is supported
> Handle 0x0015
>     DMI type 9, 13 bytes.
>     System Slot Information
>         Designation: PCI2
>         Type: 32-bit PCI
>         Current Usage: Available
>         Length: Long
>         ID: 3
>         Characteristics:
>             5.0 V is provided
>             PME signal is supported
> Handle 0x0016
>     DMI type 9, 13 bytes.
>     System Slot Information
>         Designation: PCI3
>         Type: 32-bit PCI
>         Current Usage: Available
>         Length: Long
>         ID: 4
>         Characteristics:
>             5.0 V is provided
>             PME signal is supported
> Handle 0x0017
>     DMI type 9, 13 bytes.
>     System Slot Information
>         Designation: AGP
>         Type: 32-bit AGP
>         Current Usage: Available
>         Length: Long
>         ID: 8
>         Characteristics:
>             5.0 V is provided
> Handle 0x0018
>     DMI type 8, 9 bytes.
>     Port Connector Information
>         Internal Reference Designator: USB
>         Internal Connector Type: None
>         External Reference Designator:
>         External Connector Type: Other
>         Port Type: USB
> Handle 0x0019
>     DMI type 13, 22 bytes.
>     BIOS Language Information
>         Installable Languages: 3
>             n|US|iso8859-1
>             n|US|iso8859-1
>             r|CA|iso8859-1
>         Currently Installed Language: n|US|iso8859-1
> Handle 0x001A
>     DMI type 16, 15 bytes.
>     Physical Memory Array
>         Location: System Board Or Motherboard
>         Use: System Memory
>         Error Correction Type: None
>         Maximum Capacity: 768 MB
>         Error Information Handle: Not Provided
>         Number Of Devices: 3
> Handle 0x001B
>     DMI type 17, 21 bytes.
>     Memory Device
>         Array Handle: 0x001A
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: 512 MB
>         Form Factor: DIMM
>         Set: None
>         Locator: A0
>         Bank Locator: Bank0/1
>         Type: Unknown
>         Type Detail: None
> Handle 0x001C
>     DMI type 17, 21 bytes.
>     Memory Device
>         Array Handle: 0x001A
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: 512 MB
>         Form Factor: DIMM
>         Set: None
>         Locator: A1
>         Bank Locator: Bank2/3
>         Type: Unknown
>         Type Detail: None
> Handle 0x001D
>     DMI type 17, 21 bytes.
>     Memory Device
>         Array Handle: 0x001A
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: No Module Installed
>         Form Factor: DIMM
>         Set: None
>         Locator: A2
>         Bank Locator: Bank4/5
>         Type: Unknown
>         Type Detail: None
> Handle 0x001E
>     DMI type 19, 15 bytes.
>     Memory Array Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x0003FFFFFFF
>         Range Size: 1 GB
>         Physical Array Handle: 0x001A
>         Partition Width: 0
> Handle 0x001F
>     DMI type 20, 19 bytes.
>     Memory Device Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x0001FFFFFFF
>         Range Size: 512 MB
>         Physical Device Handle: 0x001B
>         Memory Array Mapped Address Handle: 0x001E
>         Partition Row Position: 1
> Handle 0x0020
>     DMI type 20, 19 bytes.
>     Memory Device Mapped Address
>         Starting Address: 0x00020000000
>         Ending Address: 0x0003FFFFFFF
>         Range Size: 512 MB
>         Physical Device Handle: 0x001C
>         Memory Array Mapped Address Handle: 0x001E
>         Partition Row Position: 1
> Handle 0x0021
>     DMI type 20, 19 bytes.
>     Memory Device Mapped Address
>         Starting Address: 0x00000000000
>         Ending Address: 0x000000003FF
>         Range Size: 1 kB
>         Physical Device Handle: 0x001D
>         Memory Array Mapped Address Handle: 0x001E
>         Partition Row Position: 1
> Handle 0x0022
>     DMI type 32, 11 bytes.
>     System Boot Information
>         Status: No errors detected
> Handle 0x0023
>     DMI type 127, 4 bytes.
>     End Of Table
> 
> 
> Nakajima, Jun wrote:
> 
> >Following info would be crucial when figuring out the problem.
> >In this particular case, it looks like test4 attempted to enable
wrong
> >PCI interrupt links (i.e. LNKA and LNKD, the ones already enabled).
> >
> >Thanks,
> >Jun
> >----
> >
> >Please file a bug at http://bugzilla.kernel.org/
> >Category: Power Management
> >Componenet: ACPI
> >
> >Attach the output from dmidecide, available in /usr/sbin/, or here:
> >http://www.nongnu.org/dmidecode/
> >
> >Attach the output from acpidmp, available in /usr/sbin/, or in here
>
>http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.ta
r
> >.gz
> >
> >Attach the dmesg output showing the failure, if possible.
> >
> >
> >
> >
> >>-----Original Message-----
> >>From: Steve French [mailto:smfrench@austin.rr.com]
> >>Sent: Sunday, August 24, 2003 9:33 PM
> >>To: Jeff Garzik; linux-kernel@vger.kernel.org
> >>Subject: Re: via rhine network failure on 2.6.0-test4
> >>
> >>Looks like IRQ misassignment. Disabling ACPI on test4 got networking
> >>
> >>
> >to
> >
> >
> >>work again and the IRQ assignment is back to IRQ11 for via rhine.
The
> >>assigned interrupt in the failing case (linux-2.6.0-test4) was IRQ5
> >>instead of 11 which presumably it should be - see contents of
> >>/proc/interrupts in the failing case (test4):
> >>
> >>CPU0
> >>0: 1013475 XT-PIC timer
> >>1: 1309 XT-PIC i8042
> >>2: 0 XT-PIC cascade
> >>5: 0 XT-PIC eth0
> >>9: 0 XT-PIC acpi
> >>10: 0 XT-PIC uhci-hcd, uhci-hcd
> >>12: 30047 XT-PIC i8042
> >>14: 15193 XT-PIC ide0
> >>15: 24 XT-PIC ide1
> >>NMI: 0
> >>ERR: 13
> >>
> >>The excerpt from the good boot.msg (linux-2.6.0-test3) follows:
> >>
> >><6>ACPI: Subsystem revision 20030714
> >><4> tbxface-0117 [03] acpi_load_tables : ACPI Tables successfully
> >>
> >>
> >acquired
> >
> >
> >><4>Parsing all Control
> >>
> >>
> >>
>
>Methods:...............................................................
.
> >..
> >
> >
> >>................
> >><4>Table [DSDT](id F004) - 326 Objects with 29 Devices 82 Methods 21
> >>Regions
> >><4>ACPI Namespace successfully loaded at root c054f95c
> >><4>evxfevnt-0093 [04] acpi_enable : Transition to ACPI mode
successful
> >><4>evgpeblk-0748 [06] ev_create_gpe_block : GPE 00 to 15 [_GPE] 2
regs
> >>at 0000000000004020 on int 9
> >><4>Completing Region/Field/Buffer/Package
> >>initialization:..............................................
> >><4>Initialized 21/21 Regions 0/0 Fields 15/15 Buffers 10/10 Packages
> >>(334 nodes)
> >><4>Executing all Device _STA and_INI
> >>
> >>
> >methods:..............................
> >
> >
> >><4>30 Devices found containing: 30 _STA, 1 _INI methods
> >><6>ACPI: Interpreter enabled
> >><6>ACPI: Using PIC for interrupt routing
> >><6>ACPI: PCI Root Bridge [PCI0] (00:00)
> >><4>PCI: Probing PCI hardware (bus 00)
> >><7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> >><4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14
15)
> >><4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> >>disabled)
> >><4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> >>disabled)
> >><4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14
15)
> >><6>Linux Plug and Play Support v0.97 (c) Adam Belay
> >><5>SCSI subsystem initialized
> >><6>Linux Kernel Card Services 3.1.22
> >><6> options: [pci] [pm]
> >><6>drivers/usb/core/usb.c: registered new driver usbfs
> >><6>drivers/usb/core/usb.c: registered new driver hub
> >><4>ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
> >><4>ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> >><6>PCI: Using ACPI for IRQ routing
> >>
> >>
> >>The corresponding excerpt from the failing (linux-2.6.0-test4)
> >>
> >>
> >boot.msg
> >
> >
> >><6>ACPI: Subsystem revision 20030813
> >><6>ACPI: Interpreter enabled
> >><6>ACPI: Using PIC for interrupt routing
> >><6>ACPI: PCI Root Bridge [PCI0] (00:00)
> >><4>PCI: Probing PCI hardware (bus 00)
> >><7>PM: Adding info for No Bus:pci0000:00
> >><7>PM: Adding info for pci:0000:00:00.0
> >><7>PM: Adding info for pci:0000:00:01.0
> >><7>PM: Adding info for pci:0000:00:0e.0
> >><7>PM: Adding info for pci:0000:00:11.0
> >><7>PM: Adding info for pci:0000:00:11.1
> >><7>PM: Adding info for pci:0000:00:11.2
> >><7>PM: Adding info for pci:0000:00:11.3
> >><7>PM: Adding info for pci:0000:00:12.0
> >><7>PM: Adding info for pci:0000:01:00.0
> >><7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> >><4>ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14
15)
> >><4>ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> >>disabled)
> >><4>ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15,
> >>disabled)
> >><4>ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14
15)
> >><6>Linux Plug and Play Support v0.97 (c) Adam Belay
> >><5>SCSI subsystem initialized
> >><6>drivers/usb/core/usb.c: registered new driver usbfs
> >><6>drivers/usb/core/usb.c: registered new driver hub
> >><4>ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
> >><4>ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
> >><6>PCI: Using ACPI for IRQ routing
> >>
> >>
> >>
> >>
> >>Jeff Garzik wrote:
> >>
> >>
> >>
> >>>Steve French wrote:
> >>>
> >>>
> >>>
> >>>>The via rhine driver fails to get a dhcp address on my test system
> >>>>
> >>>>
> >on
> >
> >
> >>>>2.6.0-test4. ethereal shows no dhcp request leaving the box but
> >>>>ifconfig does show the device and it is detected in /proc/pci.
> >>>>Switching from the test3 vs. test4 snapshots built with equivalent
> >>>>configure options on the same system (SuSE 8.2) - test3 works but
> >>>>test4 does not. This is using essentially the default config for
> >>>>
> >>>>
> >both
> >
> >
> >>>>the test3 and test4 cases - the only changes are SMP disabled,
scsi
> >>>>devices disabled, Athlon, via-rhine enabled in network devices and
> >>>>
> >>>>
> >a
> >
> >
> >>>>handful of additional filesystems enabled, debug memory
allocations
> >>>>enabled. This is the first time in many months that I have seen
> >>>>problems with the via-rhine driver on 2.6
> >>>>
> >>>>Analyzing the code differences between 2.6.0-test3 and test4 (in
> >>>>via-rhine.c) is not very promising since the only line that has
> >>>>changed (kfree to free_netdev) is in the routine
> >>>>
> >>>>
> >via_rhine_remove_one
> >
> >
> >>>>that seems unlikely to cause problems sending data on the network.
> >>>>
> >>>>Ideas as to what could have caused the regression?
> >>>>
> >>>>
> >>>>
> >>>Does /proc/interrupts show any interrupts being received on your
eth
> >>>device? Does dmesg report any irq assignment problems, or similar?
> >>>
> >>>This sounds like ACPI or irq routing related.
> >>>
> >>>Jeff
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>

