Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTJ3WoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJ3WoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:44:16 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:61199 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S262906AbTJ3Wn7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:43:59 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: kernel-2.6.0-0.test9.cset20031029_0506.1 + oops
Date: Thu, 30 Oct 2003 23:41:55 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200310302341.56033.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.6.0 test9 kernel with all changeset until cset20031029_0506.

Linux version 2.6.0 (misiek@arm.t19.ds.pwr.wroc.pl) (gcc version 3.3.2 (PLD 
Linux)) #1 Wed Oct 29 11:46:40 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000cc000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
 BIOS-e820: 000000000eff0000 - 000000000eff8000 (ACPI data)
 BIOS-e820: 000000000eff8000 - 000000000f000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
239MB LOWMEM available.
On node 0 totalpages: 61424
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 57328 pages, LIFO batch:13
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa4a0
ACPI: RSDT (v001 AMIINT VIA_K7   0x00000010 MSFT 0x00000097) @ 0x0eff0000
ACPI: FADT (v001 AMIINT VIA_K7   0x00000011 MSFT 0x00000097) @ 0x0eff0030
ACPI: BOOT (v001 AMIINT VIA_K7   0x00000009 MSFT 0x00000097) @ 0x0eff00c0
ACPI: DSDT (v001    VIA TwisterK 0x00001000 INTL 0x02002024) @ 0x00000000
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=pld-2.6.0 ro root=303 console=ttyS0,57600n81 
console=tty0 video=vesafb:ywrap
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1532.943 MHz processor.
Console: colour dummy device 80x25
Memory: 239584k/245696k available (1717k kernel code, 5412k reserved, 683k 
data, 172k init, 0k highmem)
Calibrating delay loop... 3022.84 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 187k freed
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 1800+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb51, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: Embedded Controller [EC0] (gpe 5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 9 *10 11 14 15)
ACPI: Power Resource [FN10] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7710
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x673b, dseg 0xf0000
PnPBIOS: Unknown tag '0x82', length '22'.
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
vesafb: framebuffer at 0xd0000000, mapped to 0xcf809000, size 15296k
vesafb: mode is 1024x768x16, linelength=2048, pages=8
vesafb: protected mode interface info at c000:804e
vesafb: pmi: set display start = c00c80d8, set palette = c00c8121
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=7648
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Applying VIA southbridge workaround.
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 52 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK3021GAS, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Samsung CD-RW/DVD-ROM SN-324B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB), CHS=58140/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.0.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (romfs filesystem) readonly.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 172k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c133d400, I/O limit 4095Mb (mask 0xffffffff)
EXT3 FS on hda3, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Real Time Clock Driver v1.12
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU1] (supports C1 C2)
ACPI: Thermal Zone [THRM] (57 C)
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00faf80
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 86 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:74 (@c00fb590)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x1	startvid: 0xb
powernow:    FID: 0x6 (6.0x [798MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x7 (6.5x [864MHz])	VID: 0xd (1.350V)
powernow:    FID: 0x9 (7.5x [997MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xb (8.5x [1130MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xd (9.5x [1263MHz])	VID: 0xd (1.350V)
powernow:    FID: 0xf (10.5x [1396MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x1 (11.5x [1529MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 798 MHz. Maximum speed 1529 MHz.
input: PS/2 Generic Mouse on isa0060/serio2
PCI: Setting latency timer of device 0000:00:11.5 to 64
NET: Registered protocol family 23
IrCOMM protocol (Dag Brattli)
NTFS driver 2.1.4 [Flags: R/W MODULE].
NTFS volume version 3.1.
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xd000, 00:a0:cc:da:d9:3c, IRQ 9.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 41e1.
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
IrDA: Registered device irda0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:00:08.0 [1584:3000]
Yenta: ISA IRQ list 0800, PCI irq5
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x87f
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x400-0x40f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: irq 10, io base 0000d400
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: irq 10, io base 0000d800
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 1-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/input/hid-ff.c: hid_ff_init could not find initializer
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb-0000:00:11.2-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0324500(lo)
IPv6 over IPv4 tunneling driver
mtrr: 0xd0000000,0x1000000 overlaps existing 0xd0000000,0x800000
eth0: no IPv6 routers present
spurious 8259A interrupt: IRQ7.
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011dffb>] __might_sleep+0xab/0xf0
 [<c01433df>] __kmalloc+0x8f/0xa0
 [<c01b9a42>] acpi_os_allocate+0x10/0x14
 [<c01cd53c>] acpi_ut_callocate+0x2f/0x73
 [<c01c6fa7>] acpi_ns_internalize_name+0x43/0x77
 [<c01c68ce>] acpi_ns_evaluate_relative+0x32/0xad
 [<c010cf40>] do_IRQ+0xc0/0x140
 [<c010b4dc>] common_interrupt+0x18/0x20
 [<c01c6232>] acpi_evaluate_object+0x103/0x1a5
 [<c01d1066>] acpi_ec_query+0xa6/0xd3
 [<c01d116a>] acpi_ec_gpe_query+0xd7/0xf1
 [<c01bf163>] acpi_ev_gpe_dispatch+0x34/0x109
 [<c01bf02b>] acpi_ev_gpe_detect+0xc2/0x110
 [<c01bdbff>] acpi_ev_sci_xrupt_handler+0x13/0x1c
 [<c01b9b85>] acpi_irq+0xf/0x1a
 [<c010cbbb>] handle_IRQ_event+0x3b/0x70
 [<c01b9b76>] acpi_irq+0x0/0x1a
 [<c010cf16>] do_IRQ+0x96/0x140
 [<c010b4dc>] common_interrupt+0x18/0x20
 [<d07b4257>] acpi_processor_idle+0xe9/0x1e5 [processor]
 [<c0105000>] rest_init+0x0/0x60
 [<c01090e4>] cpu_idle+0x34/0x40
 [<c035c735>] start_kernel+0x185/0x1c0
 [<c035c480>] unknown_bootoption+0x0/0x100

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011dffb>] __might_sleep+0xab/0xf0
 [<c01433df>] __kmalloc+0x8f/0xa0
 [<c01b9a42>] acpi_os_allocate+0x10/0x14
 [<c01cd53c>] acpi_ut_callocate+0x2f/0x73
 [<c01c6fa7>] acpi_ns_internalize_name+0x43/0x77
 [<c01c68ce>] acpi_ns_evaluate_relative+0x32/0xad
 [<c010cf40>] do_IRQ+0xc0/0x140
 [<c010b4dc>] common_interrupt+0x18/0x20
 [<c01c6232>] acpi_evaluate_object+0x103/0x1a5
 [<c01d1066>] acpi_ec_query+0xa6/0xd3
 [<c01d116a>] acpi_ec_gpe_query+0xd7/0xf1
 [<c01bf163>] acpi_ev_gpe_dispatch+0x34/0x109
 [<c01bf02b>] acpi_ev_gpe_detect+0xc2/0x110
 [<c01bdbff>] acpi_ev_sci_xrupt_handler+0x13/0x1c
 [<c01b9b85>] acpi_irq+0xf/0x1a
 [<c010cbbb>] handle_IRQ_event+0x3b/0x70
 [<c01b9b76>] acpi_irq+0x0/0x1a
 [<c010cf16>] do_IRQ+0x96/0x140
 [<c010b4dc>] common_interrupt+0x18/0x20
 [<d07b4257>] acpi_processor_idle+0xe9/0x1e5 [processor]
 [<c0105000>] rest_init+0x0/0x60
 [<c01090e4>] cpu_idle+0x34/0x40
 [<c035c735>] start_kernel+0x185/0x1c0
 [<c035c480>] unknown_bootoption+0x0/0x100

process `host' is using obsolete setsockopt SO_BSDCOMPAT
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
eth0: no IPv6 routers present

Config and description of my hardware is available here:
http://lkml.org/lkml/2003/10/25/94

I'm using the same config + I've started using vesafb.
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
