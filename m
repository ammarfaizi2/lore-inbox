Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTIHQUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTIHQUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:20:15 -0400
Received: from [198.237.137.59] ([198.237.137.59]:5709 "EHLO
	mrwhite.district6.org") by vger.kernel.org with ESMTP
	id S262675AbTIHQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:19:36 -0400
Subject: SYM53C8XX help
From: Aaron Blew <aaron.blew@district6.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-YGWQoSotNfay/G1q7r64"
Message-Id: <1063037882.26911.45.camel@elijah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 09:18:02 -0700
X-OriginalArrivalTime: 08 Sep 2003 16:19:35.0503 (UTC) FILETIME=[FE5EC5F0:01C37624]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YGWQoSotNfay/G1q7r64
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've been having some issues with one of my servers that I think may be
SCSI related.  Here's what I get at the console:

sym0:1: ERROR (81:0) (8-0-0) (3e/18/80) @ (scripta 50:f31c0004).
sym0: script cmd = 90080000
sym0: regdump: da 00 00 18 47 3e 01 0f 00 08 80 00 80 00 07 02 01 00 00
00 02 00 00 00.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.

Anyone have an idea what this is about?  This server has also recently
had stability issues that I think could be related to these errors.  If
more output is needed, I can easily provide it.

Attached is the output from dmesg and lspci.

Thanks for any help,
-Aaron


---------------
Aaron Blew
Jackson County School District #6 Network/Systems Analyst
aaron.blew@district6.org
(541)494-6900

People never lie so much as after a hunt, during a war, or before an
election.
    -- Otto Von Bismarck

--=-YGWQoSotNfay/G1q7r64
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

820: 000000007fffc000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f54d0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 524284
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294908 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode: Flat.	Using 1 I/O APICs
Processors: 2
Kernel command line: auto BOOT_IMAGE=Linux ro root=802
Initializing CPU#0
Detected 1004.542 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2005.40 BogoMIPS
Memory: 2069256k/2097136k available (1531k kernel code, 27492k reserved, 511k data, 260k init, 1179632k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.07 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 2005.40 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (4010.80 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-13, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1004.4354 MHz.
..... host bus clock speed is 133.9244 MHz.
cpu: 0, clocks: 1339244, slice: 446414
CPU0<T0:1339232,T1:892816,D:2,S:446414,C:1339244>
cpu: 1, clocks: 1339244, slice: 446414
CPU1<T0:1339232,T1:446400,D:4,S:446414,C:1339244>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0d00, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Enabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
hda: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-cdrom driver.
hda: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
sym.0.8.0: setting PCI_COMMAND_PARITY...
sym.0.8.1: setting PCI_COMMAND_PARITY...
sym0: <1010-33> rev 0x1 on pci bus 0 device 8 function 0 irq 9
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-33> rev 0x1 on pci bus 0 device 8 function 1 irq 11
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, LVD, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue f7bc6418, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST336705LW        Rev: 0105
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7bc6218, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ba9e18, I/O limit 1048575Mb (mask 0xffffffffff)
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:1:0: tagged command queuing enabled, command queue depth 16.
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ba5018, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ba0c18, I/O limit 1048575Mb (mask 0xffffffffff)
  Vendor: SEAGATE   Model: ST336706LW        Rev: 0108
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7ba0818, I/O limit 1048575Mb (mask 0xffffffffff)
sym1:0:0: tagged command queuing enabled, command queue depth 16.
sym1:1:0: tagged command queuing enabled, command queue depth 16.
sym1:2:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0
Attached scsi disk sde at scsi1, channel 0, id 2, lun 0
sym0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sda: 71687370 512-byte hdwr sectors (36704 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
sym0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
 sdb: sdb1
sym1:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sdc: 71687370 512-byte hdwr sectors (36704 MB)
 sdc: sdc1
sym1:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sdd: 71687370 512-byte hdwr sectors (36704 MB)
 sdd: sdd1
sym1:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 62)
SCSI device sde: 71132959 512-byte hdwr sectors (36420 MB)
 sde: sde1 sde2
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1756.400 MB/sec
   32regs    :  1233.200 MB/sec
   pIII_sse  :  2084.000 MB/sec
   pII_mmx   :  2243.200 MB/sec
   p5_mmx    :  2373.600 MB/sec
raid5: using function: pIII_sse (2084.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
Adding Swap: 1000424k swap-space (priority -1)
Adding Swap: 2097136k swap-space (priority -2)
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,2), internal journal
tg3.c:v1.5 (March 21, 2003)
eth0: Tigon3 [partno(3C996B-T) rev 0105 PHY(5701)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:04:76:f5:7f:ed
 [events: 00000012]
 [events: 00000012]
md: autorun ...
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdb1 ...
md: created md0
md: bind<sdb1,1>
md: bind<sdd1,2>
md: running: <sdd1><sdb1>
md: sdd1's event counter: 00000012
md: sdb1's event counter: 00000012
md: md0: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md0: max total readahead window set to 124k
md0: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdd1 operational as mirror 1
raid1: device sdb1 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 35559744 blocks.
md: updating md0 RAID superblock on device
md: sdd1 [events: 00000013]<6>(write) sdd1's sb offset: 35840896
md: sdb1 [events: 00000013]<6>(write) sdb1's sb offset: 35559744
md: ... autorun DONE.
 [events: 0000000e]
 [events: 0000000e]
md: autorun ...
md: considering sdc1 ...
md:  adding sdc1 ...
md:  adding sda3 ...
md: created md1
md: bind<sda3,1>
md: bind<sdc1,2>
md: running: <sdc1><sda3>
md: sdc1's event counter: 0000000e
md: sda3's event counter: 0000000e
md: md1: raid array is not clean -- starting background reconstruction
md: RAID level 1 does not need chunksize! Continuing anyway.
md1: max total readahead window set to 124k
md1: 1 data-disks, max readahead per data-disk: 124k
raid1: device sdc1 operational as mirror 1
raid1: device sda3 operational as mirror 0
raid1: raid set md1 not clean; reconstructing mirrors
raid1: raid set md1 active with 2 out of 2 mirrors
md: syncing RAID array md1
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000 KB/sec) for reconstruction.
md: using 124k window, over a total of 15999936 blocks.
md: updating md1 RAID superblock on device
md: sdc1 [events: 0000000f]<6>(write) sdc1's sb offset: 16000640
md: sda3 [events: 0000000f]<6>(write) sda3's sb offset: 15999936
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,0), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on md(9,1), internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
sym1:1: ERROR (81:0) (c-2c-0) (3e/18/80) @ (scripta a88:14000000).
sym1: script cmd = 10000000
sym1: regdump: da 10 c0 18 47 3e 01 0e 00 0c 80 2c 80 00 0c 08 00 ac bb 37 0a 00 00 00.
sym1: SCSI BUS reset detected.
sym1: SCSI BUS has been reset.
md: md1: sync done.
sym0:1: ERROR (81:0) (d-2d-6c) (3e/18/80) @ (scripta 728:15000000).
sym0: script cmd = 11000000
sym0: regdump: da 10 c0 18 47 3e 01 0e 04 0d 81 2d 80 00 0d 08 00 54 fb 36 0a 00 00 00.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
md: md0: sync done.
sym0:0: ERROR (81:0) (8-0-0) (3e/18/80) @ (scripta 50:f31c0004).
sym0: script cmd = 90080000
sym0: regdump: da 00 00 18 47 3e 00 0f 00 08 80 00 80 00 07 02 01 00 00 00 02 00 00 00.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.

--=-YGWQoSotNfay/G1q7r64
Content-Disposition: attachment; filename=lspci.txt
Content-Type: text/plain; name=lspci.txt; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
00:08.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter (rev 01)
00:08.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 Ultra3 SCSI Adapter (rev 01)
00:0a.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5701 Gigabit Ethernet (rev 15)
00:0c.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

--=-YGWQoSotNfay/G1q7r64--

