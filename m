Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJZPbW>; Sat, 26 Oct 2002 11:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSJZPbW>; Sat, 26 Oct 2002 11:31:22 -0400
Received: from smtp01.wxs.nl ([195.121.6.61]:28338 "EHLO smtp01.wxs.nl")
	by vger.kernel.org with ESMTP id <S261424AbSJZPbS>;
	Sat, 26 Oct 2002 11:31:18 -0400
Message-ID: <000c01c27d05$96c0ee50$1400a8c0@Freaky>
From: "freaky" <freaky@freaky2000.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: KT333, IO-APIC, Promise Fasttrak, Initrd [UPDATE]
Date: Sat, 26 Oct 2002 17:37:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

in addition to my previous posts with this topic I would like to post the
kernel output.

Additional info:
kernel 2.4.20-pre11
gcc version 2.95.3 20010315 (release)
Kernel config: http://freaky.bananateam.nl/config

BIOS-e820:
#Stripped insignificant zeros
0-9FC00 (usable)
9FC00-A0000 (reserved)
F0000-100000 (reserved)
100000-1fff0000 (usable)
1FFF0000-1FFF8000 (ACPI DATA)
1FFF8000-20000000 (ACPI NVS)
FEC00000-FEC01000 (reserved)
FEE00000-FEE01000 (reserved)
FFF800000-100000000 (reserved)
511MB LOWMEM available
found SMP MP-table at 000FB940 # Is the uniprocessor IO-APIC causing this?
AFAIK I didn't include SMP....
hm, page 000FB000 reserved twice
hm, page 000FC000 reserved twice
hm, page 000F6000 reserved twice
hm, page 000F7000 reserved twice
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
Virtual Wire compatibility mode.
OEM ID: VIA Product ID: VT5440B APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 3 at 0xFEC00000.
Processors: 1
Kernel command line: vmlinuz ramdisk_size=7000 root=/dev/fd0u1440 vga=normal
rw SLACK_KERNEL=new.i BOOT_IMAGE=vmlinuz root=/dev/fd0
Initializing CPU#0
Detected 1666.740 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3322.67 BogoMIPS
Memory: 516472k/524224k available (1041k kernel code, 7364k reserved, 311k
data, 100k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000080
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17, 2-18, 2-20, 2-21, 2-23 not
connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
....... : physical APIC id: 02
.... register #01: 00178003
....... : max redirection entries: 0017
....... : PRQ implemented: 1
....... : IO APIC version: 0003
WARNING: unexpected IO-APIC, please mail
to linux-smp@vger.kernel.org
.... IRQ redirection table:
NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
00 000 00 1 0 0 0 0 0 0 00
01 001 01 0 0 0 0 0 1 1 39
02 001 01 0 0 0 0 0 1 1 31
03 001 01 0 0 0 0 0 1 1 41
04 001 01 0 0 0 0 0 1 1 49
05 000 00 1 0 0 0 0 0 0 00
06 001 01 0 0 0 0 0 1 1 51
07 001 01 0 0 0 0 0 1 1 59
08 001 01 0 0 0 0 0 1 1 61
09 001 01 0 0 0 0 0 1 1 69
0a 000 00 1 0 0 0 0 0 0 00
0b 000 00 1 0 0 0 0 0 0 00
0c 001 01 0 0 0 0 0 1 1 71
0d 001 01 0 0 0 0 0 1 1 79
0e 001 01 0 0 0 0 0 1 1 81
0f 001 01 0 0 0 0 0 1 1 89
10 001 01 1 1 0 1 0 1 1 91
11 000 00 1 0 0 0 0 0 0 00
12 000 00 1 0 0 0 0 0 0 00
13 001 01 1 1 0 1 0 1 1 99
14 000 00 1 0 0 0 0 0 0 00
15 000 00 1 0 0 0 0 0 0 00
16 001 01 1 1 0 1 0 1 1 A1
17 000 00 1 0 0 0 0 0 0 00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
IRQ22 -> 0:22
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1666.7379 MHz.
..... host bus clock speed is 266.6780 MHz.
cpu: 0, clocks: 2666780, slice: 1333390
CPU0<T0:2666768,T1:1333376,D:2,S:1333390,C:2666780>
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router default [1106/3177] at 00:11.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B0,I17,P2) -> 22
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20276: IDE controller on PCI bus 00 dev 60
PDC20276: chipset revision 1
PDC20276: not 100% native mode: will probe irqs later
ide2: BM-DMA at 0xdc00-0xdc07, BIOS settings: hde:pio, hdf:pio
ide3: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller on PCI bus 00 dev 89
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@ucw.cz>
hda: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
hdc: LITE-ON LTR-12101B, ATAPI CD/DVD-ROM drive
hde: QUANTUM FIREBALLP AS30.0, ATA DISK drive
hdf: ST340810A, ATA DISK drive
hdg: IBM-DTLA-307020, ATA DISK drive
hdh: Maxtor 91741U4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide0: probed IRQ 14 failed, using default.
ide1 at 0x170-0x177,0x376 on irq 15
ide1: probed IRQ 15 failed, using default.
ide2 at 0xec00-0xec07,0xe802 on irq 19
ide3 at 0xe400-0xe407,0xe002 on irq 19
hde: 58633344 sectors (30020 MB) w/1902KiB Cache, CHS=58168/16/63
hdf: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
hdg: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63
hdh: 34004880 sectors (17410 MB) w/512KiB Cache, CHS=33735/16/63
hda: ATAPI 40X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
Partition check:
hde: [PTBL] [3649/255/63] hde1 hde2 < hde5 >
hdf: [PTBL] [4865/255/63] hdf1
hdg: [PTBL] [2501/255/63] hdg1
hdh: [PTBL] [2116/255/63] hdh1 hdh2 hdh3 hdh4 < hdh5 hdh6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 7000K size 1024 blocksize
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe0800f00, 00:40:f4:55:38:a7, IRQ 19
eth0: Identified 8139 chip type 'RTL-8139C'
ataraid/d0: ataraid/d0p1 ataraid/d0p2 < ataraid/d0p5 >
Drive 0 is 28629 Mb (33 / 0)
Raid0 array consists of 1 drives.
ataraid/d1: ataraid/d1p1
Drive 0 is 38166 Mb (33 / 64)
Raid0 array consists of 1 drives.
ataraid/d2: ataraid/d2p1
Drive 0 is 19623 Mb (34 / 0)
Raid0 array consists of 1 drives.
ataraid/d3: ataraid/d3p1 ataraid/d3p2 ataraid/d3p3 ataraid/d3p4 <
ataraid/d3p5 ataraid/d3p6 >
Drive 0 is 16603 Mb (34 / 64)
Raid0 array consists of 1 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 100k freed

That was the rescuedisk (compressed 1 disk image)
with the 5 install disks (wget
ftp://ftp.slackware.org/slackware/slackware-current/rootdisks/install.[1-5])
It gives:
RAMDISK: ext2 fs found at block 0
Loading 6464 blocks [5 disks] into ram disk
VFS: Insert disk #2 and press ENTER # It reads this disk in 0.5 secs or so?
Loading disk #2...
VFS: Insert disk #3 and press ENTER # It reads this disk in 0.5 secs or so?
Loading disk #2...
VFS: Insert disk #4 and press ENTER # It reads this disk in 0.5 secs or so?
Loading disk #2...
VFS: Insert disk #5 and press ENTER # It reads this disk in 0.5 secs or so?
Loading disk #2...
Then it boots and comes up with ext2 filesystem errors on directory #41.
Sometimes it starts actually reading at disk 3 or 4, but it never actually
reads disk 2... Most of the time it doesn't actually read any disk but 1
though (the floppy read LED does go on tho'). Since disk 2 is never loaded
it always comes up with the directory #41 ext2 fs errors.




