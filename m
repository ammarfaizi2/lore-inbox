Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRLWUIe>; Sun, 23 Dec 2001 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLWUIZ>; Sun, 23 Dec 2001 15:08:25 -0500
Received: from web14205.mail.yahoo.com ([216.136.172.151]:14635 "HELO
	web14205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284141AbRLWUIR>; Sun, 23 Dec 2001 15:08:17 -0500
Message-ID: <20011223200816.58747.qmail@web14205.mail.yahoo.com>
Date: Sun, 23 Dec 2001 12:08:16 -0800 (PST)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: more Ali pci strangeness
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having fun with pci on my desktop.  MB is an asus with Ali chipset, basically
the same chipset ppl were having problems with on their laptops.  My problem is
it spews error messages on bootup about my PCI and suggests that I try
pci=biosirq.  This makes the messages slightly better.  I am attatching a dmesg
with that parameter turned on.  This box has 2 nics and a linksys wireless nic
as well as a soundblaster live soundcard.  I haven't tried the usb on this, but
I do know that the sound had problems with finding an interrupt.  Compliled as
a module, the soundcard can't be found.  It's pci config space is all f's when
I look at lspci.  Anyway to fix this?

TIA
Erik McKee

cc. me as I'm not on list 

Dec 22 14:30:35 Camhanaich kernel: Linux version 2.4.17 (root@Camhanaich) (gcc
version 2.95.3 20010315 (release)) #17 Sat Dec 22 11:11:41 CST 2001
Dec 22 14:30:35 Camhanaich kernel:  BIOS-e801: 0000000000000000 -
000000000009f000
 (usable)
Dec 22 14:30:35 Camhanaich kernel:  BIOS-e801: 0000000000100000 -
0000000007ff0000
 (usable)
Dec 22 14:30:35 Camhanaich kernel: On node 0 totalpages: 32752
Dec 22 14:30:35 Camhanaich kernel: zone(0): 4096 pages.
Dec 22 14:30:35 Camhanaich kernel: zone(1): 28656 pages.
Dec 22 14:30:35 Camhanaich kernel: zone(2): 0 pages.
Dec 22 14:30:35 Camhanaich kernel: Kernel command line: auto BOOT_IMAGE=linux
ro root=900 pci=biosirq
Dec 22 14:30:35 Camhanaich kernel: Detected 501.147 MHz processor.
Dec 22 14:30:35 Camhanaich kernel: Console: colour VGA+ 80x25
Dec 22 14:30:35 Camhanaich kernel: Calibrating delay loop... 999.42 BogoMIPS
Dec 22 14:30:35 Camhanaich kernel: Memory: 126372k/131008k available (1285k
kernel code, 4248k reserved, 428k data, 220k init, 0k highmem)
Dec 22 14:30:35 Camhanaich kernel: Dentry-cache hash table entries: 16384
(order: 5, 131072 bytes)
Dec 22 14:30:35 Camhanaich kernel: Inode-cache hash table entries: 8192 (order:
4, 65536 bytes)
Dec 22 14:30:35 Camhanaich kernel: Mount-cache hash table entries: 2048 (order:
2, 16384 bytes)
Dec 22 14:30:35 Camhanaich kernel: Buffer-cache hash table entries: 4096
(order: 2, 16384 bytes)
Dec 22 14:30:35 Camhanaich kernel: Page-cache hash table entries: 32768 (order:
5, 131072 bytes)
Dec 22 14:30:35 Camhanaich kernel: CPU: AMD-K6(tm) 3D processor stepping 0c
Dec 22 14:30:35 Camhanaich kernel: POSIX conformance testing by UNIFIX
Dec 22 14:30:35 Camhanaich kernel: mtrr: v1.40 (20010327) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 22 14:30:35 Camhanaich kernel: mtrr: detected mtrr type: AMD K6
Dec 22 14:30:35 Camhanaich kernel: PCI: PCI BIOS revision 2.10 entry at
0xf06c0, last bus=1
Dec 22 14:30:35 Camhanaich kernel: PCI: Using configuration type 1
Dec 22 14:30:35 Camhanaich kernel: PCI: Probing PCI hardware
Dec 22 14:30:35 Camhanaich kernel: PCI: device 00:0d.1 has unknown header type
7f, ignoring.
Dec 22 14:30:35 Camhanaich kernel: PCI: device 00:0d.1 has unknown header type
7f, ignoring.
Dec 22 14:30:35 Camhanaich kernel: Unknown bridge resource 0: assuming
transparent
Dec 22 14:30:35 Camhanaich kernel: Unknown bridge resource 0: assuming
transparent
Dec 22 14:30:35 Camhanaich kernel: PCI: Error while updating region 00:0d.0/0
(00001001 != ffffffff)
Dec 22 14:30:35 Camhanaich kernel: PCI: Error while updating region 00:0d.0/0
(00001001 != ffffffff)
Dec 22 14:30:35 Camhanaich kernel: PCI: Device 00:68 not found by BIOS
Dec 22 14:30:36 Camhanaich modprobe: modprobe: Can't locate module net-pf-10
Dec 22 14:30:36 Camhanaich modprobe: modprobe: Can't locate module net-pf-10
Dec 22 14:30:35 Camhanaich kernel: Initializing RT netlink socket
Dec 22 14:30:35 Camhanaich kernel: Starting kswapd
Dec 22 14:30:35 Camhanaich kernel: Console: switching to colour frame buffer
device 80x30
Dec 22 14:30:35 Camhanaich kernel: pty: 256 Unix98 ptys configured
Dec 22 14:30:35 Camhanaich kernel: block: 128 slots per queue, batch=32
Dec 22 14:30:35 Camhanaich kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 22 14:30:35 Camhanaich kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
Dec 22 14:30:35 Camhanaich kernel: PCI: No IRQ known for interrupt pin A of
device 00:0f.0.
Dec 22 14:30:35 Camhanaich kernel: ALI15X3: chipset revision 193
Dec 22 14:30:35 Camhanaich kernel: ALI15X3: not 100% native mode: will probe
irqs later
Dec 22 14:30:35 Camhanaich kernel:     ide0: BM-DMA at 0xb400-0xb407, BIOS
settings: hda:DMA, hdb:DMA
Dec 22 14:30:35 Camhanaich kernel:     ide1: BM-DMA at 0xb408-0xb40f, BIOS
settings: hdc:DMA, hdd:pio
Dec 22 14:30:35 Camhanaich kernel: hda: Conner Peripherals 1080MB - CFS1081A,
ATA DISK drive
Dec 22 14:30:35 Camhanaich kernel: hdb: SAMSUNG VG34323A (4.32GB), ATA DISK
drive
Dec 22 14:30:35 Camhanaich kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Dec 22 14:30:35 Camhanaich kernel: hdc: QUANTUM FIREBALLlct08 04, ATA DISK
drive
Dec 22 14:30:35 Camhanaich kernel: hdd: Memorex CRW-1622, ATAPI CD/DVD-ROM
drive
Dec 22 14:30:35 Camhanaich kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 22 14:30:35 Camhanaich kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 22 14:30:35 Camhanaich kernel: hdd: ATAPI 6X CD-ROM CD-R/RW drive, 1024kB
Cache, DMA
Dec 22 14:30:35 Camhanaich kernel: 3c59x: Donald Becker and others.
www.scyld.com/network/vortex.html
Dec 22 14:30:35 Camhanaich kernel: eth1: RealTek RTL-8029 found at 0xb800, IRQ
10, 00:C0:F0:5B:62:4B.
Dec 22 14:30:35 Camhanaich kernel:    8regs     :   720.400 MB/sec
Dec 22 14:30:35 Camhanaich kernel:    32regs    :   525.200 MB/sec
Dec 22 14:30:35 Camhanaich kernel:    pII_mmx   :  1062.400 MB/sec
Dec 22 14:30:35 Camhanaich kernel:    p5_mmx    :  1040.400 MB/sec
Dec 22 14:30:35 Camhanaich kernel: raid5: using function: pII_mmx (1062.400
MB/sec)
Dec 22 14:30:35 Camhanaich kernel: md0: WARNING: hdb2 appears to be on the same
physical disk as hdb1. True
Dec 22 14:30:35 Camhanaich kernel:      protection against single-disk failure
might be compromised.
Dec 22 14:30:35 Camhanaich kernel: md0: WARNING: hdc2 appears to be on the same
physical disk as hdc1. True
Dec 22 14:30:35 Camhanaich kernel:      protection against single-disk failure
might be compromised.
Dec 22 14:30:35 Camhanaich kernel: raid5: raid level 5 set md0 active with 4
out of 4 devices, algorithm 2
Dec 22 14:30:35 Camhanaich kernel: RAID5 conf printout:
Dec 22 14:30:35 Camhanaich kernel:  --- rd:4 wd:4 fd:0
Dec 22 14:30:35 Camhanaich kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdb1
Dec 22 14:30:35 Camhanaich kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc1
Dec 22 14:30:35 Camhanaich kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdb2
Dec 22 14:30:35 Camhanaich kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdc2
Dec 22 14:30:35 Camhanaich kernel: RAID5 conf printout:
Dec 22 14:30:35 Camhanaich kernel:  --- rd:4 wd:4 fd:0
Dec 22 14:30:35 Camhanaich kernel:  disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdb1
Dec 22 14:30:35 Camhanaich kernel:  disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc1
Dec 22 14:30:35 Camhanaich kernel:  disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hdb2
Dec 22 14:30:35 Camhanaich kernel:  disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdc2
Dec 22 14:30:35 Camhanaich kernel: IP: routing cache hash table of 512 buckets,
4Kbytes
Dec 22 14:30:35 Camhanaich kernel: TCP: Hash tables configured (established
8192 bind 8192)
Dec 22 14:30:35 Camhanaich kernel: ip_conntrack (1023 buckets, 8184 max)
Dec 22 14:30:35 Camhanaich kernel: raid5: switching cache buffer size, 4096 -->
1024
Dec 22 14:30:35 Camhanaich kernel: md: swapper(pid 1) used obsolete MD ioctl,
upgrade your software to use new ictls.
Dec 22 14:30:35 Camhanaich kernel: raid5: switching cache buffer size, 1024 -->
4096
Dec 22 14:30:35 Camhanaich kernel: reiserfs: checking transaction log (device
09:00) ...
Dec 22 14:30:35 Camhanaich kernel: Using r5 hash to sort names
Dec 22 14:30:35 Camhanaich kernel: ReiserFS version 3.6.25
Dec 22 14:30:35 Camhanaich kernel: VFS: Mounted root (reiserfs filesystem)
readonly.
Dec 22 14:30:35 Camhanaich kernel: Freeing unused kernel memory: 220k freed
Dec 22 14:30:35 Camhanaich kernel: EXT2-fs warning: mounting unchecked fs,
running e2fsck is recommended
Dec 22 14:30:35 Camhanaich kernel: reiserfs: checking transaction log (device
03:03) ...
Dec 22 14:30:35 Camhanaich kernel: Using r5 hash to sort names
Dec 22 14:30:35 Camhanaich kernel: ReiserFS version 3.6.25

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
