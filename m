Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSLONL0>; Sun, 15 Dec 2002 08:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSLONL0>; Sun, 15 Dec 2002 08:11:26 -0500
Received: from vsmtp3.tin.it ([212.216.176.223]:5282 "EHLO smtp3.cp.tin.it")
	by vger.kernel.org with ESMTP id <S266520AbSLONLU>;
	Sun, 15 Dec 2002 08:11:20 -0500
Message-ID: <3DFC81C2.4020807@tin.it>
Date: Sun, 15 Dec 2002 14:21:06 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
References: <3DFB7B21.7040004@tin.it> <200212142019.14449.black666@inode.at> <3DFBC4F3.2070603@tin.it>
In-Reply-To: <3DFBC4F3.2070603@tin.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here the "kern.log" file in the loading of the ide support, so you can 
examine better the problem, Thank you very much, Bye

PS= The load of ide-cd is at the end, because I've load it after the 
system start.

Dec 11 00:05:36 valinor kernel: klogd 1.4.1#11, log source = /proc/kmsg 
started.
Dec 11 00:05:36 valinor kernel: Inspecting /boot/System.map-2.4.20
Dec 11 00:05:36 valinor kernel: Loaded 14676 symbols from 
/boot/System.map-2.4.20.
Dec 11 00:05:36 valinor kernel: Symbols match kernel version 2.4.20.
Dec 11 00:05:36 valinor kernel: Loaded 72 symbols from 4 modules.
Dec 11 00:05:36 valinor kernel: Linux version 2.4.20 (root@valinor) (gcc 
version 2.95.4 20011002 (Debian prerelease)) #1 Tue Dec 10 23:56:37 CET 2002
Dec 11 00:05:36 valinor kernel: BIOS-provided physical RAM map:
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 0000000000000000 - 
000000000009fc00 (usable)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 000000000009fc00 - 
00000000000a0000 (reserved)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 00000000000f0000 - 
0000000000100000 (reserved)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 0000000000100000 - 
000000001fff0000 (usable)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 000000001fff0000 - 
000000001fff8000 (ACPI data)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 000000001fff8000 - 
0000000020000000 (ACPI NVS)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 00000000fec00000 - 
00000000fec01000 (reserved)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 00000000fee00000 - 
00000000fee01000 (reserved)
Dec 11 00:05:36 valinor kernel:  BIOS-e820: 00000000fff80000 - 
0000000100000000 (reserved)
Dec 11 00:05:36 valinor kernel: 511MB LOWMEM available.
Dec 11 00:05:36 valinor kernel: On node 0 totalpages: 131056
Dec 11 00:05:36 valinor kernel: zone(0): 4096 pages.
Dec 11 00:05:36 valinor kernel: zone(1): 126960 pages.
Dec 11 00:05:36 valinor kernel: zone(2): 0 pages.
Dec 11 00:05:36 valinor kernel: Kernel command line: auto 
BOOT_IMAGE=Linux ro root=305 video=vesa:ywrap,mtrr
Dec 11 00:05:36 valinor kernel: Initializing CPU#0
Dec 11 00:05:36 valinor kernel: Detected 2255.176 MHz processor.
Dec 11 00:05:36 valinor kernel: Console: colour dummy device 80x25
Dec 11 00:05:36 valinor kernel: Calibrating delay loop... 4495.76 BogoMIPS
Dec 11 00:05:36 valinor kernel: Memory: 516504k/524224k available (990k 
kernel code, 7332k reserved, 377k data, 80k init, 0k highmem)
Dec 11 00:05:36 valinor kernel: Dentry cache hash table entries: 65536 
(order: 7, 524288 bytes)
Dec 11 00:05:36 valinor kernel: Inode cache hash table entries: 32768 
(order: 6, 262144 bytes)
Dec 11 00:05:36 valinor kernel: Mount-cache hash table entries: 8192 
(order: 4, 65536 bytes)
Dec 11 00:05:36 valinor kernel: Buffer-cache hash table entries: 32768 
(order: 5, 131072 bytes)
Dec 11 00:05:36 valinor kernel: Page-cache hash table entries: 131072 
(order: 7, 524288 bytes)
Dec 11 00:05:36 valinor kernel: CPU: L1 I Cache: 64K (64 bytes/line), D 
cache 64K (64 bytes/line)
Dec 11 00:05:36 valinor kernel: CPU: L2 Cache: 256K (64 bytes/line)
Dec 11 00:05:36 valinor kernel: Intel machine check architecture supported.
Dec 11 00:05:36 valinor kernel: Intel machine check reporting enabled on 
CPU#0.
Dec 11 00:05:36 valinor kernel: CPU:     After generic, caps: 0383fbff 
c1c3fbff 00000000 00000000
Dec 11 00:05:36 valinor kernel: CPU:             Common caps: 0383fbff 
c1c3fbff 00000000 00000000
Dec 11 00:05:36 valinor kernel: CPU: AMD Athlon(tm) XP 2400+ stepping 01
Dec 11 00:05:36 valinor kernel: Enabling fast FPU save and restore... done.
Dec 11 00:05:36 valinor kernel: Enabling unmasked SIMD FPU exception 
support... done.
Dec 11 00:05:36 valinor kernel: Checking 'hlt' instruction... OK.
Dec 11 00:05:36 valinor kernel: POSIX conformance testing by UNIFIX
Dec 11 00:05:36 valinor kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Dec 11 00:05:36 valinor kernel: mtrr: detected mtrr type: Intel
Dec 11 00:05:36 valinor kernel: PCI: PCI BIOS revision 2.10 entry at 
0xfdaf1, last bus=1
Dec 11 00:05:36 valinor kernel: PCI: Using configuration type 1
Dec 11 00:05:36 valinor kernel: PCI: Probing PCI hardware
Dec 11 00:05:36 valinor kernel: PCI: Using IRQ router default 
[1106/3177] at 00:11.0
Dec 11 00:05:36 valinor kernel: PCI: Hardcoded IRQ 14 for device 00:11.1
Dec 11 00:05:36 valinor kernel: Linux NET4.0 for Linux 2.4
Dec 11 00:05:36 valinor kernel: Based upon Swansea University Computer 
Society NET3.039
Dec 11 00:05:36 valinor kernel: Initializing RT netlink socket
Dec 11 00:05:36 valinor kernel: Starting kswapd
Dec 11 00:05:36 valinor kernel: devfs: v1.12c (20020818) Richard Gooch 
(rgooch@atnf.csiro.au)
Dec 11 00:05:36 valinor kernel: devfs: boot_options: 0x1
Dec 11 00:05:36 valinor kernel: vesafb: framebuffer at 0xd8000000, 
mapped to 0xe0800000, size 65536k
Dec 11 00:05:36 valinor kernel: vesafb: mode is 1024x768x32, 
linelength=4096, pages=1
Dec 11 00:05:36 valinor kernel: vesafb: protected mode interface info at 
c000:b7d0
Dec 11 00:05:36 valinor kernel: vesafb: pmi: set display start = 
c00cb815, set palette = c00cb89a
Dec 11 00:05:36 valinor kernel: vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 
3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
Dec 11 00:05:36 valinor kernel: vesafb: scrolling: ywrap using protected 
mode interface, yres_virtual=16384
Dec 11 00:05:36 valinor kernel: vesafb: directcolor: size=8:8:8:8, 
shift=24:16:8:0
Dec 11 00:05:36 valinor kernel: Console: switching to colour frame 
buffer device 128x48
Dec 11 00:05:36 valinor kernel: fb0: VESA VGA frame buffer device
Dec 11 00:05:36 valinor kernel: pty: 256 Unix98 ptys configured
Dec 11 00:05:36 valinor kernel: Real Time Clock Driver v1.10e
Dec 11 00:05:36 valinor kernel: Uniform Multi-Platform E-IDE driver 
Revision: 6.31
Dec 11 00:05:36 valinor kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Dec 11 00:05:36 valinor kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Dec 11 00:05:36 valinor kernel: PCI: Hardcoded IRQ 14 for device 00:11.1
Dec 11 00:05:36 valinor kernel: VP_IDE: chipset revision 6
Dec 11 00:05:36 valinor kernel: VP_IDE: not 100%% native mode: will 
probe irqs later
Dec 11 00:05:36 valinor kernel: ide: Assuming 33MHz system bus speed for 
PIO modes; override with idebus=xx
Dec 11 00:05:36 valinor kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 
controller on pci00:11.1
Dec 11 00:05:36 valinor kernel:     ide0: BM-DMA at 0xfc00-0xfc07, BIOS 
settings: hda:DMA, hdb:DMA
Dec 11 00:05:36 valinor kernel:     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS 
settings: hdc:DMA, hdd:DMA
Dec 11 00:05:36 valinor kernel: hda: QUANTUM FIREBALLP AS30.0, ATA DISK 
drive
Dec 11 00:05:36 valinor kernel: hdb: MAXTOR 6L060J3, ATA DISK drive
Dec 11 00:05:36 valinor kernel: hdc: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
Dec 11 00:05:36 valinor kernel: hdd: PCRW804, ATAPI CD/DVD-ROM drive
Dec 11 00:05:36 valinor kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 11 00:05:36 valinor kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 11 00:05:36 valinor kernel: blk: queue c0293364, I/O limit 4095Mb 
(mask 0xffffffff)
Dec 11 00:05:36 valinor kernel: hda: 58633344 sectors (30020 MB) 
w/1902KiB Cache, CHS=3649/255/63, UDMA(100)
Dec 11 00:05:36 valinor kernel: blk: queue c02934b0, I/O limit 4095Mb 
(mask 0xffffffff)
Dec 11 00:05:36 valinor kernel: hdb: 117266688 sectors (60041 MB) 
w/1819KiB Cache, CHS=7299/255/63, UDMA(133)
Dec 11 00:05:36 valinor kernel: Partition check:
Dec 11 00:05:36 valinor kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 
p3 < p5 p6 p7 p8 >
Dec 11 00:05:36 valinor kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 
< p5 > p3
Dec 11 00:05:36 valinor kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 11 00:05:36 valinor kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec 11 00:05:36 valinor kernel: IP: routing cache hash table of 4096 
buckets, 32Kbytes
Dec 11 00:05:36 valinor kernel: TCP: Hash tables configured (established 
32768 bind 32768)
Dec 11 00:05:36 valinor kernel: reiserfs: checking transaction log 
(device 03:05) ...
Dec 11 00:05:36 valinor kernel: Using r5 hash to sort names
Dec 11 00:05:36 valinor kernel: ReiserFS version 3.6.25
Dec 11 00:05:36 valinor kernel: VFS: Mounted root (reiserfs filesystem) 
readonly.
Dec 11 00:05:36 valinor kernel: Mounted devfs on /dev
Dec 11 00:05:36 valinor kernel: Freeing unused kernel memory: 80k freed
Dec 11 00:05:36 valinor kernel: NET4: Unix domain sockets 1.0/SMP for 
Linux NET4.0.
Dec 11 00:05:36 valinor kernel: Adding Swap: 506036k swap-space 
(priority -1)
Dec 11 00:05:36 valinor kernel: Adding Swap: 506036k swap-space 
(priority -2)
Dec 11 00:05:36 valinor kernel: Serial driver version 5.05c (2001-07-08) 
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Dec 11 00:05:36 valinor kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Dec 11 00:05:36 valinor kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Dec 11 00:05:36 valinor kernel: reiserfs: checking transaction log 
(device 03:01) ...
Dec 11 00:05:36 valinor kernel: Using r5 hash to sort names
Dec 11 00:05:36 valinor kernel: ReiserFS version 3.6.25
Dec 11 00:05:36 valinor kernel: reiserfs: checking transaction log 
(device 03:06) ...
Dec 11 00:05:36 valinor kernel: Using r5 hash to sort names
Dec 11 00:05:36 valinor kernel: ReiserFS version 3.6.25
Dec 11 00:05:36 valinor kernel: reiserfs: checking transaction log 
(device 03:07) ...
Dec 11 00:05:36 valinor kernel: Using r5 hash to sort names
Dec 11 00:05:36 valinor kernel: ReiserFS version 3.6.25
Dec 11 00:05:36 valinor kernel: reiserfs: checking transaction log 
(device 03:08) ...
Dec 11 00:05:36 valinor kernel: Using r5 hash to sort names
Dec 11 00:05:36 valinor kernel: ReiserFS version 3.6.25
Dec 11 00:05:36 valinor kernel: Journalled Block Device driver loaded
Dec 11 00:05:36 valinor kernel: kjournald starting.  Commit interval 5 
seconds
Dec 11 00:05:36 valinor kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,67), internal journal
Dec 11 00:05:36 valinor kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Dec 11 00:05:36 valinor kernel: kjournald starting.  Commit interval 5 
seconds
Dec 11 00:05:36 valinor kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,69), internal journal
Dec 11 00:05:36 valinor kernel: EXT3-fs: mounted filesystem with ordered 
data mode.
Dec 11 00:05:51 valinor kernel: SCSI subsystem driver Revision: 1.00
Dec 11 00:05:56 valinor kernel: hdc: status timeout: status=0xd0 { Busy }
Dec 11 00:05:56 valinor kernel: hdc: DMA disabled
Dec 11 00:05:56 valinor kernel: hdc: drive not ready for command
Dec 11 00:06:26 valinor kernel: hdc: ATAPI reset timed-out, status=0x80
Dec 11 00:06:31 valinor kernel: ide1: reset: success
Dec 11 00:06:31 valinor kernel: hdc: status timeout: status=0x80 { Busy }
Dec 11 00:06:31 valinor kernel: hdc: drive not ready for command
Dec 11 00:06:43 valinor kernel: Kernel logging (proc) stopped.
Dec 11 00:06:43 valinor kernel: Kernel log daemon terminating.

