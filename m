Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTD1WRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTD1WRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:17:00 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:55831 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261350AbTD1WQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:16:57 -0400
Date: Tue, 29 Apr 2003 00:27:51 +0200
Message-Id: <200304282227.h3SMRpna010528@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 freezes
In-Reply-To: <3EAD9192.7040003@asbest-online.de>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.17-20030407 ("Peephole") (UNIX) (Linux/2.4.21-pre6 (i686))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3EAD9192.7040003@asbest-online.de> you wrote:
> Hi,
> 
>> I can to confirm this bug, I have the identical effects.
> 
> Could you have a look at my boot.log and see if you've got
> similar hardware? Maybe we can narrow the problem down a bit.

dmesg was taken from 2.4.21-pre6. It's RedHat 9

Linux version 2.4.21-pre6 (root@lt.wsisiz.edu.pl) (gcc version 3.2 20020903
(Red Hat Linux 8.0 3.2-7)) #1 Thu Mar 27 13:36:17 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000fb940
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: VIA      Product ID: VT5440B      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 2 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 1
Kernel command line: auto BOOT_IMAGE=old ro root=1603 hdd=ide-scsi; video=riva:800x600-16@85
ide_setup: hdd=ide-scsi;
Initializing CPU#0
Detected 1666.731 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3322.67 BogoMIPS
Memory: 256584k/262080k available (1429k kernel code, 5108k reserved, 352k data, 264k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
.... CPU clock speed is 1666.7519 MHz.
.... host bus clock speed is 266.6803 MHz.
cpu: 0, clocks: 2666803, slice: 1333401
CPU0<T0:2666800,T1:1333392,D:7,S:1333401,C:2666803>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3147] at 00:11.0
PCI: Hardcoded IRQ 14 for device 00:11.1
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
ACPI: APM is already active, exiting
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
epic100.c:v1.11 1/7/2001 Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/epic100.html
  (unofficial 2.4.x kernel port, version 1.11+LK1.1.14, Aug 4, 2002)
epic100(00:05.0): MII transceiver #3 control 3000 status 7809.
epic100(00:05.0): Autonegotiation advertising 01e1 link partner 0001.
eth0: SMSC EPIC/100 83c170 at 0xec00, IRQ 11, 00:e0:29:1c:91:51.
PPP generic driver version 2.4.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT266 chipset
agpgart: AGP aperture is 128M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: Hardcoded IRQ 14 for device 00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC AC24300L, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive
blk: queue c0327fc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IBM-DTLA-305020, ATA DISK drive
hdd: CD-W540E, ATAPI CD/DVD-ROM drive
blk: queue c0328410, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: host protected area => 1
hda: 8421840 sectors (4312 MB) w/256KiB Cache, CHS=524/255/63, UDMA(33)
hdc: host protected area => 1
hdc: 40188960 sectors (20577 MB) w/380KiB Cache, CHS=39870/16/63, UDMA(100)
hdb: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1
 hdc: hdc1 hdc2 hdc3 hdc4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
IPv4 over IPv4 tunneling driver
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 264k freed
Adding Swap: 262136k swap-space (priority -1)
NTFS driver v1.1.22 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide1(22,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.


lt:/boot# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:05.0 Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 06)
00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
00:0b.0 USB Controller: NEC Corporation USB (rev 41)
00:0b.1 USB Controller: NEC Corporation USB (rev 41)
00:0b.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 40)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400]
(rev b2)


-- 
*[ £ukasz Tr±biñski ]*
