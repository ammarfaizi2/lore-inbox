Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRJ2PtZ>; Mon, 29 Oct 2001 10:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276018AbRJ2PtQ>; Mon, 29 Oct 2001 10:49:16 -0500
Received: from isolaweb.it ([213.82.132.2]:38411 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S275990AbRJ2PtJ>;
	Mon, 29 Oct 2001 10:49:09 -0500
Message-Id: <5.1.0.14.2.20011029173849.02db1ec0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 17:46:38 +0100
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've a new Compaq Proliant ML350 PIII 1GHz with 1,1Gb RAM, SA-431 + 3HDD 
U160 RAID-5
below there's a strage mtrr's configuration. There's some problem on mtrr 
code to recognize
the regions or I missing something ?

Thanks!

dmesg output

Linux version 2.4.13 (root@ml350) (gcc version 2.96 20000731 (Red Hat Linux 
7.1 2.96-85)) #1 lun ott 29 17:23:04 CET 2001
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000048000000 (usable)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
256MB HIGHMEM available.
On node 0 totalpages: 294912
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 65536 pages.
Kernel command line: auto BOOT_IMAGE=linux ro root=4806 
BOOT_FILE=/boot/vmlinuz-2.4.13
Initializing CPU#0
Detected 993.400 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1979.18 BogoMIPS
Memory: 1159520k/1179648k available (711k kernel code, 19740k reserved, 
172k data, 184k init, 262144k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xede3e, last bus=4
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: 128 slots per queue, batch=16
cpqarray: Device 0x1011 has been found at bus 4 dev 4 func 0
PCI: Found IRQ 11 for device 04:04.0
Compaq SMART2 Driver (v 2.4.5)
Found 1 controller(s)
cpqarray: Finding drives on ida0 (Smart Array 431)
cpqarray ida/c0d0: blksz=512 nr_blks=71106240
Partition check:
  ida/c0d0: p1 p2 < p5 p6 >
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Found IRQ 15 for device 01:05.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:EC:C2:DA, IRQ 15.
   Board assembly 010101-034, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding Swap: 526296k swap-space (priority -1)
mtrr: your processor doesn't support write-combining
mtrr: your processor doesn't support write-combining
mtrr: your processor doesn't support write-combining
mtrr: your processor doesn't support write-combining


lspci -v output

00:00.0 Host bridge: ServerWorks CNB20LE (rev 05)
         Flags: bus master, medium devsel, latency 64
00:00.1 Host bridge: ServerWorks CNB20LE (rev 05)
         Flags: bus master, medium devsel, latency 64
00:01.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
         Flags: bus master, medium devsel, latency 128
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
         I/O behind bridge: 00001000-00002fff
         Memory behind bridge: f5100000-f6ffffff
         Capabilities: [dc] Power Management version 1
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 51)
         Subsystem: ServerWorks OSB4
         Flags: bus master, medium devsel, latency 0
00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master 
SecP PriP])
         Flags: bus master, medium devsel, latency 66
         I/O ports at 3000 [size=16]
00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 
10 [OHCI])
         Subsystem: ServerWorks: Unknown device 0220
         Flags: bus master, medium devsel, latency 64, IRQ 5
         Memory at f7000000 (32-bit, non-prefetchable) [size=4K]
01:04.0 SCSI storage controller: Adaptec 7899A (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device f620
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
         BIST result: 00
         I/O ports at 1000 [size=256]
         Memory at f5100000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
01:04.1 SCSI storage controller: Adaptec 7899A (rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device f620
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
         BIST result: 00
         I/O ports at 1400 [size=256]
         Memory at f5200000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
01:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
         Subsystem: Compaq Computer Corporation: Unknown device b134
         Flags: bus master, medium devsel, latency 66, IRQ 15
         Memory at f5400000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at 2000 [size=64]
         Memory at f5300000 (32-bit, non-prefetchable) [size=1M]
         Expansion ROM at <unassigned> [disabled] [size=1M]
         Capabilities: [dc] Power Management version 2
01:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
         Subsystem: Compaq Computer Corporation: Unknown device 001e
         Flags: bus master, stepping, medium devsel, latency 66, IRQ 5
         Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
         I/O ports at 1800 [size=256]
         Memory at f5500000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [5c] Power Management version 2
01:07.0 System peripheral: Compaq Computer Corporation Advanced System 
Management Controller
         Subsystem: Compaq Computer Corporation: Unknown device b0f3
         Flags: medium devsel, IRQ 10
         I/O ports at 1c00 [size=256]
         Memory at f5600000 (32-bit, non-prefetchable) [size=256]
04:04.0 RAID bus controller: Digital Equipment Corporation DECchip 21554 
(rev 01)
         Subsystem: Compaq Computer Corporation: Unknown device 4058
         Flags: bus master, medium devsel, latency 66, IRQ 11
         Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at b000 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=256K]
         Capabilities: [dc] Power Management version 2
         Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
         Capabilities: [ec] #06 [0080]

cat /proc/mtrr output

reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x40000000 (1024MB), size= 128MB: write-back, count=1
reg02: base=0x400000000 (16384MB), size=  64KB: uncachable, count=1
reg03: base=0x400020000 (16384MB), size=  64KB: uncachable, count=1
reg04: base=0x400040000 (16384MB), size=  64KB: uncachable, count=1
reg05: base=0x400060000 (16384MB), size=  64KB: uncachable, count=1
reg06: base=0x400080000 (16384MB), size=  64KB: uncachable, count=1
reg07: base=0x4000a0000 (16384MB), size=  64KB: uncachable, count=1


Roberto Fichera.

