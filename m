Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUKMWsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUKMWsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKMWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:48:31 -0500
Received: from mail.aknet.ru ([217.67.122.194]:19462 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261196AbUKMWra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:47:30 -0500
Message-ID: <41968F16.1080706@aknet.ru>
Date: Sun, 14 Nov 2004 01:47:50 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
Content-Type: multipart/mixed;
 boundary="------------090304000408090109030404"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090304000408090109030404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Zwane Mwaikambo wrote:
>> 1. Local APIC stopped working. I know
> Could you please apply the following patch and supply full dmesg?
Done.
Does this help?


--------------090304000408090109030404
Content-Type: text/plain;
 name="dmsg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmsg"

Linux version 2.6.10-rc1-mm5-stsp1 (root@lin) (gcc version 3.4.0 (Red Hat Linux 3.4.0-1)) #2 SMP Sun Nov 14 01:35:31 MSK 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000faf50
ACPI: RSDT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x1fff0030
ACPI: DSDT (v001   ASUS      K7M 0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
arch/i386/kernel/apic.c:765
Initializing CPU#0
Kernel command line: ro root=/dev/hdc2 apm=power-off lapic nmi_watchdog=1
CPU 0 irqstacks, hard=c03ae000 soft=c03ac000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 704.943 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515712k/524224k available (1784k kernel code, 8028k reserved, 746k data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1388.54 BogoMIPS (lpj=694272)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) Processor stepping 02
per-CPU timeslice cutoff: 731.96 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
CPU0:
 domain 0: span 1
  groups: 1
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7a30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6944, dseg 0xf0000
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: Missing SMALL_TAG_ENDDEP tag
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1100396440.284:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
[drm] Initialized drm 1.0.0 20040925
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is a post-1991 82077
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: FUJITSU MPG3409AT E, ATA DISK drive
hdb: FUJITSU MPE3102AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Maxtor 6Y080L0, ATA DISK drive
hdd: CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
hdb: max request size: 128KiB
hdb: 20016348 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63
hdb: cache flushes not supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 >
hdd: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
logibm.c: Didn't find Logitech busmouse at 0x23c
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 180k freed
kjournald starting.  Commit interval 5 seconds
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:04.2
PCI: Sharing IRQ 10 with 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:04.2: irq 10, io base 0xd400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:04.2
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:04.3: irq 10, io base 0xd800
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
usb 1-1: new low speed USB device using uhci_hcd and address 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 3
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:04.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
EXT3 FS on hdc2, internal journal
Adding 530104k swap on /dev/hda9.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
NTFS driver 2.1.22 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS volume version 3.1.
  Vendor: JetFlash  Model: TS256MJF2A        Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: Write Protect is off
sda: Mode Sense: 0b 00 00 08
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
usb-storage: device scan complete
ip_tables: (C) 2000-2002 Netfilter core team
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:04.2
divert: allocating divert_blk for eth0
eth0: RealTek RTL-8029 found at 0xc800, IRQ 10, 00:C0:26:EF:74:E6.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
parport_pc: Unknown parameter `io'
parport_pc: Ignoring new-style parameters in presence of obsolete ones
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: Legacy device
parport_pc: VIA parallel port: io=0x378, irq=7
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0346ee0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD Irongate chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 2726 using kernel context 0

--------------090304000408090109030404--
