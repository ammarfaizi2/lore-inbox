Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTEFLba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTEFLb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:31:28 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:13953 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S262569AbTEFLbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:31:09 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: acpi and irq routing on toshiba tecra 8100
Date: Tue, 6 May 2003 13:44:26 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305061344.26685.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On toshiba tecra 8100,

kernel : 2.5.69 and less.

I have to set "pci=noacpi", so it isn't a big issue, 
this case maybe some interrest for somebody  ?

and I confirm Yenta works fine now with 2.5.69. 

Regards


Nicolas.



May  5 20:25:08 tosh kernel: ACPI: Subsystem revision 20030418
May  5 20:25:08 tosh kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI 
Tables successfully acquired
May  5 20:25:08 tosh kernel: Parsing all Control 
Methods:..................................................................................................................................................................................................................
May  5 20:25:08 tosh kernel: Table [DSDT] - 598 Objects with 60 Devices 210 
Methods 5 Regions
May  5 20:25:08 tosh kernel: ACPI Namespace successfully loaded at root 
c037e23c
May  5 20:25:08 tosh kernel: evxfevnt-0093 [04] acpi_enable           : 
Transition to ACPI mode successful
May  5 20:25:08 tosh kernel: evgpeblk-0740 [06] ev_create_gpe_block   : GPE 
Block: [_GPE] 2 registers at 000000000000FE0C on interrupt 9
May  5 20:25:08 tosh kernel: evgpeblk-0745 [06] ev_create_gpe_block   : GPE 
Block defined as GPE 0x00 to GPE 0x0F
May  5 20:25:08 tosh kernel: evgpeblk-0262 [08] ev_save_method_info   : 
Registered GPE method _L0B as GPE number 0x0B
May  5 20:25:08 tosh kernel: evgpeblk-0262 [08] ev_save_method_info   : 
Registered GPE method _L09 as GPE number 0x09
May  5 20:25:08 tosh kernel: evgpeblk-0262 [08] ev_save_method_info   : 
Registered GPE method _L00 as GPE number 0x00
May  5 20:25:08 tosh kernel: evgpeblk-0262 [08] ev_save_method_info   : 
Registered GPE method _L08 as GPE number 0x08
May  5 20:25:08 tosh kernel: Executing all Device _STA and_INI methods:..  
uteval-0109: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node 
d7f20d68), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKB._STA] (Node d7f1d388), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKC._STA] (Node d7f1d868), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKD._STA] (Node d7f1dd48), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: ..............  uteval-0109: *** Error: No object 
was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node d7f18708), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.COM_._STA] (Node d7f131a8), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PRT_._STA] (Node d7f13988), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PRT1._STA] (Node d7f13e08), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: .  uteval-0109: *** Error: No object was returned 
from [\_SB_.PCI0.FNC0.PCC0._STA] (Node d7f12408), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: ..................................
May  5 20:25:08 tosh kernel: 57 Devices found containing: 48 _STA, 1 _INI 
methods
May  5 20:25:08 tosh kernel: Completing Region/Field/Buffer/Package 
initialization:..........................................
May  5 20:25:08 tosh kernel: Initialized 2/5 Regions 0/0 Fields 10/10 Buffers 
30/30 Packages (598 nodes)
May  5 20:25:08 tosh kernel: ACPI: Interpreter enabled
May  5 20:25:08 tosh kernel: ACPI: Using PIC for interrupt routing
May  5 20:25:08 tosh kernel:   uteval-0109: *** Error: No object was returned 
from [\_SB_.LNKE._PRS] (Node d7f1c408), AE_NOT_EXIST
May  5 20:25:08 tosh kernel: pci_link-0165 [07] acpi_pci_link_get_poss: Error 
evaluating _PRS
May  5 20:25:08 tosh kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
May  5 20:25:08 tosh kernel: PCI: Probing PCI hardware (bus 00)
May  5 20:25:08 tosh kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0._PRT]
May  5 20:25:08 tosh kernel: ACPI: Power Resource [PIHD] (on)
May  5 20:25:08 tosh kernel: ACPI: Power Resource [PMHD] (on)
May  5 20:25:08 tosh kernel: ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.PCI1._PRT]
May  5 20:25:08 tosh kernel: ACPI: Power Resource [PFAN] (off)
May  5 20:25:08 tosh kernel: block request queues:
May  5 20:25:08 tosh kernel:  128 requests per read queue
May  5 20:25:08 tosh kernel:  128 requests per write queue
May  5 20:25:08 tosh kernel:  8 requests per batch
May  5 20:25:08 tosh kernel:  enter congestion at 15
May  5 20:25:08 tosh kernel:  exit congestion at 17
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dc28]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:05.2
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin D of device 
00:05.2
May  5 20:25:08 tosh kernel: pci_link-0491 [19] acpi_pci_link_get_irq : 
Invalid link context
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:07.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:07.0
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d748]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:09.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:09.0
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f20b88]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0b.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:0b.0 - using IRQ 255
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d268]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0b.1
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin B of device 
00:0b.1 - using IRQ 255
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dc28]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0c.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:0c.0
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dc28]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 01:00.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
01:00.0
May  5 20:25:08 tosh kernel: PCI: Using ACPI for IRQ routing
May  5 20:25:08 tosh kernel: PCI: if you experience problems, try using option 
'pci=noacpi' or even 'acpi=off'
May  5 20:25:08 tosh kernel: Initializing RT netlink socket
May  5 20:25:08 tosh kernel: Enabling SEP on CPU 0
May  5 20:25:08 tosh kernel: VFS: Disk quotas dquot_6.5.1
May  5 20:25:08 tosh kernel: devfs: v1.22 (20021013) Richard Gooch 
(rgooch@atnf.csiro.au)
May  5 20:25:08 tosh kernel: devfs: boot_options: 0x1
May  5 20:25:08 tosh kernel: Initializing Cryptographic API
May  5 20:25:08 tosh kernel: Limiting direct PCI/PCI transfers.
May  5 20:25:08 tosh kernel: vesafb: framebuffer at 0xf0000000, mapped to 
0xd8808000, size 8192k
May  5 20:25:08 tosh kernel: vesafb: mode is 1024x768x16, linelength=2048, 
pages=4
May  5 20:25:08 tosh kernel: vesafb: protected mode interface info at 
c000:8751
May  5 20:25:08 tosh kernel: vesafb: scrolling: redraw
May  5 20:25:08 tosh kernel: EDID checksum failed, aborting
May  5 20:25:08 tosh kernel: EDID checksum failed, aborting
May  5 20:25:08 tosh kernel: vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
May  5 20:25:08 tosh kernel: fb0: VESA VGA frame buffer device
May  5 20:25:08 tosh kernel: Console: switching to colour frame buffer device 
128x48
May  5 20:25:08 tosh kernel: pty: 256 Unix98 ptys configured
May  5 20:25:08 tosh kernel: Linux agpgart interface v0.100 (c) Dave Jones
May  5 20:25:08 tosh kernel: agpgart: Detected Intel 440BX chipset
May  5 20:25:08 tosh kernel: agpgart: Maximum main memory to use for agp 
memory: 321M
May  5 20:25:08 tosh kernel: agpgart: AGP aperture is 256M @ 0xd0000000
May  5 20:25:08 tosh kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ 
sharing disabled
May  5 20:25:08 tosh kernel: tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
May  5 20:25:08 tosh kernel: Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
May  5 20:25:08 tosh kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
May  5 20:25:08 tosh kernel: PIIX4: IDE controller at PCI slot 00:05.1
May  5 20:25:08 tosh kernel: PIIX4: chipset revision 1
May  5 20:25:08 tosh kernel: PIIX4: not 100%% native mode: will probe irqs 
later
May  5 20:25:08 tosh kernel:     ide0: BM-DMA at 0xfff0-0xfff7, BIOS settings: 
hda:DMA, hdb:pio
May  5 20:25:08 tosh kernel:     ide1: BM-DMA at 0xfff8-0xffff, BIOS settings: 
hdc:DMA, hdd:pio
May  5 20:25:08 tosh kernel: hda: IC25N040ATCS05-0, ATA DISK drive
May  5 20:25:08 tosh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May  5 20:25:08 tosh kernel: hdc: CD-224E-B, ATAPI CD/DVD-ROM drive
May  5 20:25:08 tosh kernel: ide1 at 0x170-0x177,0x376 on irq 15
May  5 20:25:08 tosh kernel: hda: host protected area => 1
May  5 20:25:08 tosh kernel: hda: 78140160 sectors (40008 MB) w/7898KiB Cache, 
CHS=77520/16/63, UDMA(33)
May  5 20:25:08 tosh kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 
p7 p8 p9 p10 > p3 p4
May  5 20:25:08 tosh kernel: Console: switching to colour frame buffer device 
128x48
May  5 20:25:08 tosh kernel: mice: PS/2 mouse device common for all mice
May  5 20:25:08 tosh kernel: input: ImPS/2 Generic Wheel Mouse on 
isa0060/serio1
May  5 20:25:08 tosh kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
May  5 20:25:08 tosh kernel: input: AT Set 2 keyboard on isa0060/serio0
May  5 20:25:08 tosh kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May  5 20:25:08 tosh kernel: NET4: Linux TCP/IP 1.0 for NET4.0
May  5 20:25:08 tosh kernel: IP: routing cache hash table of 4096 buckets, 
32Kbytes
May  5 20:25:08 tosh kernel: TCP: Hash tables configured (established 32768 
bind 65536)
May  5 20:25:08 tosh kernel: Initializing IPsec netlink socket
May  5 20:25:08 tosh kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
May  5 20:25:08 tosh kernel: found reiserfs format "3.6" with standard journal
May  5 20:25:08 tosh kernel: Reiserfs journal params: device 
ide/host0/bus0/target0/lun0/par, size 8192, journal first block 18, max trans 
len 1024, max batch 900, max commit age 30, max trans age 3
0
May  5 20:25:08 tosh kernel: reiserfs: checking transaction log 
(ide/host0/bus0/target0/lun0/par) for (ide/host0/bus0/target0/lun0/par)
May  5 20:25:08 tosh kernel: Using r5 hash to sort names
May  5 20:25:08 tosh kernel: VFS: Mounted root (reiserfs filesystem) readonly.
May  5 20:25:08 tosh kernel: Mounted devfs on /dev
May  5 20:25:08 tosh kernel: Freeing unused kernel memory: 144k freed
May  5 20:25:08 tosh kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
May  5 20:25:08 tosh kernel: Real Time Clock Driver v1.11
May  5 20:25:08 tosh kernel: Adding 506008k swap on /dev/hda5.  Priority:-1 
extents:1
May  5 20:25:08 tosh kernel: ACPI: Processor [CPU0] (supports C1 C2)
May  5 20:25:08 tosh kernel: Toshiba Laptop ACPI Extras version 0.14
May  5 20:25:08 tosh kernel: ACPI: Thermal Zone [THRM] (64 C)
May  5 20:25:08 tosh kernel: ACPI: Fan [FAN] (off)
May  5 20:25:08 tosh kernel: ACPI: AC Adapter [ADP1] (on-line)
May  5 20:25:08 tosh kernel: ACPI: Battery Slot [BAT1] (battery present)
May  5 20:25:08 tosh kernel: ACPI: Battery Slot [BAT2] (battery absent)
May  5 20:25:08 tosh kernel: ACPI: Power Button (FF) [PWRF]
May  5 20:25:08 tosh kernel: ACPI: Lid Switch [LID]
May  5 20:25:08 tosh kernel: i2c-piix4 version 2.7.0 (20021208)
May  5 20:25:08 tosh kernel: piix4 smbus 00:05.3: Found Intel Corp. 
82371AB/EB/MB PIIX4  device
May  5 20:25:08 tosh kernel: drivers/usb/core/usb.c: registered new driver 
usbfs
May  5 20:25:08 tosh kernel: drivers/usb/core/usb.c: registered new driver hub
May  5 20:25:08 tosh kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host 
Controller Interface driver v2.0
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dc28]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:05.2
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin D of device 
00:05.2
May  5 20:25:08 tosh kernel: uhci-hcd 00:05.2: Intel Corp. 82371AB/EB/MB PIIX4
May  5 20:25:08 tosh kernel: uhci-hcd 00:05.2: irq 11, io base 0000ff80
May  5 20:25:08 tosh kernel: Please use the 'usbfs' filetype instead, the 
'usbdevfs' name is deprecated.
May  5 20:25:08 tosh kernel: uhci-hcd 00:05.2: new USB bus registered, 
assigned bus number 1
May  5 20:25:08 tosh kernel: drivers/usb/host/uhci-hcd.c: detected 2 ports
May  5 20:25:08 tosh kernel: uhci-hcd 00:05.2: root hub device address 1
May  5 20:25:08 tosh kernel: usb usb1: new device strings: Mfr=3, Product=2, 
SerialNumber=1
May  5 20:25:08 tosh kernel: usb usb1: Product: Intel Corp. 82371AB/EB/MB 
PIIX4
May  5 20:25:08 tosh kernel: usb usb1: Manufacturer: Linux 2.5.69 uhci-hcd
May  5 20:25:08 tosh kernel: usb usb1: SerialNumber: 00:05.2
May  5 20:25:08 tosh kernel: drivers/usb/core/usb.c: usb_hotplug
May  5 20:25:08 tosh kernel: usb usb1: usb_new_device - registering interface 
1-0:0
May  5 20:25:08 tosh kernel: drivers/usb/core/usb.c: usb_hotplug
May  5 20:25:08 tosh kernel: hub 1-0:0: usb_device_probe
May  5 20:25:08 tosh kernel: hub 1-0:0: usb_device_probe - got id
May  5 20:25:08 tosh kernel: hub 1-0:0: USB hub found
May  5 20:25:08 tosh kernel: hub 1-0:0: 2 ports detected
May  5 20:25:08 tosh kernel: hub 1-0:0: standalone hub
May  5 20:25:08 tosh kernel: hub 1-0:0: ganged power switching
May  5 20:25:08 tosh kernel: hub 1-0:0: global over-current protection
May  5 20:25:08 tosh kernel: hub 1-0:0: Port indicators are not supported
May  5 20:25:08 tosh kernel: hub 1-0:0: power on to power good time: 2ms
May  5 20:25:08 tosh kernel: hub 1-0:0: hub controller current requirement: 
0mA
May  5 20:25:08 tosh kernel: hub 1-0:0: local power source is good
May  5 20:25:08 tosh kernel: hub 1-0:0: no over-current condition exists
May  5 20:25:08 tosh kernel: hub 1-0:0: enabling power on all ports
May  5 20:25:08 tosh kernel: loop: loaded (max 8 devices)
May  5 20:25:08 tosh kernel: drivers/usb/host/uhci-hcd.c: ff80: suspend_hc
May  5 20:25:08 tosh kernel: Linux Kernel Card Services 3.1.22
May  5 20:25:08 tosh kernel:   options:  [pci] [cardbus] [pm]
May  5 20:25:08 tosh kernel: PCI: Enabling device 00:0b.0 (0000 -> 0002)
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f20b88]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0b.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:0b.0 - using IRQ 255
May  5 20:25:08 tosh kernel: Yenta IRQ list 04b0, PCI irq0
May  5 20:25:08 tosh kernel: Socket status: 30000020
May  5 20:25:08 tosh kernel: PCI: Enabling device 00:0b.1 (0000 -> 0002)
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1d268]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0b.1
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin B of device 
00:0b.1 - using IRQ 255
May  5 20:25:08 tosh kernel: Yenta IRQ list 04b0, PCI irq0
May  5 20:25:08 tosh kernel: Socket status: 30000007
May  5 20:25:08 tosh kernel: acpi_bus-0075 [20] acpi_bus_get_device   : Error 
getting context for object [d7f1dc28]
May  5 20:25:08 tosh kernel: pci_link-0485 [19] acpi_pci_link_get_irq : 
Invalid link device
May  5 20:25:08 tosh kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : 
Invalid IRQ link routing entry
May  5 20:25:08 tosh kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable 
to derive IRQ for device 00:0c.0
May  5 20:25:08 tosh kernel: ACPI: No IRQ known for interrupt pin A of device 
00:0c.0
May  5 20:25:08 tosh kernel: ymfpci: YMF744 at 0xefff8000 IRQ 11
May  5 20:25:08 tosh kernel: ac97_codec: AC97 Audio codec, id: AKM5 (Unknown)
May  5 20:25:08 tosh kernel: irda_init()
May  5 20:25:08 tosh kernel: IrCOMM protocol (Dag Brattli)
May  5 20:25:08 tosh kernel: CSLIP: code copyright 1989 Regents of the 
University of California
May  5 20:25:08 tosh kernel: PPP generic driver version 2.4.2
May  5 20:25:08 tosh kernel: PPP Deflate Compression module registered
May  5 20:25:08 tosh kernel: found reiserfs format "3.6" with standard journal

