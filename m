Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTLAQ7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTLAQ7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 11:59:12 -0500
Received: from main.gmane.org ([80.91.224.249]:34786 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263702AbTLAQ65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 11:58:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mikpolniak <mikpolniak@adelphia.net>
Subject: Re: vt8235 ide0: Speed warnings UDMA 3/4/5 is not functional
Date: Mon, 01 Dec 2003 11:58:53 -0500
Message-ID: <pan.2003.12.01.16.58.49.304572@adelphia.net>
References: <pan.2003.12.01.14.12.20.713784@adelphia.net> <200312011542.07130.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Dec 2003 15:42:07 +0100, Bartlomiej Zolnierkiewicz wrote:

> 
> Do you use 80-wires cable?
> If yes, please send full dmesg and output of 'hdparm -I /dev/hda'.
> 
I have tried 2 different 80 wire cables.

Linux version 2.6.0-test11 (root@gent.gentuu.org) (gcc version 3.3.2 20031022 (Gentoo Linux 3.3.2-r2, propolice)) #1 Fri Nov 28 09:22:06 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff8000 (ACPI data)
 BIOS-e820: 000000000dff8000 - 000000000e000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57328
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53232 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: root=/dev/discs/disc0/part7 acpi=off hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 700.499 MHz processor.
Console: colour VGA+ 80x25
Memory: 222936k/229312k available (2237k kernel code, 5720k reserved, 886k data, 144k init, 0k highmem)
Calibrating delay loop... 1372.16 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
CPU: AMD Duron(tm)  stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
SCSI subsystem initialized
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3177] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST360015A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA CD-ROM XM-6302B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 >
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda7) for (hda7)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Adding 976712k swap on /dev/hda5.  Priority:-1 extents:1
Adding 976712k swap on /dev/hda9.  Priority:-2 extents:1
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: CD-ROM XM-6302B   Rev: 1017
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
i2c-core.o: driver IT87xx registered.
registering 0-0290
Intel 810 + AC97 Audio, version 0.24, 09:19:26 Nov 28 2003
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
Real Time Clock Driver v1.12
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 10, pci mem cea0cf00
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 11, io base 0000e400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 5, io base 0000e800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 5, io base 0000ec00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xdc00, 00:30:1b:1f:7b:06, IRQ 11.
eth0: MII PHY found at address 1, status 0x7869 advertising 05e1 Link 45e1.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
blk: queue c13f9400, I/O limit 4095Mb (mask 0xffffffff)
ide0: Speed warnings UDMA 3/4/5 is not functional.


and.....hdparm -I /dev/hda



/dev/hda:

ATA device, with non-removable media
	Model Number:       ST360015A                               
	Serial Number:      3KC07GMG            
	Firmware Revision:  3.31    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	4047
	heads		16	16
	sectors/track	63	255
	--
	CHS current addressable sectors:   16511760
	LBA    user addressable sectors:  117231408
	device size with M = 1024*1024:       57241 MBytes
	device size with M = 1000*1000:       60022 MBytes (60 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard
	R/W multiple sector transfer: Max = 16	Current = ?
	Recommended acoustic management value: 128, current value: 128
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
		SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- below Vih
	Device num = 0 determined by the jumper
Checksum: correct


