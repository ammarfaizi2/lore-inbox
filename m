Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316660AbSEWNuX>; Thu, 23 May 2002 09:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316668AbSEWNuW>; Thu, 23 May 2002 09:50:22 -0400
Received: from pier.botik.ru ([193.232.174.1]:43025 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id <S316660AbSEWNuV>;
	Thu, 23 May 2002 09:50:21 -0400
Message-ID: <3CECF59B.D471F505@namesys.botik.ru>
Date: Thu, 23 May 2002 17:58:51 +0400
From: "Gryaznova E." <grev@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.19-pre6-testing i686)
X-Accept-Language: en
MIME-Version: 1.0
To: martin@dalecki.de
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: IDE problem: linux-2.5.17
Content-Type: multipart/mixed;
 boundary="------------075F53661DA46ED700BD73E1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------075F53661DA46ED700BD73E1
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit

Hello.

Kernel starting from 2.5.8 can not boot my Suse 6.4. Booting on those
kernels (tested 2.5.8, 2.5.9 and 2.5.17) I am always getting

{ dma_intr }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: recalibrating!

and system either hangs or falls into endless loop.

Kernel 2.5.7 boots and works just fine.
The boot log containing information about hardware is attached.

Badblock does not see any bad blocks.

Thanks for any clue on the problem.
Lena.




--------------075F53661DA46ED700BD73E1
Content-Type: text/plain; charset=koi8-r;
 name="2.5.7.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.7.dmesg"

Linux version 2.5.7 (grev@silver) (gcc version 2.95.2 19991024 (release)) #1 SMP Fri Mar 29 16:20:45 MSK 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2.5.7 ro root=306 vga=0x0301
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 698.666 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1392.64 BogoMIPS
Memory: 256464k/262080k available (1241k kernel code, 5232k reserved, 430k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
WARNING: This combination of AMD processors is not suitable for SMP.
CPU0: AMD Athlon(tm) Processor stepping 01
per-CPU timeslice cutoff: 1463.62 usecs.
task migration cache decay timeout: 10 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 698.6489 MHz.
..... host bus clock speed is 199.6139 MHz.
cpu: 0, clocks: 1996139, slice: 998069
CPU0<T0:1996128,T1:998048,D:11,S:998069,C:1996139>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.24-pre1
Copyright (c) 2002 Intel Corporation

eth0: Intel(R) PRO/100+ Management Adapter
  Mem:0xe5101000  IRQ:11  Speed:100 Mbps  Dx:Full
  Hardware receive checksums enabled
  cpu cycle saver enabled

[drm] Initialized tdfx 1.0.0 20010216 on minor 0
Uniform Multi-Platform E-IDE driver ver.:7.0.0
ide: system bus speed 33MHz
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: IDE controller on PCI slot 00:07.1
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: chipset revision 3
Advanced Micro Devices [AMD] AMD-756 [Viper] IDE: not 100% native mode: will probe irqs later
AMD_IDE: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 03) UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJNA-371800, ATA DISK drive
hdc: SONY CDU4811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c033dd0c, I/O limit 4095Mb (mask 0xffffffff)
hda: 35239680 sectors (18043 MB) w/1966KiB Cache, CHS=34960/16/63, (U)DMA
Partition check:
 hda: [PTBL] [2193/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
Advanced Linux Sound Architecture Driver Version 0.9.0beta12 (Mon Mar 18 15:44:40 2002 UTC).
kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno = 2
ALSA device list:
  No soundcards found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 10922)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide0: reset: success
Adding Swap: 136544k swap-space (priority -1)

--------------075F53661DA46ED700BD73E1--

