Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSG2AFa>; Sun, 28 Jul 2002 20:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSG2AFa>; Sun, 28 Jul 2002 20:05:30 -0400
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:18562
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id <S317435AbSG2AF0> convert rfc822-to-8bit; Sun, 28 Jul 2002 20:05:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: APIC Error, AMD 1800XP, VIAKT333, UP
Date: Sun, 28 Jul 2002 20:08:45 -0400
User-Agent: KMail/1.4.1
Cc: linux-smp@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207282008.45409.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I enable the APIC on in my bios (this is an ABIT KX7-333), i get 

APIC Error CPU0: 02(02)

here's a syslog excerpt (sorry, don't have a /var/log/dmesg from an 
APIC-enabled boot.

Anyway, any help much appreciated.

Jul 28 16:35:02 tabriel kernel: Buffer cache hash table entries: 16384 (order: 
4, 65536 bytes)
Jul 28 16:35:02 tabriel kernel: Page-cache hash table entries: 65536 (order: 
6, 262144 bytes)
Jul 28 16:35:02 tabriel kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Jul 28 16:35:02 tabriel kernel: CPU: L2 Cache: 256K (64 bytes/line)
Jul 28 16:35:02 tabriel kernel: Intel machine check architecture supported.
Jul 28 16:35:02 tabriel kernel: Intel machine check reporting enabled on 
CPU#0.
Jul 28 16:35:02 tabriel kernel: CPU: AMD Athlon(tm) XP 1800+ stepping 02
Jul 28 16:35:02 tabriel kernel: Enabling fast FPU save and restore... done.
Jul 28 16:35:02 tabriel kernel: Enabling unmasked SIMD FPU exception 
support... done.
Jul 28 16:35:02 tabriel kernel: Checking 'hlt' instruction... OK.
Jul 28 16:35:02 tabriel kernel: POSIX conformance testing by UNIFIX
Jul 28 16:35:02 tabriel kernel: enabled ExtINT on CPU#0
Jul 28 16:35:02 tabriel kernel: ESR value before enabling vector: 00000000
Jul 28 16:35:02 tabriel kernel: ESR value after enabling vector: 00000000
Jul 28 16:35:02 tabriel kernel: ENABLING IO-APIC IRQs
Jul 28 16:35:02 tabriel kernel: Setting 2 in the phys_id_present_map
Jul 28 16:35:02 tabriel kernel: ...changing IO-APIC physical APIC ID to 2 ... 
ok.
Jul 28 16:35:02 tabriel kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jul 28 16:35:02 tabriel kernel: testing the IO APIC.......................
Jul 28 16:35:02 tabriel kernel: 
Jul 28 16:35:02 tabriel kernel: An unexpected IO-APIC was found. If this 
kernel release is less than
Jul 28 16:35:02 tabriel kernel: three months old please report this to 
linux-smp@vger.kernel.org
Jul 28 16:35:02 tabriel kernel: .................................... done.
Jul 28 16:35:02 tabriel kernel: Using local APIC timer interrupts.
Jul 28 16:35:02 tabriel kernel: calibrating APIC timer ...
Jul 28 16:35:02 tabriel kernel: ..... CPU clock speed is 1534.0852 MHz.
Jul 28 16:35:02 tabriel kernel: ..... host bus clock speed is 266.7974 MHz.
Jul 28 16:35:02 tabriel kernel: cpu: 0, clocks: 2667974, slice: 1333987
Jul 28 16:35:02 tabriel kernel: 
CPU0<T0:2667968,T1:1333968,D:13,S:1333987,C:2667974>
Jul 28 16:35:02 tabriel kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jul 28 16:35:02 tabriel kernel: mtrr: detected mtrr type: Intel
Jul 28 16:35:02 tabriel kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, 
last bus=1
Jul 28 16:35:02 tabriel kernel: PCI: Using configuration type 1
Jul 28 16:35:02 tabriel kernel: PCI: Probing PCI hardware
Jul 28 16:35:02 tabriel kernel: Unknown bridge resource 0: assuming 
transparent
Jul 28 16:35:02 tabriel kernel: PCI: Using IRQ router default [1106/3099] at 
00:00.0
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I8,P0) -> 19
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I9,P0) -> 18
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I13,P0) -> 17
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I17,P0) -> 11
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I17,P3) -> 21
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B0,I17,P3) -> 21
Jul 28 16:35:02 tabriel kernel: PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Jul 28 16:35:02 tabriel kernel: PCI: Via IRQ fixup for 00:11.2, from 11 to 5
Jul 28 16:35:02 tabriel kernel: PCI: Via IRQ fixup for 00:11.3, from 11 to 5
Jul 28 16:35:02 tabriel kernel: Linux NET4.0 for Linux 2.4
Jul 28 16:35:02 tabriel kernel: Based upon Swansea University Computer Society 
NET3.039
Jul 28 16:35:02 tabriel kernel: Initializing RT netlink socket
Jul 28 16:35:02 tabriel kernel: apm: BIOS version 1.2 Flags 0x07 (Driver 
version 1.16)
Jul 28 16:35:02 tabriel kernel: Starting kswapd
Jul 28 16:35:02 tabriel kernel: Journalled Block Device driver loaded
Jul 28 16:35:02 tabriel kernel: devfs: v1.12a (20020514) Richard Gooch 
(rgooch@atnf.csiro.au)
Jul 28 16:35:02 tabriel kernel: devfs: devfs_debug: 0x0
Jul 28 16:35:02 tabriel kernel: devfs: boot_options: 0x1
Jul 28 16:35:02 tabriel kernel: pty: 256 Unix98 ptys configured
Jul 28 16:35:02 tabriel kernel: Real Time Clock Driver v1.10e
Jul 28 16:35:02 tabriel kernel: block: 496 slots per queue, batch=124
Jul 28 16:35:02 tabriel kernel: Uniform Multi-Platform E-IDE driver Revision: 
6.31
Jul 28 16:35:02 tabriel kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Jul 28 16:35:02 tabriel kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Jul 28 16:35:02 tabriel kernel: VP_IDE: chipset revision 6
Jul 28 16:35:02 tabriel kernel: VP_IDE: not 100%% native mode: will probe irqs 
later
Jul 28 16:35:02 tabriel kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Jul 28 16:35:02 tabriel kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 
controller on pci00:11.1
Jul 28 16:35:02 tabriel kernel:     ide0: BM-DMA at 0xdc00-0xdc07, BIOS 
settings: hda:DMA, hdb:DMA
Jul 28 16:35:02 tabriel kernel:     ide1: BM-DMA at 0xdc08-0xdc0f, BIOS 
settings: hdc:DMA, hdd:DMA
Jul 28 16:35:02 tabriel kernel: hdb: C/H/S=17486/16/255 from BIOS ignored
Jul 28 16:35:02 tabriel kernel: hda: WDC AC28400R, ATA DISK drive
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 00(02)
Jul 28 16:35:02 tabriel kernel: hdb: Maxtor 93652U8, ATA DISK drive
Jul 28 16:35:02 tabriel kernel: hdc: TOSHIBA DVD-ROM SD-M1202, ATAPI 
CD/DVD-ROM drive
Jul 28 16:35:02 tabriel kernel: hdd: WDC AC28400R, ATA DISK drive
Jul 28 16:35:02 tabriel kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 28 16:35:02 tabriel kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 28 16:35:02 tabriel kernel: hda: task_no_data_intr: status=0x51 { 
DriveReady SeekComplete Error }
Jul 28 16:35:02 tabriel kernel: hda: task_no_data_intr: error=0x04 { 
DriveStatusError }
Jul 28 16:35:02 tabriel kernel: hda: host protected area => 1
Jul 28 16:35:02 tabriel kernel: hda: 16514064 sectors (8455 MB) w/512KiB 
Cache, CHS=1027/255/63, (U)DMA
Jul 28 16:35:02 tabriel kernel: hdb: host protected area => 1
Jul 28 16:35:02 tabriel kernel: hdb: 71346240 sectors (36529 MB) w/2048KiB 
Cache, CHS=70780/16/63, UDMA(66)
Jul 28 16:35:02 tabriel kernel: hdd: task_no_data_intr: status=0x51 { 
DriveReady SeekComplete Error }
Jul 28 16:35:02 tabriel kernel: hdd: task_no_data_intr: error=0x04 { 
DriveStatusError }
Jul 28 16:35:02 tabriel kernel: hdd: host protected area => 1
Jul 28 16:35:02 tabriel kernel: hdd: 16514064 sectors (8455 MB) w/512KiB 
Cache, CHS=16383/16/63, UDMA(33)
Jul 28 16:35:02 tabriel kernel: Partition check:
Jul 28 16:35:02 tabriel kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Jul 28 16:35:02 tabriel kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 
> p3
Jul 28 16:35:02 tabriel kernel:  /dev/ide/host0/bus1/target1/lun0: p1
Jul 28 16:35:02 tabriel kernel: Floppy drive(s): fd0 is 1.44M
Jul 28 16:35:02 tabriel kernel: FDC 0 is a post-1991 82077
Jul 28 16:35:02 tabriel kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Jul 28 16:35:02 tabriel kernel: agpgart: Maximum main memory to use for agp 
memory: 203M
Jul 28 16:35:02 tabriel kernel: agpgart: Detected Via Apollo Pro KT266 chipset
Jul 28 16:35:02 tabriel kernel: agpgart: AGP aperture is 32M @ 0xe0000000
Jul 28 16:35:02 tabriel kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 28 16:35:02 tabriel kernel: IP Protocols: ICMP, UDP, TCP
Jul 28 16:35:02 tabriel kernel: IP: routing cache hash table of 2048 buckets, 
16Kbytes
Jul 28 16:35:02 tabriel kernel: TCP: Hash tables configured (established 16384 
bind 32768)
Jul 28 16:35:02 tabriel kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set 
ON
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: - it is slow mode for 
debugging.
Jul 28 16:35:02 tabriel kernel: reiserfs: checking transaction log (device 
03:03) ...
Jul 28 16:35:02 tabriel kernel: Using r5 hash to sort names
Jul 28 16:35:02 tabriel kernel: ReiserFS version 3.6.25
Jul 28 16:35:02 tabriel kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
Jul 28 16:35:02 tabriel kernel: Mounted devfs on /dev
Jul 28 16:35:02 tabriel kernel: Freeing unused kernel memory: 220k freed
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel last message repeated 9 times
Jul 28 16:35:02 tabriel kernel: Adding Swap: 265064k swap-space (priority -1)
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel last message repeated 3 times
Jul 28 16:35:02 tabriel kernel: hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, DMA
Jul 28 16:35:02 tabriel kernel: Uniform CD-ROM driver Revision: 3.12
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel kernel: kjournald starting.  Commit interval 5 seconds
Jul 28 16:35:02 tabriel kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,1), 
internal journal
Jul 28 16:35:02 tabriel kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel last message repeated 5 times
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set 
ON
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: - it is slow mode for 
debugging.
Jul 28 16:35:02 tabriel kernel: reiserfs: checking transaction log (device 
03:43) ...
Jul 28 16:35:02 tabriel kernel: Using r5 hash to sort names
Jul 28 16:35:02 tabriel kernel: ReiserFS version 3.6.25
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: CONFIG_REISERFS_CHECK is set 
ON
Jul 28 16:35:02 tabriel kernel: reiserfs:warning: - it is slow mode for 
debugging.
Jul 28 16:35:02 tabriel kernel: reiserfs: checking transaction log (device 
16:41) ...
Jul 28 16:35:02 tabriel kernel: Using tea hash to sort names
Jul 28 16:35:02 tabriel kernel: ReiserFS version 3.6.25
Jul 28 16:35:02 tabriel kernel: APIC error on CPU0: 02(02)
Jul 28 16:35:02 tabriel last message repeated 7 times

