Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTGFQnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTGFQnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:43:45 -0400
Received: from 213-84-203-196.adsl.xs4all.nl ([213.84.203.196]:8197 "EHLO
	gateway.bencastricum.nl") by vger.kernel.org with ESMTP
	id S262593AbTGFQnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:43:25 -0400
Message-ID: <000901c343df$9165ed10$0802a8c0@pc>
From: "Ben Castricum" <lk@bencastricum.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.22-pre3 : SoundBlaster IDE interface missing
Date: Sun, 6 Jul 2003 18:56:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have one of those ancients ISA-PNP SoundBlaster cards with an additional
IDE interface on it. It all worked perfectly up till 2.4.22-pre2 but with
pre3 the IDE interface is no longer detected.

Any help on getting it to work again would be great.

Ben



Output of dmesg:

Linux version 2.4.22-pre3 (root@gateway) (gcc version 2.95.3 20010315
(release)) #45 Sun Jul 6 13:30:06 CEST 2003 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007efc000 (usable)
 BIOS-e820: 0000000007efc000 - 0000000007eff000 (ACPI data)
 BIOS-e820: 0000000007eff000 - 0000000007f00000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
126MB LOWMEM available.
On node 0 totalpages: 32508
zone(0): 4096 pages.
zone(1): 28412 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=301 nmi_watchdog=2
init=/boot/init
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 467.737 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 930.61 BogoMIPS
Memory: 126716k/130032k available (850k kernel code, 2928k reserved, 226k
data, 240k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 467.6890 MHz.
..... host bus clock speed is 66.8124 MHz.
cpu: 0, clocks: 668124, slice: 334062
CPU0<T0:668112,T1:334048,D:2,S:334062,C:668124>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - Intel Corp. 82801AA PCI Bridge
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE32 PnP'
isapnp: Card 'Adaptec AHA-1520B'
isapnp: 2 Plug & Play cards detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 1
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xa800-0xa807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xa808-0xa80f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD300BB-00AUA1, ATA DISK drive
hdb: MAXTOR 6L080J4, ATA DISK drive
blk: queue c026f080, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c026f1c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Maxtor 6Y080L0, ATA DISK drive
hdd: MATSHITADVD-ROM SR-8583, ATAPI CD/DVD-ROM drive
blk: queue c026f4dc, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3649/255/63, UDMA(66)
hdb: attached ide-disk driver.
hdb: host protected area => 1
hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=9732/255/63, UDMA(66)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(66)
Partition check:
 hda: hda1
 hdb: hdb1 hdb2 hdb3
 hdc: hdc1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
...

