Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUENV3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUENV3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUENV3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:29:54 -0400
Received: from mailout01.ims-firmen.de ([213.174.32.96]:44214 "EHLO
	mailout01.ims-firmen.de") by vger.kernel.org with ESMTP
	id S262910AbUENV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:29:28 -0400
Subject: dma ripping
From: Daniele Bernardini <db@sqbc.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1084548566.12022.57.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 14 May 2004 17:29:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks, 

I am trying to get cd ripping to work on a freshly installed SuSE 9.1 on
IBM thinkpad R50 with dvdram drive. 

It works for a while and then hangs. At this point nothing short of a
reboot works. Ripping stop working when the message 
	cdrom: dropping to single frame dma
comes up. The system feels slow for a couple of seconds and then is back
to normal, but no ripping until next reboot

I am running the 2.6.4 compiled by SuSE.

Any idea?

Thanks

Daniele

P.S. keep up the great job :)



dmesg returns:

0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff60000 (usable)
 BIOS-e820: 000000007ff60000 - 000000007ff78000 (ACPI data)
 BIOS-e820: 000000007ff78000 - 000000007ff7a000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
128MB vmalloc/ioremap area available.
1151MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 524128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294752 pages, LIFO batch:16
DMI present.
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.
ACPI: RSDP (v002 IBM                                       ) @
0x000f6b40
ACPI: XSDT (v001 IBM    TP-1R    0x00002140  LTP 0x00000000) @
0x7ff6c263
ACPI: FADT (v003 IBM    TP-1R    0x00002140 IBM  0x00000001) @
0x7ff6c300
ACPI: SSDT (v001 IBM    TP-1R    0x00002140 MSFT 0x0100000e) @
0x7ff6c4b4
ACPI: ECDT (v001 IBM    TP-1R    0x00002140 IBM  0x00000001) @
0x7ff77e26
ACPI: TCPA (v001 IBM    TP-1R    0x00002140 PTL  0x00000001) @
0x7ff77e78
ACPI: BOOT (v001 IBM    TP-1R    0x00002140  LTP 0x00000001) @
0x7ff77fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00002140 MSFT 0x0100000e) @
0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: local apic disabled
Built 1 zonelists
Kernel command line: root=/dev/hda3 vga=0x342 desktop resume=/dev/hda2
splash=verbose
bootsplash: verbose mode.
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
CKRM Initialized
Detected 1694.770 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Memory: 2074512k/2096512k available (1970k kernel code, 20828k reserved,
677k data, 212k init, 1179008k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3358.72 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security
failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Looking for DSDT in initrd ...No customized DSDT found in initrd!
Freeing initrd memory: 1057k freed
CPU:     After generic identify, caps: a7e9f9bf 00000000 00000000
00000000
CPU:     After vendor identify, caps: a7e9f9bf 00000000 00000000
00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9f9bf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1700MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
do_initcalls
init_elf_binfmt
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
No customized DSDT found!
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Found ECDT
    ACPI-0179: *** Warning: The ACPI AML in your computer contains
errors, please nag the manufacturer to correct it.
    ACPI-0182: *** Warning: Allowing relaxed access to fields; turn on
CONFIG_ACPI_DEBUG for details.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
 ... the first call_usermodehelper: pci_bus
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
vesafb: framebuffer at 0xe0000000, mapped to 0xf8815000, size 32704k
vesafb: mode is 1400x1050x16, linelength=2800, pages=10
vesafb: protected mode interface info at c000:580d
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Simple Boot Flag at 0x35 set to 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
Initial HugeTLB pages allocated: 0
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
bootsplash 3.1.6-2004/03/31: looking for picture... no good signature
found.
Console: switching to colour frame buffer device 175x65
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing
enabled
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N080ATMR04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-RAM UJ-811, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: Host Protected Area detected.
        current capacity is 149285282 sectors (76434 MB)
        native  capacity is 156301488 sectors (80026 MB)
hda: Host Protected Area disabled.
hda: 156301488 sectors (80026 MB) w/7884KiB Cache, CHS=65535/16/63,
UDMA(100)
 hda: hda1 hda2 hda3 hda4
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.9
 Sensor: 44
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
 -> pass-through port
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
serio: Synaptics pass-through port at isa0060/serio1/input0
input: PS/2 Generic Mouse on synaptics-pt/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 8
NET: Registered protocol family 20
Resume Machine: resuming from /dev/hda2
Resuming from device hda2
Resume Machine: This is normal swap space
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... failed
Unmounting old root
Trying to free ramdisk memory ... okay
Freeing unused kernel memory: 212k freed
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
NTFS driver 2.1.6 [Flags: R/O MODULE].
NTFS volume version 3.1.
subfs 0.9
Adding 514072k swap on /dev/hda2.  Priority:42 extents:1
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03545c0(lo)
IPv6 over IPv4 tunneling driver
Intel(R) PRO/1000 Network Driver - version 5.2.30.1-k2
Copyright (c) 1999-2004 Intel Corporation.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
hostap_crypt: registered algorithm 'NULL'
ipw2100: no version for "hostap_get_crypto_ops" found: kernel tainted.
ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.42
ipw2100: Copyright(c) 2003-2004 Intel Corporation
Detected ipw2100 PCI device at 0000:02:02.0, dev: eth1, mem:
0xC0214000-0xC0214FFF -> fa937000, irq: 11
eth1: Using hotplug firmware load.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0552]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000086
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
ipw2100: Associated with 'SpeedStream' at 11Mbps, channel 11
NET: Registered protocol family 17
hw_random hardware driver 1.0.0 loaded
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem faa66000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.4-54.5-default ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ieee1394: Initialized config rom entry `ip1394'
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 00001800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
usb usb2: Product: UHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: UHCI Host Controller
Linux agpgart interface v0.100 (c) Dave Jones
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 00001840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.4-54.5-default uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci1394: $Rev: 1193 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11] 
MMIO=[c0215000-c02157ff]  Max Packet=[2048]
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 256M @ 0xd0000000
eth1: Association lost.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b0324000368]
ipw2100: Associated with 'SpeedStream' at 11Mbps, channel 11
eth1: Association lost.
ipw2100: Associated with 'SpeedStream' at 11Mbps, channel 11
eth0: no IPv6 routers present
eth1: no IPv6 routers present
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU] (supports C1 C2 C3, 8 throttling states)
ACPI: Thermal Zone [THM0] (47 C)
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1700MHz": max
frequency: 1700000kHz
intel8x0_measure_ac97_clock: measured 49547 usecs
intel8x0: clocking to 48000
Non-volatile memory driver v1.2
hdc: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
SCSI subsystem initialized
st: Version 20040318, fixed bufsize 32768, s/g segs 256
BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
parport0: PC-style at 0x3bc [PCSPP,TRISTATE]
lp0: using parport0 (polling).
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
end_request: I/O error, dev fd0, sector 0
mtrr: 0xe0000000,0x2000000 overlaps existing 0xe0000000,0x1000000
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Radeon Lf R250
Mobility 9000 M9
mtrr: 0xe0000000,0x2000000 overlaps existing 0xe0000000,0x1000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
eth1: Association lost.
ipw2100: Associated with 'SpeedStream' at 11Mbps, channel 11
eth1: Association lost.
ipw2100: Associated with 'SpeedStream' at 11Mbps, channel 11
eth0: no IPv6 routers present
eth1: no IPv6 routers present
e1000: eth0: e1000_watchdog: NIC Link is Down
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
spurious 8259A interrupt: IRQ7.
cdrom: dropping to single frame dma


