Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266581AbUBQVdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUBQVbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:31:07 -0500
Received: from mail2.allneo.com ([216.185.99.212]:15596 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S266581AbUBQV2R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:28:17 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Tue, 17 Feb 2004 16:28:04 -0500
Message-ID: <004a01c3f59c$f192aa10$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.44.0402171937490.4978-100000@poirot.grange>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, bad cut and paste, also my scsi disk is not where root fs is it
contains /tmp /var /opt on three different partitions here is the full
dmesg:
Linux version 2.6.2 (root@bigdaddy) (gcc version 3.3.3 20040125 (prerelease)
(Debian)) #1 Thu Feb 12 08:33:42 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fff0000 (usable)
 BIOS-e820: 000000004fff0000 - 000000004fff3000 (ACPI NVS)
 BIOS-e820: 000000004fff3000 - 0000000050000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 327664
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 98288 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 761686                                    ) @ 0x000f6a70
ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x4fff3000
ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x4fff3040
ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=1601
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1402.432 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1293316k/1310656k available (1941k kernel code, 16200k reserved,
831k data, 164k init, 393152k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 04
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1401.0560 MHz.
..... host bus clock speed is 266.0963 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb690, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ11 SCI: Level Trigger.
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even
'acpi=off'
vesafb: framebuffer at 0xec000000, mapped to 0xf8806000, size 16384k
vesafb: mode is 1024x768x8, linelength=1024, pages=4
vesafb: protected mode interface info at c000:bd60
vesafb: scrolling: redraw
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD 761 chipset
agpgart: Maximum main memory to use for agp memory: 1185M
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xf983d000, 00:00:21:fb:f7:f1, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD400BB-00CLB0, ATA DISK drive
hdc: WDC WD400BB-00CLB0, ATA DISK drive
hdd: CR-487ETE, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 > hda4
hdc: max request size: 128KiB
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hdc: hdc1 hdc2 hdc3
sym0: <895> rev 0x1 at pci 0000:00:0f.0 irq 11
sym0: Tekram NVRAM, ID 7, Fast-40, SE, NO parity
sym0: SCSI BUS has been reset.
sym0: SCSI BUS mode change from SE to SE.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18f
  Vendor: SEAGATE   Model: SX4234514         Rev: 9E21
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 4.
  Vendor: PIONEER   Model: DVD-ROM DVD-303R  Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: SDT-5000          Rev: 3.26
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc1, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc1) for (hdc1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 164k freed
NET: Registered protocol family 1
Adding 200804k swap on /dev/hda4.  Priority:-1 extents:1
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc2, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc2) for (hdc2)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdc3, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdc3) for (hdc3)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda6, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda6) for (hda6)
Using r5 hash to sort names
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
Real Time Clock Driver v1.12
blk: queue f7cc9a00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue f7cc9200, I/O limit 4095Mb (mask 0xffffffff)
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(18)
parport0: assign_addrs: aa5500ff(18)
parport0: Printer, EPSON Stylus COLOR 640
parport_pc: Via 686A parallel port: io=0x378
lp0: using parport0 (polling).

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Guennadi
Liakhovetski
Sent: Tuesday, February 17, 2004 2:17 PM
To: Brad Cramer
Cc: linux-kernel@vger.kernel.org
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x

On Tue, 17 Feb 2004, Brad Cramer wrote:

> Linux version 2.6.2 (root@bigdaddy) (gcc version 3.3.3 20040125
(prerelease)
> (Debian)) #1 Thu Feb 12 08:33:42 EST 2004

...

> 383MB HIGHMEM available.
> 896MB LOWMEM available.

...

> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

...

> Detected 1402.432 MHz processor.
> Using tsc for high-res timesource

...

> Memory: 1293316k/1310656k available (1941k kernel code, 16200k reserved,
> 831k data, 164k init, 393152k highmem)

...

> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) processor stepping 04

Is this the complete log? Why did you decide that the problem is with SCSI
then? There should be some more stuff between this point and SCSI init. If
you really suspect SCSI, you could try disabling your controller-driver
and enable another one, then it should boot further and panic nixely
"unable to mount root-fs".

> 1,1           Top

This didn't belong to the log, did it?

Guennadi
---
Guennadi Liakhovetski


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


