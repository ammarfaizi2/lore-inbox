Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTKFVLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTKFVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:11:21 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:55412 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263848AbTKFVLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:11:05 -0500
From: Paulo Moura Guedes <pmg@netcabo.pt>
To: hirofumi@mail.parknet.co.jp
Subject: Re: test9 - USB and fat32 not working
Date: Thu, 6 Nov 2003 21:10:45 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Vjrq/xIvQHP1IDp"
Message-Id: <200311062110.45986.pmg@netcabo.pt>
X-OriginalArrivalTime: 06 Nov 2003 21:10:58.0695 (UTC) FILETIME=[79896970:01C3A4AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Vjrq/xIvQHP1IDp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

( I have an i686 with RH9 and i installed Red Hat unofficial rpm's 
 (kernel-2.6.0-0.test9.1.70.i686.rpm , etc..)

Everything is working fine expect for this boot messages (I'll try to 
emember):
 
USB not working - missing 
         usb_uhci
         mousedev
         keybdev

Can't mount my fat32 partitions. (I have no problem with RH9 kernel, 
fstab is ok)

Mouse movement is way too accelerated.
)

> Please send output of dmesg and fstab.

I noticed that this only happen under X. On text mode movement are fine.

My cdroms disapeared too.

As you said i send you the output of dmesg and fstab with kernel 2.4 and 2.6.

Paulo
-- 
KMail - The supreme eMail client

--Boundary-00=_Vjrq/xIvQHP1IDp
Content-Type: text/plain;
  charset="us-ascii";
  name="boot.messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot.messages"

Linux version 2.6.0-0.test9.1.70 (bhcompile@porky.devel.redhat.com) (gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 Wed Nov 5 10:25:44 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ff0000 (usable)
 BIOS-e820: 0000000027ff0000 - 0000000027ff3000 (ACPI NVS)
 BIOS-e820: 0000000027ff3000 - 0000000028000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
639MB LOWMEM available.
On node 0 totalpages: 163824
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159728 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
ACPI: RSDP (v000 VIA694                                    ) @ 0x000f7050
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x27ff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x27ff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: ro root=LABEL=/1 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 811.202 MHz processor.
Console: colour VGA+ 80x25
Memory: 645292k/655296k available (1388k kernel code, 9244k reserved, 717k data, 136k init, 0k highmem)
Calibrating delay loop... 1593.34 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
Failure registering capabilities with the kernel
selinux_register_security:  Registering secondary module capability
Capability LSM initialized
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 164k freed
CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb4f0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Disabling VIA memory write queue (PCI ID 0305, rev 03): [55] 89 & 1f -> 09
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
Applying VIA southbridge workaround.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: AGP aperture is 64M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST340014A, ATA DISK drive
hdb: ST320413A, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
hdd: AOPEN CD-RW CRW4850 1.01 20020904, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=38792/16/63, UDMA(100)
 hdb: hdb1
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: GenPS/2 Genius Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
EXT3 FS on hda1, internal journal
Adding 1020116k swap on /dev/hda2.  Priority:-1 extents:1
FAT: Unrecognized mount option "owner=mojo" or missing value
FAT: Unrecognized mount option "owner=mojo" or missing value
SCSI subsystem initialized
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LG        Model: CD-ROM CRD-8522B  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: AOPEN     Model: CD-RW CRW4850     Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
kudzu: numerical sysctl 1 23 is obsolete.
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
inserting floppy driver for 2.6.0-0.test9.1.70
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ip_tables: (C) 2000-2002 Netfilter core team
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 11 for device 0000:00:0b.0
PCI: Sharing IRQ 11 with 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xe8930000, 00:50:fc:a2:ee:e5, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
lp0: using parport0 (polling).
lp0: console ready
Via 686a/8233/8235 audio driver 1.9.1-ac3-2.5
PCI: Found IRQ 5 for device 0000:00:07.5
PCI: Setting latency timer of device 0000:00:07.5 to 64
ac97_codec: AC97 Audio codec, id: ICE17 (ICE1232)
via82cxxx: board #1 at 0xDC00, IRQ 5
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02da8e0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
via_audio: ignoring drain playback error -11

--Boundary-00=_Vjrq/xIvQHP1IDp
Content-Type: text/plain;
  charset="us-ascii";
  name="fstab_2.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fstab_2.4"

LABEL=/1                /                       ext3    defaults        1 1
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/hda2               swap                    swap    defaults        0 0
/dev/hda3               /win                    vfat    uid=mojo,gid=mojo,owner=mojo,mode=0775        0 0
/dev/hdb1               /slave                  vfat    uid=mojo,gid=mojo,owner=mojo,mode=0775        0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0
/dev/cdrom              /mnt/cdrom              udf,iso9660 noauto,owner,kudzu,ro 0 0
/dev/cdrom1             /mnt/cdrom1             udf,iso9660 noauto,owner,kudzu,ro 0 0


--Boundary-00=_Vjrq/xIvQHP1IDp
Content-Type: text/plain;
  charset="us-ascii";
  name="fstab_2.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fstab_2.6"

LABEL=/1                /                       ext3    defaults        1 1
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /proc                   proc    defaults        0 0
none                    /dev/shm                tmpfs   defaults        0 0
/dev/hda2               swap                    swap    defaults        0 0
/dev/hda3		/win			vfat	uid=mojo,gid=mojo,owner=mojo,mode=0775        0 0
/dev/hdb1               /slave                  vfat    uid=mojo,gid=mojo,owner=mojo,mode=0775        0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0

--Boundary-00=_Vjrq/xIvQHP1IDp--

