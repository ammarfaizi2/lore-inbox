Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJFM65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTJFM6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:58:55 -0400
Received: from covilha.procergs.com.br ([200.198.128.212]:35599 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S262038AbTJFM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:58:49 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6-bk7: kernel freeze if try to change to console
References: <87d6db2gw0.fsf@retteb.casa>
	<16257.17952.546250.954616@gargle.gargle.HOWL>
From: Otavio Salvador <otavio@debian.org>
Date: Mon, 06 Oct 2003 09:58:00 -0300
In-Reply-To: <16257.17952.546250.954616@gargle.gargle.HOWL> (Mikael
 Pettersson's message of "Mon, 6 Oct 2003 12:38:24 +0200")
Message-ID: <87vfr2ttev.fsf@retteb.casa>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Otavio Salvador writes:
>  > Folks,
>  > 
>  > I'm using kernel 2.6.0-test6-bk7 and have some problems. If I try to
>  > change to console from X my system freeze. I'm including my .config
>  > file bellow.
>
> I have a hunch but I need to see your boot dmesg log to confirm.
> Please post it.

Hello,

Here is it.

Linux version 2.6.0-test6-bk7 (root@retteb.casa) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 Mon Oct 6 00:32:00 BRT 2003
Video mode to be used for restore is 31a
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000080000 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001efec000 (usable)
 BIOS-e820: 000000001efec000 - 000000001efef000 (ACPI data)
 BIOS-e820: 000000001efef000 - 000000001efff000 (reserved)
 BIOS-e820: 000000001efff000 - 000000001f000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126956
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 122860 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 vga=794
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1603.692 MHz processor.
Console: colour dummy device 80x25
Memory: 498876k/507824k available (1958k kernel code, 8056k reserved, 558k data, 332k init, 0k highmem)
Calibrating delay loop... 3170.30 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
CPU: AMD Athlon(TM) XP 1900+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf1a70, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/01b2] at 0000:00:01.0
vesafb: framebuffer at 0xe8000000, mapped to 0xdf800000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:bf60
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
udf: registering filesystem
Initializing Cryptographic API
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce chipset
agpgart: Maximum main memory to use for agp memory: 424M
agpgart: AGP aperture is 128M @ 0xf0000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xc800, IRQ 5, 52:54:00:E9:5D:02.
8139too Fast Ethernet driver 0.9.26
eth1: RealTek RTL8139 at 0xe0856000, 00:e0:7d:a9:dd:44, IRQ 5
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE: IDE controller at PCI slot 0000:00:09.0
NFORCE: chipset revision 195
NFORCE: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits correctly. Enabling workaround.
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: 0000:00:09.0 (rev c3) UDMA100 controller on pci0000:00:09.0
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:DMA
hda: MAXTOR 6L040J2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 48X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Console: switching to colour frame buffer device 160x64
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0: clocking to 47419
ALSA device list:
  #0: NVidia nForce at 0xe5800000, irq 11
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
ip_conntrack version 2.1 (3967 buckets, 31736 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
reiserfs: replayed 13 transactions in 1 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 332k freed
Adding 530104k swap on /dev/hda6.  Priority:-1 extents:1
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
Removing [2 30 0x0 SD]..done
There were 1 uncompleted unlinks/truncates. Completed
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-1) for (dm-1)
reiserfs: replayed 1 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-4) for (dm-4)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-2) for (dm-2)
reiserfs: replayed 11 transactions in 0 seconds
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-3) for (dm-3)
Using r5 hash to sort names
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (dm-0) for (dm-0)
reiserfs: replayed 63 transactions in 0 seconds
Using r5 hash to sort names
eth1: link down
blk: queue c1515e00, I/O limit 4095Mb (mask 0xffffffff)
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT

Thanks,
Otavio

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
