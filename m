Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270558AbTGNH0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 03:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270559AbTGNH0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 03:26:21 -0400
Received: from law10-f18.law10.hotmail.com ([64.4.15.18]:36365 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270558AbTGNH0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 03:26:16 -0400
X-Originating-IP: [12.234.129.28]
X-Originating-Email: [bobby0822@hotmail.com]
From: "Anurag Dod" <bobby0822@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: bobby0822@hotmail.com
Subject: NMI received for unknown reason
Date: Mon, 14 Jul 2003 00:41:03 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F181UtYj7XGeF0000a2a2@hotmail.com>
X-OriginalArrivalTime: 14 Jul 2003 07:41:03.0385 (UTC) FILETIME=[46F85090:01C349DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I am running kernel 2.5.67 for my machine. The machine config is:
Dell 600SC,
2.4Gz
1.12G Ram

  The system boots up fine and runs ok.  But usually after 2-3 days it 
receives the receives NMI and prints following message on /var/log/messages
Jul 12 05:56:41 bobby kernel: Uhhuh. NMI received for unknown reason 21 on 
CPU 0.
Jul 12 05:56:41 bobby kernel: Dazed and confused, but trying to continue
Jul 12 05:56:41 bobby kernel: Do you have a strange power saving mode 
enabled?

And after that it runs for next 10-12 hrs and then system hangs!!. I am 
running process which needs lots of memory but is running under low load ( 
in terms of system utilization).
Do u think this is kernel bug or problem with memory / motherboard and how 
to diagnose or correct it? Any advice will be appreciated. Also  please 
while replying cc to me ( bobby0822@hotmail.com) as I have not subscribed to 
linux-kernel mailing list.
  Also below is the output of dmesg after initial bootup.

Thanks,
Bobby

------------------- dmesg output --------------------------------------
Linux version 2.5.67 (bobby@localhost) (gcc version 2.96 20000731 (Red Hat 
Linux 7.3 2.96-110)) #13 Wed May 28 12:39:51 CDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
BIOS-e820: 0000000000100000 - 0000000047ff0000 (usable)
BIOS-e820: 0000000047ff0000 - 0000000047ffec00 (ACPI data)
BIOS-e820: 0000000047ffec00 - 0000000047fff000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fe710
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 294896
DMA zone: 4096 pages, LIFO batch:1
Normal zone: 225280 pages, LIFO batch:16
HighMem zone: 65520 pages, LIFO batch:15
Intel MultiProcessor Specification v1.4
Virtual Wire compatibility mode.
OEM ID: DELL Product ID: PE 0134 APIC at: 0xFEE00000
Processor #0 15:2 APIC version 20
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
I/O APIC #3 Version 17 at 0xFEC02000.
Enabling APIC mode: Flat. Using 3 I/O APICs
Processors: 1
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda8 ide0=ata66 ide1=ata66
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2398.757 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4718.59 BogoMIPS
Memory: 1164200k/1179584k available (1305k kernel code, 14260k reserved, 
636k data, 184k init, 262080k highmem)
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After generic, caps: bfebfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2398.0946 MHz.
..... host bus clock speed is 133.0274 MHz.
Initializing RT netlink socket
mtrr: v2.0 (20020519)
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfc71e, last bus=0
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]: 1 bvecs: 256 entries (12 bytes)
biovec pool[1]: 4 bvecs: 256 entries (48 bytes)
biovec pool[2]: 16 bvecs: 256 entries (192 bytes)
biovec pool[3]: 64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe2f4, dseg 0x40
PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
block request queues:
128 requests per read queue
128 requests per write queue
8 requests per batch
enter congestion at 15
exit congestion at 17
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
PCI: Using IRQ router default [1166/0203] at 00:0f.0
apm: BIOS not found.
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks CSB6: IDE controller at PCI slot 00:0e.0
SvrWks CSB6: chipset revision 160
SvrWks CSB6: 100% native mode on irq 11
ide2: BM-DMA at 0x0900-0x0907, BIOS settings: hde:DMA, hdf:pio
hde: GCR-8481B, ATAPI CD/DVD-ROM drive
ide2 at 0x1e8-0x1ef,0x3ee on irq 11
SvrWks CSB6: IDE controller at PCI slot 00:0f.1
SvrWks CSB6: chipset revision 160
SvrWks CSB6: not 100% native mode: will probe irqs later
ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:DMA, hdd:pio
hda: ST340016A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD400BB-00DKA0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=77504/16/63, UDMA(33)
hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
hdc: host protected area => 1
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(33)
hdc: hdc1 hdc2
ide-floppy driver 0.99.newide
mice: PS/2 mouse device common for all mice
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at Virtual EISA Bridge
EISA: Detected 0 cards.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 121k freed
VFS: Mounted root (ext2 filesystem).
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting. Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 184k freed
Adding 112412k swap on /dev/hda11. Priority:-1 extents:1
Adding 2096440k swap on /dev/hda7. Priority:-2 extents:1
Adding 2096440k swap on /dev/hda6. Priority:-3 extents:1
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,8), internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,10), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting. Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Intel(R) PRO/1000 Network Driver - version 5.0.43-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
mtrr: type mismatch for fd000000,800000 old: uncachable new: write-combining
mtrr: type mismatch for fd000000,800000 old: uncachable new: write-combining
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
-----------------------------------------------------------------------------------------

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

