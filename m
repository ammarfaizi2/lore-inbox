Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbTDFKnp (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTDFKnp (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:43:45 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:11784
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262911AbTDFKnG (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 06:43:06 -0400
Date: Sun, 6 Apr 2003 06:48:33 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Robert Love <rml@tech9.net>, Martin Bligh <mbligh@aracnet.com>
Subject: 2.5.65-preempt booting on 32way NUMAQ 
Message-ID: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert i suppose you can add another notch on your erm.. bedpost(?) 
and congratulations to all the kernel developers! It survived some 
local networking stress tests, but there is more fun stuff like tty 
layer to completely obliterate ;)

(Hardware courtesy of OSDL)
Running configuration
32 Processors, PIII 500
32G RAM

Patches required:
2.5.65 (only because isp1020 decided to get huffy)
Purge assign_irq_vector panic - Zwane Mwaikambo

Linux version 2.5.65-preempt (root@dev16-002) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Sun Apr 6 03:38:42 PDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000800000000 (usable)
Reserving 10752 pages of KVA for lmem_map of node 1
Shrinking node 1 from 2097152 pages to 2086400 pages
Reserving 10752 pages of KVA for lmem_map of node 2
Shrinking node 2 from 3145728 pages to 3134976 pages
Reserving 10752 pages of KVA for lmem_map of node 3
Shrinking node 3 from 4194304 pages to 4183552 pages
Reserving 10752 pages of KVA for lmem_map of node 4
Shrinking node 4 from 5242880 pages to 5232128 pages
Reserving 10752 pages of KVA for lmem_map of node 5
Shrinking node 5 from 6291456 pages to 6280704 pages
Reserving 10752 pages of KVA for lmem_map of node 6
Shrinking node 6 from 7340032 pages to 7329280 pages
Reserving 10752 pages of KVA for lmem_map of node 7
Shrinking node 7 from 8388608 pages to 8377856 pages
Reserving total of 75264 pages for numa KVA remap
31872MB HIGHMEM available.
602MB LOWMEM available.
min_low_pfn = 1101, max_low_pfn = 154112, highstart_pfn = 229376
Low memory ends at vaddr e5a00000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5600000 - f8000000
node 2 will remap to vaddr f2c00000 - f5600000
node 3 will remap to vaddr f0200000 - f2c00000
node 4 will remap to vaddr ed800000 - f0200000
node 5 will remap to vaddr eae00000 - ed800000
node 6 will remap to vaddr e8400000 - eae00000
node 7 will remap to vaddr e5a00000 - e8400000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 150016 pages, LIFO batch:16
  HighMem zone: 894464 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
On node 1 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 2 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 3 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 4 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 5 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 6 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
On node 7 totalpages: 1037824
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1037824 pages, LIFO batch:16
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at 00601320 - parsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 1, quad 4, global 1, local 3
Translation: record 17, type 1, quad 4, global 1, local 1
Translation: record 18, type 1, quad 4, global 1, local 1
Translation: record 19, type 1, quad 4, global 1, local 1
Translation: record 20, type 1, quad 5, global 1, local 3
Translation: record 21, type 1, quad 5, global 1, local 1
Translation: record 22, type 1, quad 5, global 1, local 1
Translation: record 23, type 1, quad 5, global 1, local 1
Translation: record 24, type 1, quad 6, global 1, local 3
Translation: record 25, type 1, quad 6, global 1, local 1
Translation: record 26, type 1, quad 6, global 1, local 1
Translation: record 27, type 1, quad 6, global 1, local 1
Translation: record 28, type 1, quad 7, global 1, local 3
Translation: record 29, type 1, quad 7, global 1, local 1
Translation: record 30, type 1, quad 7, global 1, local 1
Translation: record 31, type 1, quad 7, global 1, local 1
Translation: record 32, type 3, quad 0, global 0, local 0
Translation: record 33, type 3, quad 0, global 1, local 1
Translation: record 34, type 3, quad 0, global 2, local 2
Translation: record 35, type 4, quad 0, global 17, local 18
Translation: record 36, type 3, quad 1, global 3, local 0
Translation: record 37, type 3, quad 1, global 4, local 1
Translation: record 38, type 4, quad 1, global 18, local 18
Translation: record 39, type 3, quad 2, global 5, local 0
Translation: record 40, type 3, quad 2, global 6, local 1
Translation: record 41, type 4, quad 2, global 19, local 18
Translation: record 42, type 3, quad 3, global 7, local 0
Translation: record 43, type 3, quad 3, global 8, local 1
Translation: record 44, type 4, quad 3, global 20, local 18
Translation: record 45, type 3, quad 4, global 9, local 0
Translation: record 46, type 3, quad 4, global 10, local 1
Translation: record 47, type 4, quad 4, global 21, local 18
Translation: record 48, type 3, quad 5, global 11, local 0
Translation: record 49, type 3, quad 5, global 12, local 1
Translation: record 50, type 4, quad 5, global 22, local 18
Translation: record 51, type 3, quad 6, global 13, local 0
Translation: record 52, type 3, quad 6, global 14, local 1
Translation: record 53, type 4, quad 6, global 23, local 18
Translation: record 54, type 3, quad 7, global 15, local 0
Translation: record 55, type 3, quad 7, global 16, local 1
Translation: record 56, type 4, quad 7, global 24, local 18
Translation: record 57, type 2, quad 0, global 13, local 14
Translation: record 58, type 2, quad 0, global 14, local 13
Translation: record 59, type 2, quad 1, global 15, local 14
Translation: record 60, type 2, quad 1, global 16, local 13
Translation: record 61, type 2, quad 2, global 17, local 14
Translation: record 62, type 2, quad 2, global 18, local 13
Translation: record 63, type 2, quad 3, global 19, local 14
Translation: record 64, type 2, quad 3, global 20, local 13
Translation: record 65, type 2, quad 4, global 21, local 14
Translation: record 66, type 2, quad 4, global 22, local 13
Translation: record 67, type 2, quad 5, global 23, local 14
Translation: record 68, type 2, quad 5, global 24, local 13
Translation: record 69, type 2, quad 6, global 25, local 14
Translation: record 70, type 2, quad 6, global 26, local 13
Translation: record 71, type 2, quad 7, global 27, local 14
Translation: record 72, type 2, quad 7, global 28, local 13
APIC at: 0xFEC08000
Processor #0 6:7 APIC version 17 (quad 0, apic 1)
Processor #4 6:7 APIC version 17 (quad 0, apic 8)
Processor #1 6:7 APIC version 17 (quad 0, apic 2)
Processor #2 6:7 APIC version 17 (quad 0, apic 4)
Processor #0 6:7 APIC version 17 (quad 1, apic 17)
Processor #4 6:7 APIC version 17 (quad 1, apic 24)
Processor #1 6:7 APIC version 17 (quad 1, apic 18)
Processor #2 6:7 APIC version 17 (quad 1, apic 20)
Processor #0 6:7 APIC version 17 (quad 2, apic 33)
Processor #4 6:7 APIC version 17 (quad 2, apic 40)
Processor #1 6:7 APIC version 17 (quad 2, apic 34)
Processor #2 6:7 APIC version 17 (quad 2, apic 36)
Processor #0 6:7 APIC version 17 (quad 3, apic 49)
Processor #4 6:7 APIC version 17 (quad 3, apic 56)
Processor #1 6:7 APIC version 17 (quad 3, apic 50)
Processor #2 6:7 APIC version 17 (quad 3, apic 52)
Processor #0 6:7 APIC version 17 (quad 4, apic 65)
Processor #4 6:7 APIC version 17 (quad 4, apic 72)
Processor #1 6:7 APIC version 17 (quad 4, apic 66)
Processor #2 6:7 APIC version 17 (quad 4, apic 68)
Processor #0 6:7 APIC version 17 (quad 5, apic 81)
Processor #4 6:7 APIC version 17 (quad 5, apic 88)
Processor #1 6:7 APIC version 17 (quad 5, apic 82)
Processor #2 6:7 APIC version 17 (quad 5, apic 84)
Processor #0 6:7 APIC version 17 (quad 6, apic 97)
Processor #4 6:7 APIC version 17 (quad 6, apic 104)
Processor #1 6:7 APIC version 17 (quad 6, apic 98)
Processor #2 6:7 APIC version 17 (quad 6, apic 100)
Processor #0 6:7 APIC version 17 (quad 7, apic 113)
Processor #4 6:7 APIC version 17 (quad 7, apic 120)
Processor #1 6:7 APIC version 17 (quad 7, apic 114)
Processor #2 6:7 APIC version 17 (quad 7, apic 116)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #17 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #18 is EISA   (node 1)
Bus #5 is PCI    (node 2)
Bus #6 is PCI    (node 2)
Bus #19 is EISA   (node 2)
Bus #7 is PCI    (node 3)
Bus #8 is PCI    (node 3)
Bus #20 is EISA   (node 3)
Bus #9 is PCI    (node 4)
Bus #10 is PCI    (node 4)
Bus #21 is EISA   (node 4)
Bus #11 is PCI    (node 5)
Bus #12 is PCI    (node 5)
Bus #22 is EISA   (node 5)
Bus #13 is PCI    (node 6)
Bus #14 is PCI    (node 6)
Bus #23 is EISA   (node 6)
Bus #15 is PCI    (node 7)
Bus #16 is PCI    (node 7)
Bus #24 is EISA   (node 7)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
I/O APIC #21 Version 17 at 0xFE900000.
I/O APIC #22 Version 17 at 0xFE901000.
I/O APIC #23 Version 17 at 0xFE940000.
I/O APIC #24 Version 17 at 0xFE941000.
I/O APIC #25 Version 17 at 0xFE980000.
I/O APIC #26 Version 17 at 0xFE981000.
I/O APIC #27 Version 17 at 0xFE9C0000.
I/O APIC #28 Version 17 at 0xFE9C1000.
Enabling APIC mode:  NUMA-Q.  Using 16 I/O APICs
Processors: 32
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Building zonelist for node : 4
Building zonelist for node : 5
Building zonelist for node : 6
Building zonelist for node : 7
Kernel command line: BOOT_IMAGE=linux-test ro root=802 BOOT_FILE=/boot/vmlinuz-test console=tty1 console=ttyS0,38400n8 profile=2 noirqbalance
kernel profiling enabled
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 495.230 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 974.84 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Initializing highpages for node 4
Initializing highpages for node 5
Initializing highpages for node 6
Initializing highpages for node 7
Memory: 32676220k/33554432k available (1792k kernel code, 49040k reserved, 735k data, 392k init, 32112640k highmem)
Dentry cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 1048576 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Katmai) stepping 03
per-CPU timeslice cutoff: 5846.60 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
Remapping cross-quad port I/O for 8 quads
xquad_portio vaddr 0xf8800000, len 00200000
Booting processor 1/2 eip 2000
Storing NMI vector
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Katmai) stepping 03
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel Pentium III (Katmai) stepping 03
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 987.13 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel Pentium III (Katmai) stepping 03
Booting processor 4/17 eip 2000
Storing NMI vector
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#4.
CPU4: Intel Pentium III (Katmai) stepping 03
Booting processor 5/18 eip 2000
Storing NMI vector
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 978.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#5.
CPU5: Intel Pentium III (Katmai) stepping 03
Booting processor 6/20 eip 2000
Storing NMI vector
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#6.
CPU6: Intel Pentium III (Katmai) stepping 03
Booting processor 7/24 eip 2000
Storing NMI vector
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#7.
CPU7: Intel Pentium III (Katmai) stepping 03
Booting processor 8/33 eip 2000
Storing NMI vector
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 2
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#8.
CPU8: Intel Pentium III (Katmai) stepping 03
Booting processor 9/34 eip 2000
Storing NMI vector
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 2
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#9.
CPU9: Intel Pentium III (Katmai) stepping 03
Booting processor 10/36 eip 2000
Storing NMI vector
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 2
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#10.
CPU10: Intel Pentium III (Katmai) stepping 03
Booting processor 11/40 eip 2000
Storing NMI vector
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 2
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#11.
CPU11: Intel Pentium III (Katmai) stepping 03
Booting processor 12/49 eip 2000
Storing NMI vector
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 3
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#12.
CPU12: Intel Pentium III (Katmai) stepping 03
Booting processor 13/50 eip 2000
Storing NMI vector
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 3
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#13.
CPU13: Intel Pentium III (Katmai) stepping 03
Booting processor 14/52 eip 2000
Storing NMI vector
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 3
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#14.
CPU14: Intel Pentium III (Katmai) stepping 03
Booting processor 15/56 eip 2000
Storing NMI vector
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 3
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#15.
CPU15: Intel Pentium III (Katmai) stepping 03
Booting processor 16/65 eip 2000
Storing NMI vector
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 4
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#16.
CPU16: Intel Pentium III (Katmai) stepping 03
Booting processor 17/66 eip 2000
Storing NMI vector
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 4
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#17.
CPU17: Intel Pentium III (Katmai) stepping 03
Booting processor 18/68 eip 2000
Storing NMI vector
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 4
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#18.
CPU18: Intel Pentium III (Katmai) stepping 03
Booting processor 19/72 eip 2000
Storing NMI vector
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 4
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#19.
CPU19: Intel Pentium III (Katmai) stepping 03
Booting processor 20/81 eip 2000
Storing NMI vector
Initializing CPU#20
masked ExtINT on CPU#20
Leaving ESR disabled.
Mapping cpu 20 to node 5
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#20.
CPU20: Intel Pentium III (Katmai) stepping 03
Booting processor 21/82 eip 2000
Storing NMI vector
Initializing CPU#21
masked ExtINT on CPU#21
Leaving ESR disabled.
Mapping cpu 21 to node 5
Calibrating delay loop... 978.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#21.
CPU21: Intel Pentium III (Katmai) stepping 03
Booting processor 22/84 eip 2000
Storing NMI vector
Initializing CPU#22
masked ExtINT on CPU#22
Leaving ESR disabled.
Mapping cpu 22 to node 5
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#22.
CPU22: Intel Pentium III (Katmai) stepping 03
Booting processor 23/88 eip 2000
Storing NMI vector
Initializing CPU#23
masked ExtINT on CPU#23
Leaving ESR disabled.
Mapping cpu 23 to node 5
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#23.
CPU23: Intel Pentium III (Katmai) stepping 03
Booting processor 24/97 eip 2000
Storing NMI vector
Initializing CPU#24
masked ExtINT on CPU#24
Leaving ESR disabled.
Mapping cpu 24 to node 6
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#24.
CPU24: Intel Pentium III (Katmai) stepping 03
Booting processor 25/98 eip 2000
Storing NMI vector
Initializing CPU#25
masked ExtINT on CPU#25
Leaving ESR disabled.
Mapping cpu 25 to node 6
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#25.
CPU25: Intel Pentium III (Katmai) stepping 03
Booting processor 26/100 eip 2000
Storing NMI vector
Initializing CPU#26
masked ExtINT on CPU#26
Leaving ESR disabled.
Mapping cpu 26 to node 6
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#26.
CPU26: Intel Pentium III (Katmai) stepping 03
Booting processor 27/104 eip 2000
Storing NMI vector
Initializing CPU#27
masked ExtINT on CPU#27
Leaving ESR disabled.
Mapping cpu 27 to node 6
Calibrating delay loop... 978.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#27.
CPU27: Intel Pentium III (Katmai) stepping 03
Booting processor 28/113 eip 2000
Storing NMI vector
Initializing CPU#28
masked ExtINT on CPU#28
Leaving ESR disabled.
Mapping cpu 28 to node 7
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#28.
CPU28: Intel Pentium III (Katmai) stepping 03
Booting processor 29/114 eip 2000
Storing NMI vector
Initializing CPU#29
masked ExtINT on CPU#29
Leaving ESR disabled.
Mapping cpu 29 to node 7
Calibrating delay loop... 978.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#29.
CPU29: Intel Pentium III (Katmai) stepping 03
Booting processor 30/116 eip 2000
Storing NMI vector
Initializing CPU#30
masked ExtINT on CPU#30
Leaving ESR disabled.
Mapping cpu 30 to node 7
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#30.
CPU30: Intel Pentium III (Katmai) stepping 03
Booting processor 31/120 eip 2000
Storing NMI vector
Initializing CPU#31
masked ExtINT on CPU#31
Leaving ESR disabled.
Mapping cpu 31 to node 7
Calibrating delay loop... 983.04 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#31.
CPU31: Intel Pentium III (Katmai) stepping 03
Total of 32 processors activated (31444.99 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23, 15-0, 16-0, 16-8, 16-18, 16-19, 16-20, 16-21, 16-22, 16-23, 17-0, 18-0, 18-8, 18-18, 18-19, 18-20, 18-21, 18-22, 18-23, 19-0, 20-0, 20-8, 20-18, 20-19, 20-20, 20-21, 20-22, 20-23, 21-0, 22-0, 22-8, 22-18, 22-19, 22-20, 22-21, 22-22, 22-23, 23-0, 24-0, 24-8, 24-18, 24-19, 24-20, 24-21, 24-22, 24-23, 25-0, 26-0, 26-8, 26-18, 26-19, 26-20, 26-21, 26-22, 26-23, 27-0, 28-0, 28-8, 28-18, 28-19, 28-20, 28-21, 28-22, 28-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 320.
number of IO-APIC #13 registers: 24.
number of IO-APIC #14 registers: 24.
number of IO-APIC #15 registers: 24.
number of IO-APIC #16 registers: 24.
number of IO-APIC #17 registers: 24.
number of IO-APIC #18 registers: 24.
number of IO-APIC #19 registers: 24.
number of IO-APIC #20 registers: 24.
number of IO-APIC #21 registers: 24.
number of IO-APIC #22 registers: 24.
number of IO-APIC #23 registers: 24.
number of IO-APIC #24 registers: 24.
number of IO-APIC #25 registers: 24.
number of IO-APIC #26 registers: 24.
number of IO-APIC #27 registers: 24.
number of IO-APIC #28 registers: 24.
testing the IO APIC.......................

IO APIC #13......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    61
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    81
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    91
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    A1
 10 00F 0F  1    1    0   1   0    0    1    A9
 11 00F 0F  1    1    0   1   0    0    1    B1
 12 00F 0F  1    1    0   1   0    0    1    B9
 13 00F 0F  1    1    0   1   0    0    1    C1
 14 00F 0F  1    1    0   1   0    0    1    C9
 15 00F 0F  1    1    0   1   0    0    1    D1
 16 00F 0F  1    1    0   1   0    0    1    D9
 17 00F 0F  1    1    0   1   0    0    1    E1

IO APIC #14......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    E9
 02 00F 0F  1    1    0   1   0    0    1    32
 03 00F 0F  1    1    0   1   0    0    1    3A
 04 00F 0F  1    1    0   1   0    0    1    42
 05 00F 0F  1    1    0   1   0    0    1    4A
 06 00F 0F  1    1    0   1   0    0    1    52
 07 00F 0F  1    1    0   1   0    0    1    5A
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    62
 0a 00F 0F  1    1    0   1   0    0    1    6A
 0b 00F 0F  1    1    0   1   0    0    1    72
 0c 00F 0F  1    1    0   1   0    0    1    7A
 0d 00F 0F  1    1    0   1   0    0    1    82
 0e 00F 0F  1    1    0   1   0    0    1    8A
 0f 00F 0F  1    1    0   1   0    0    1    92
 10 00F 0F  1    1    0   1   0    0    1    9A
 11 00F 0F  1    1    0   1   0    0    1    A2
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #15......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    AA
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    B2
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    BA
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    C2
 10 00F 0F  1    1    0   1   0    0    1    CA
 11 00F 0F  1    1    0   1   0    0    1    D2
 12 00F 0F  1    1    0   1   0    0    1    DA
 13 00F 0F  1    1    0   1   0    0    1    E2
 14 00F 0F  1    1    0   1   0    0    1    EA
 15 00F 0F  1    1    0   1   0    0    1    33
 16 00F 0F  1    1    0   1   0    0    1    3B
 17 00F 0F  1    1    0   1   0    0    1    43

IO APIC #16......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    4B
 02 00F 0F  1    1    0   1   0    0    1    53
 03 00F 0F  1    1    0   1   0    0    1    5B
 04 00F 0F  1    1    0   1   0    0    1    63
 05 00F 0F  1    1    0   1   0    0    1    6B
 06 00F 0F  1    1    0   1   0    0    1    73
 07 00F 0F  1    1    0   1   0    0    1    7B
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    83
 0a 00F 0F  1    1    0   1   0    0    1    8B
 0b 00F 0F  1    1    0   1   0    0    1    93
 0c 00F 0F  1    1    0   1   0    0    1    9B
 0d 00F 0F  1    1    0   1   0    0    1    A3
 0e 00F 0F  1    1    0   1   0    0    1    AB
 0f 00F 0F  1    1    0   1   0    0    1    B3
 10 00F 0F  1    1    0   1   0    0    1    BB
 11 00F 0F  1    1    0   1   0    0    1    C3
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #17......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    CB
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    D3
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    DB
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    E3
 10 00F 0F  1    1    0   1   0    0    1    EB
 11 00F 0F  1    1    0   1   0    0    1    34
 12 00F 0F  1    1    0   1   0    0    1    3C
 13 00F 0F  1    1    0   1   0    0    1    44
 14 00F 0F  1    1    0   1   0    0    1    4C
 15 00F 0F  1    1    0   1   0    0    1    54
 16 00F 0F  1    1    0   1   0    0    1    5C
 17 00F 0F  1    1    0   1   0    0    1    64

IO APIC #18......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    6C
 02 00F 0F  1    1    0   1   0    0    1    74
 03 00F 0F  1    1    0   1   0    0    1    7C
 04 00F 0F  1    1    0   1   0    0    1    84
 05 00F 0F  1    1    0   1   0    0    1    8C
 06 00F 0F  1    1    0   1   0    0    1    94
 07 00F 0F  1    1    0   1   0    0    1    9C
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    A4
 0a 00F 0F  1    1    0   1   0    0    1    AC
 0b 00F 0F  1    1    0   1   0    0    1    B4
 0c 00F 0F  1    1    0   1   0    0    1    BC
 0d 00F 0F  1    1    0   1   0    0    1    C4
 0e 00F 0F  1    1    0   1   0    0    1    CC
 0f 00F 0F  1    1    0   1   0    0    1    D4
 10 00F 0F  1    1    0   1   0    0    1    DC
 11 00F 0F  1    1    0   1   0    0    1    E4
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #19......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    EC
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    35
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    3D
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    45
 10 00F 0F  1    1    0   1   0    0    1    4D
 11 00F 0F  1    1    0   1   0    0    1    55
 12 00F 0F  1    1    0   1   0    0    1    5D
 13 00F 0F  1    1    0   1   0    0    1    65
 14 00F 0F  1    1    0   1   0    0    1    6D
 15 00F 0F  1    1    0   1   0    0    1    75
 16 00F 0F  1    1    0   1   0    0    1    7D
 17 00F 0F  1    1    0   1   0    0    1    85

IO APIC #20......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    8D
 02 00F 0F  1    1    0   1   0    0    1    95
 03 00F 0F  1    1    0   1   0    0    1    9D
 04 00F 0F  1    1    0   1   0    0    1    A5
 05 00F 0F  1    1    0   1   0    0    1    AD
 06 00F 0F  1    1    0   1   0    0    1    B5
 07 00F 0F  1    1    0   1   0    0    1    BD
 08 000 00  1    0    0   0   0    0    0    00
 09 00F 0F  1    1    0   1   0    0    1    C5
 0a 00F 0F  1    1    0   1   0    0    1    CD
 0b 00F 0F  1    1    0   1   0    0    1    D5
 0c 00F 0F  1    1    0   1   0    0    1    DD
 0d 00F 0F  1    1    0   1   0    0    1    E5
 0e 00F 0F  1    1    0   1   0    0    1    ED
 0f 00F 0F  1    1    0   1   0    0    1    36
 10 00F 0F  1    1    0   1   0    0    1    3E
 11 00F 0F  1    1    0   1   0    0    1    46
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #21......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 00F 0F  1    1    0   1   0    0    1    4E
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 00F 0F  1    1    0   1   0    0    1    56
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 00F 0F  1    1    0   1   0    0    1    5E
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 00F 0F  1    1    0   1   0    0    1    66
 10 00F 0F  1    1    0   1   0    0    1    6E
 11 00F 0F  1    1    0   1   0    0    1    76
 12 00F 0F  1    1    0   1   0    0    1    7E
 13 00F 0F  1    1    0   1   0    0    1    86
 14 00F 0F  1    1    0   1   0    0    1    8E
 15 00F 0F  1    1    0   1   0    0    1    96
 16 00F 0F  1    1    0   1   0    0    1    9E
 17 00F 0F  1    1    0   1   0    0    1    A6

IO APIC #22......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  1    1    0   1   0    0    1    AE
 02 00F 0F  1    1    0   1   0    0    1    B6
 03 00F 0F  1    1    0   1   0    0    1    BE
 04 00F 0F  1    1    0   1   0    0    1    C6
 05 00F 0F  1    1    0   1   0    0    1    CE
 06 00F 0F  1    1    0   1   0    0    1    D6
 07 00F 0F  1    1    0   1   0    0    1    DE
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #23......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #24......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #25......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #26......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #27......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    0    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 00F 0F  0    0    0   0   0    0    1    41
 04 00F 0F  0    0    0   0   0    0    1    49
 05 00F 0F  0    0    0   0   0    0    1    51
 06 00F 0F  0    0    0   0   0    0    1    59
 07 000 00  1    0    0   0   0    0    0    00
 08 00F 0F  1    1    0   0   0    0    1    69
 09 00F 0F  0    0    0   0   0    0    1    71
 0a 00F 0F  0    0    0   0   0    0    1    79
 0b 000 00  1    0    0   0   0    0    0    00
 0c 00F 0F  0    0    0   0   0    0    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 00F 0F  0    0    0   0   0    0    1    99
 0f 000 00  1    0    0   0   0    0    0    00
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #28......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
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
IRQ1 -> 0:1-> 2:1-> 4:1-> 6:1-> 8:1-> 10:1-> 12:1-> 14:1
IRQ3 -> 0:3-> 2:3-> 4:3-> 6:3-> 8:3-> 10:3-> 12:3-> 14:3
IRQ4 -> 0:4-> 2:4-> 4:4-> 6:4-> 8:4-> 10:4-> 12:4-> 14:4
IRQ5 -> 0:5-> 2:5-> 4:5-> 6:5-> 8:5-> 10:5-> 12:5-> 14:5
IRQ6 -> 0:6-> 2:6-> 4:6-> 6:6-> 8:6-> 10:6-> 12:6-> 14:6
IRQ7 -> 0:7
IRQ8 -> 0:8-> 2:8-> 4:8-> 6:8-> 8:8-> 10:8-> 12:8-> 14:8
IRQ9 -> 0:9-> 2:9-> 4:9-> 6:9-> 8:9-> 10:9-> 12:9-> 14:9
IRQ10 -> 0:10-> 2:10-> 4:10-> 6:10-> 8:10-> 10:10-> 12:10-> 14:10
IRQ11 -> 0:11
IRQ12 -> 0:12-> 2:12-> 4:12-> 6:12-> 8:12-> 10:12-> 12:12-> 14:12
IRQ13 -> 0:13
IRQ14 -> 0:14-> 2:14-> 4:14-> 6:14-> 8:14-> 10:14-> 12:14-> 14:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 1:4
IRQ29 -> 1:5
IRQ30 -> 1:6
IRQ31 -> 1:7
IRQ33 -> 1:9
IRQ34 -> 1:10
IRQ35 -> 1:11
IRQ36 -> 1:12
IRQ37 -> 1:13
IRQ38 -> 1:14
IRQ39 -> 1:15
IRQ40 -> 1:16
IRQ41 -> 1:17
IRQ55 -> 2:7
IRQ59 -> 2:11
IRQ61 -> 2:13
IRQ63 -> 2:15
IRQ64 -> 2:16
IRQ65 -> 2:17
IRQ66 -> 2:18
IRQ67 -> 2:19
IRQ68 -> 2:20
IRQ69 -> 2:21
IRQ70 -> 2:22
IRQ71 -> 2:23
IRQ73 -> 3:1
IRQ74 -> 3:2
IRQ75 -> 3:3
IRQ76 -> 3:4
IRQ77 -> 3:5
IRQ78 -> 3:6
IRQ79 -> 3:7
IRQ81 -> 3:9
IRQ82 -> 3:10
IRQ83 -> 3:11
IRQ84 -> 3:12
IRQ85 -> 3:13
IRQ86 -> 3:14
IRQ87 -> 3:15
IRQ88 -> 3:16
IRQ89 -> 3:17
IRQ103 -> 4:7
IRQ107 -> 4:11
IRQ109 -> 4:13
IRQ111 -> 4:15
IRQ112 -> 4:16
IRQ113 -> 4:17
IRQ114 -> 4:18
IRQ115 -> 4:19
IRQ116 -> 4:20
IRQ117 -> 4:21
IRQ118 -> 4:22
IRQ119 -> 4:23
IRQ121 -> 5:1
IRQ122 -> 5:2
IRQ123 -> 5:3
IRQ124 -> 5:4
IRQ125 -> 5:5
IRQ126 -> 5:6
IRQ127 -> 5:7
IRQ129 -> 5:9
IRQ130 -> 5:10
IRQ131 -> 5:11
IRQ132 -> 5:12
IRQ133 -> 5:13
IRQ134 -> 5:14
IRQ135 -> 5:15
IRQ136 -> 5:16
IRQ137 -> 5:17
IRQ151 -> 6:7
IRQ155 -> 6:11
IRQ157 -> 6:13
IRQ159 -> 6:15
IRQ160 -> 6:16
IRQ161 -> 6:17
IRQ162 -> 6:18
IRQ163 -> 6:19
IRQ164 -> 6:20
IRQ165 -> 6:21
IRQ166 -> 6:22
IRQ167 -> 6:23
IRQ169 -> 7:1
IRQ170 -> 7:2
IRQ171 -> 7:3
IRQ172 -> 7:4
IRQ173 -> 7:5
IRQ174 -> 7:6
IRQ175 -> 7:7
IRQ177 -> 7:9
IRQ178 -> 7:10
IRQ179 -> 7:11
IRQ180 -> 7:12
IRQ181 -> 7:13
IRQ182 -> 7:14
IRQ183 -> 7:15
IRQ184 -> 7:16
IRQ185 -> 7:17
IRQ199 -> 8:7
IRQ203 -> 8:11
IRQ205 -> 8:13
IRQ207 -> 8:15
IRQ208 -> 8:16
IRQ209 -> 8:17
IRQ210 -> 8:18
IRQ211 -> 8:19
IRQ212 -> 8:20
IRQ213 -> 8:21
IRQ214 -> 8:22
IRQ215 -> 8:23
IRQ217 -> 9:1
IRQ218 -> 9:2
IRQ219 -> 9:3
IRQ220 -> 9:4
IRQ221 -> 9:5
IRQ222 -> 9:6
IRQ223 -> 9:7
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 494.0950 MHz.
..... host bus clock speed is 89.0990 MHz.
checking TSC synchronization across 32 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 34837 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 34837 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 34837 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 34837 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -22479 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -22480 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -22479 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -22479 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 27811 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 27811 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 27811 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 27811 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has -17110 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has -17110 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has -17111 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has -17110 usecs TSC skew! FIXED.
BIOS BUG: CPU#16 improperly initialized, has -30704 usecs TSC skew! FIXED.
BIOS BUG: CPU#17 improperly initialized, has -30705 usecs TSC skew! FIXED.
BIOS BUG: CPU#18 improperly initialized, has -30704 usecs TSC skew! FIXED.
BIOS BUG: CPU#19 improperly initialized, has -30704 usecs TSC skew! FIXED.
BIOS BUG: CPU#20 improperly initialized, has -3239 usecs TSC skew! FIXED.
BIOS BUG: CPU#21 improperly initialized, has -3239 usecs TSC skew! FIXED.
BIOS BUG: CPU#22 improperly initialized, has -3239 usecs TSC skew! FIXED.
BIOS BUG: CPU#23 improperly initialized, has -3239 usecs TSC skew! FIXED.
BIOS BUG: CPU#24 improperly initialized, has 13569 usecs TSC skew! FIXED.
BIOS BUG: CPU#25 improperly initialized, has 13569 usecs TSC skew! FIXED.
BIOS BUG: CPU#26 improperly initialized, has 13569 usecs TSC skew! FIXED.
BIOS BUG: CPU#27 improperly initialized, has 13569 usecs TSC skew! FIXED.
BIOS BUG: CPU#28 improperly initialized, has -2684 usecs TSC skew! FIXED.
BIOS BUG: CPU#29 improperly initialized, has -2683 usecs TSC skew! FIXED.
BIOS BUG: CPU#30 improperly initialized, has -2683 usecs TSC skew! FIXED.
BIOS BUG: CPU#31 improperly initialized, has -2683 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
Bringing up 8
CPU 8 IS NOW UP!
Starting migration thread for cpu 8
Bringing up 9
CPU 9 IS NOW UP!
Starting migration thread for cpu 9
Bringing up 10
CPU 10 IS NOW UP!
Starting migration thread for cpu 10
Bringing up 11
CPU 11 IS NOW UP!
Starting migration thread for cpu 11
Bringing up 12
CPU 12 IS NOW UP!
Starting migration thread for cpu 12
Bringing up 13
CPU 13 IS NOW UP!
Starting migration thread for cpu 13
Bringing up 14
CPU 14 IS NOW UP!
Starting migration thread for cpu 14
Bringing up 15
CPU 15 IS NOW UP!
Starting migration thread for cpu 15
Bringing up 16
CPU 16 IS NOW UP!
Starting migration thread for cpu 16
Bringing up 17
CPU 17 IS NOW UP!
Starting migration thread for cpu 17
Bringing up 18
CPU 18 IS NOW UP!
Starting migration thread for cpu 18
Bringing up 19
CPU 19 IS NOW UP!
Starting migration thread for cpu 19
Bringing up 20
CPU 20 IS NOW UP!
Starting migration thread for cpu 20
Bringing up 21
CPU 21 IS NOW UP!
Starting migration thread for cpu 21
Bringing up 22
CPU 22 IS NOW UP!
Starting migration thread for cpu 22
Bringing up 23
CPU 23 IS NOW UP!
Starting migration thread for cpu 23
Bringing up 24
CPU 24 IS NOW UP!
Starting migration thread for cpu 24
Bringing up 25
CPU 25 IS NOW UP!
Starting migration thread for cpu 25
Bringing up 26
CPU 26 IS NOW UP!
Starting migration thread for cpu 26
Bringing up 27
CPU 27 IS NOW UP!
Starting migration thread for cpu 27
Bringing up 28
CPU 28 IS NOW UP!
Starting migration thread for cpu 28
Bringing up 29
CPU 29 IS NOW UP!
Starting migration thread for cpu 29
Bringing up 30
CPU 30 IS NOW UP!
Starting migration thread for cpu 30
Bringing up 31
CPU 31 IS NOW UP!
Starting migration thread for cpu 31
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd231, last bus=2
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
SCSI subsystem initialized
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 00:10.0
Scanning PCI bus 3 for quad 1
PCI: Address space collision on region 7 of bridge 03:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 03:10.0
Scanning PCI bus 5 for quad 2
PCI: Address space collision on region 7 of bridge 05:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 05:10.0
Scanning PCI bus 7 for quad 3
PCI: Address space collision on region 7 of bridge 07:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 07:10.0
Scanning PCI bus 9 for quad 4
PCI: Address space collision on region 7 of bridge 09:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 09:10.0
Scanning PCI bus 11 for quad 5
PCI: Address space collision on region 7 of bridge 0b:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 0b:10.0
Scanning PCI bus 13 for quad 6
PCI: Address space collision on region 7 of bridge 0d:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 0d:10.0
Scanning PCI bus 15 for quad 7
PCI: Address space collision on region 7 of bridge 0f:0e.3 [c00:c3f]
PCI: Searching for i450NX host bridges on 0f:10.0
PCI: using PPB(B1,I12,P0) to get irq 40
PCI->APIC IRQ transform: (B2,I4,P0) -> 40
PCI: using PPB(B1,I12,P1) to get irq 39
PCI->APIC IRQ transform: (B2,I5,P1) -> 39
PCI: using PPB(B1,I12,P2) to get irq 38
PCI->APIC IRQ transform: (B2,I6,P2) -> 38
PCI: using PPB(B1,I12,P3) to get irq 37
PCI->APIC IRQ transform: (B2,I7,P3) -> 37
PCI->APIC IRQ transform: (B1,I13,P0) -> 36
PCI->APIC IRQ transform: (B1,I14,P0) -> 41
PCI->APIC IRQ transform: (B1,I15,P0) -> 28
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 15
PCI->APIC IRQ transform: (B4,I13,P0) -> 84
PCI->APIC IRQ transform: (B4,I14,P0) -> 89
PCI->APIC IRQ transform: (B4,I15,P0) -> 76
PCI->APIC IRQ transform: (B3,I12,P0) -> 63
PCI->APIC IRQ transform: (B6,I13,P0) -> 132
PCI->APIC IRQ transform: (B6,I15,P0) -> 124
PCI->APIC IRQ transform: (B5,I11,P0) -> 115
PCI->APIC IRQ transform: (B8,I13,P0) -> 180
PCI->APIC IRQ transform: (B8,I15,P0) -> 172
PCI->APIC IRQ transform: (B7,I11,P0) -> 163
PCI->APIC IRQ transform: (B10,I12,P0) -> 232
PCI->APIC IRQ transform: (B10,I13,P0) -> 228
PCI->APIC IRQ transform: (B10,I14,P0) -> 233
PCI->APIC IRQ transform: (B10,I15,P0) -> 220
PCI->APIC IRQ transform: (B9,I10,P0) -> 215
PCI->APIC IRQ transform: (B9,I11,P0) -> 211
PCI->APIC IRQ transform: (B9,I12,P0) -> 207
PCI->APIC IRQ transform: (B12,I12,P0) -> 280
PCI->APIC IRQ transform: (B12,I13,P0) -> 276
PCI->APIC IRQ transform: (B12,I15,P0) -> 268
PCI->APIC IRQ transform: (B11,I10,P0) -> 263
PCI->APIC IRQ transform: (B14,I12,P0) -> 328
PCI->APIC IRQ transform: (B14,I13,P0) -> 324
PCI->APIC IRQ transform: (B14,I14,P0) -> 329
PCI->APIC IRQ transform: (B14,I15,P0) -> 316
PCI->APIC IRQ transform: (B13,I10,P0) -> 311
PCI->APIC IRQ transform: (B16,I12,P0) -> 376
PCI->APIC IRQ transform: (B16,I13,P0) -> 372
PCI->APIC IRQ transform: (B16,I15,P0) -> 364
PCI->APIC IRQ transform: (B15,I10,P0) -> 359
PCI: Cannot allocate resource region 1 of device 04:0d.0
PCI: Cannot allocate resource region 0 of device 04:0e.0
PCI: Cannot allocate resource region 4 of device 04:0f.0
PCI: Cannot allocate resource region 4 of device 03:0e.1
PCI: Cannot allocate resource region 1 of device 06:0d.0
PCI: Cannot allocate resource region 4 of device 06:0f.0
PCI: Cannot allocate resource region 1 of device 05:0b.0
PCI: Cannot allocate resource region 4 of device 05:0e.1
PCI: Cannot allocate resource region 1 of device 08:0d.0
PCI: Cannot allocate resource region 4 of device 08:0f.0
PCI: Cannot allocate resource region 1 of device 07:0b.0
PCI: Cannot allocate resource region 4 of device 07:0e.1
PCI: Cannot allocate resource region 1 of device 0a:0c.0
PCI: Cannot allocate resource region 1 of device 0a:0d.0
PCI: Cannot allocate resource region 0 of device 0a:0e.0
PCI: Cannot allocate resource region 4 of device 09:0a.0
PCI: Cannot allocate resource region 1 of device 09:0b.0
PCI: Cannot allocate resource region 1 of device 0c:0c.0
PCI: Cannot allocate resource region 1 of device 0c:0d.0
PCI: Cannot allocate resource region 4 of device 0c:0f.0
PCI: Cannot allocate resource region 4 of device 0b:0a.0
PCI: Cannot allocate resource region 4 of device 0b:0e.1
PCI: Cannot allocate resource region 1 of device 0e:0c.0
PCI: Cannot allocate resource region 1 of device 0e:0d.0
PCI: Cannot allocate resource region 0 of device 0e:0e.0
PCI: Cannot allocate resource region 4 of device 0e:0f.0
PCI: Cannot allocate resource region 4 of device 0d:0a.0
PCI: Cannot allocate resource region 4 of device 0d:0e.1
PCI: Cannot allocate resource region 1 of device 10:0c.0
PCI: Cannot allocate resource region 1 of device 10:0d.0
PCI: Cannot allocate resource region 4 of device 10:0f.0
PCI: Cannot allocate resource region 4 of device 0f:0a.0
PCI: Cannot allocate resource region 4 of device 0f:0e.1
PCI: Cannot allocate resource region 4 of device 09:0e.1
PCI: BIOS reporting unknown device 01:68
PCI: Device 04:68 not found by BIOS
PCI: BIOS reporting unknown device 01:70
PCI: Device 04:70 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 04:78 not found by BIOS
PCI: BIOS reporting unknown device 00:58
PCI: Device 03:58 not found by BIOS
PCI: BIOS reporting unknown device 00:60
PCI: Device 03:60 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 03:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 03:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 03:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 03:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 03:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 03:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 03:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 06:68 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 06:78 not found by BIOS
PCI: BIOS reporting unknown device 00:58
PCI: Device 05:58 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 05:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 05:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 05:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 05:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 05:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 05:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 05:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 08:68 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 08:78 not found by BIOS
PCI: BIOS reporting unknown device 00:58
PCI: Device 07:58 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 07:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 07:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 07:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 07:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 07:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 07:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 07:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0a:60 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0a:68 not found by BIOS
PCI: BIOS reporting unknown device 01:70
PCI: Device 0a:70 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0a:78 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 09:50 not found by BIOS
PCI: BIOS reporting unknown device 00:58
PCI: Device 09:58 not found by BIOS
PCI: BIOS reporting unknown device 00:60
PCI: Device 09:60 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 09:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 09:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 09:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 09:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 09:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 09:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 09:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0c:60 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0c:68 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0c:78 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0b:50 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 0b:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 0b:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 0b:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 0b:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 0b:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0b:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0b:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0e:60 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 0e:68 not found by BIOS
PCI: Device 0e:70 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0e:78 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0d:50 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 0d:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 0d:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 0d:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 0d:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 0d:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0d:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0d:a0 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 10:60 not found by BIOS
PCI: BIOS reporting unknown device 01:68
PCI: Device 10:68 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 10:78 not found by BIOS
PCI: BIOS reporting unknown device 01:78
PCI: Device 0f:50 not found by BIOS
PCI: BIOS reporting unknown device 00:70
PCI: Device 0f:70 not found by BIOS
PCI: BIOS reporting unknown device 00:71
PCI: Device 0f:71 not found by BIOS
PCI: BIOS reporting unknown device 00:72
PCI: Device 0f:72 not found by BIOS
PCI: BIOS reporting unknown device 00:73
PCI: Device 0f:73 not found by BIOS
PCI: BIOS reporting unknown device 00:80
PCI: Device 0f:80 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0f:90 not found by BIOS
PCI: BIOS reporting unknown device 00:90
PCI: Device 0f:a0 not found by BIOS
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 1
Enabling SEP on CPU 2
Enabling SEP on CPU 3
Enabling SEP on CPU 21
Enabling SEP on CPU 25
Enabling SEP on CPU 17
Enabling SEP on CPU 10
Enabling SEP on CPU 5
Enabling SEP on CPU 29
Enabling SEP on CPU 30
Enabling SEP on CPU 26
Enabling SEP on CPU 12
Enabling SEP on CPU 31
Enabling SEP on CPU 28
Enabling SEP on CPU 9
Enabling SEP on CPU 8
Enabling SEP on CPU 11
Enabling SEP on CPU 16
Enabling SEP on CPU 15
Enabling SEP on CPU 6
Enabling SEP on CPU 19
Enabling SEP on CPU 4
Enabling SEP on CPU 24
Enabling SEP on CPU 20
Enabling SEP on CPU 27
Enabling SEP on CPU 18
Enabling SEP on CPU 23
Enabling SEP on CPU 14
Enabling SEP on CPU 7
Enabling SEP on CPU 13
Enabling SEP on CPU 22
Enabling SEP on CPU 0
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557/8/9 [Ethernet , 00:02:B3:20:EA:58, IRQ 19.
  Board assembly 721383-016, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100: cannot reserve I/O ports
eth1: Invalid EEPROM checksum 0xff00, check settings before activating this device!
eth1: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 115.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth2: Invalid EEPROM checksum 0xff00, check settings before activating this device!
eth2: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 163.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth3: Invalid EEPROM checksum 0xff00, check settings before activating this device!
eth3: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 211.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MII
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.4.1, February 10, 2002)
eth4: Adaptec Starfire 6915 at 0xf8a16000, 00:00:d1:ed:2b:9d, IRQ 40.
eth4: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth4: scatter-gather and hardware TCP cksumming disabled.
eth5: Adaptec Starfire 6915 at 0xf8a97000, 00:00:d1:ed:2b:9e, IRQ 39.
eth5: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth5: scatter-gather and hardware TCP cksumming disabled.
eth6: Adaptec Starfire 6915 at 0xf8b18000, 00:00:d1:ed:2b:9f, IRQ 38.
eth6: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth6: scatter-gather and hardware TCP cksumming disabled.
eth7: Adaptec Starfire 6915 at 0xf8b99000, 00:00:d1:ed:2b:a0, IRQ 37.
eth7: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth7: scatter-gather and hardware TCP cksumming disabled.
scsi HBA driver qlogicfas didn't set a release method, please fix the template
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0224188>] scsi_register+0x88/0x3a0
 [<c022d6d2>] isp1020_detect+0x62/0x2a0
 [<c022d132>] __qlogicfas_detect+0x122/0x580
 [<c0223d10>] scsi_remove_legacy_host+0x0/0x20
 [<c02244d9>] scsi_register_host+0x39/0x80
 [<c01050f2>] init+0x62/0x200
 [<c0105090>] init+0x0/0x200
 [<c0108ba5>] kernel_thread_helper+0x5/0x10

qlogicisp : new isp1020 revision ID (5)
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0224188>] scsi_register+0x88/0x3a0
 [<c022d6d2>] isp1020_detect+0x62/0x2a0
 [<c022d132>] __qlogicfas_detect+0x122/0x580
 [<c0223d10>] scsi_remove_legacy_host+0x0/0x20
 [<c02244d9>] scsi_register_host+0x39/0x80
 [<c01050f2>] init+0x62/0x200
 [<c0105090>] init+0x0/0x200
 [<c0108ba5>] kernel_thread_helper+0x5/0x10

qlogicisp : new isp1020 revision ID (5)
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0224188>] scsi_register+0x88/0x3a0
 [<c022d6d2>] isp1020_detect+0x62/0x2a0
 [<c022d132>] __qlogicfas_detect+0x122/0x580
 [<c0223d10>] scsi_remove_legacy_host+0x0/0x20
 [<c02244d9>] scsi_register_host+0x39/0x80
 [<c01050f2>] init+0x62/0x200
 [<c0105090>] init+0x0/0x200
 [<c0108ba5>] kernel_thread_helper+0x5/0x10

qlogicisp : new isp1020 revision ID (5)
qlogicisp : interrupt 233 already in use
scsi0 : QLogic ISP1020 SCSI on PCI bus 01 device 70 irq 41 MEM base 0xf8c1a000
  Vendor: IBM       Model: DRHS36V           Rev: 0270
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DRHS36V           Rev: 0270
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: PLEXTOR   Model: CD-ROM PX-32CS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : QLogic ISP1020 SCSI on PCI bus 04 device 70 irq 89 MEM base 0xf8c1c000
SCSI device sda: 72170879 512-byte hdwr sectors (36951 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 72170879 512-byte hdwr sectors (36951 MB)
SCSI device sdb: drive cache: write through
 sdb: unknown partition table
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at Virtual EISA Bridge
EISA: Detected 0 card.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 131072 buckets, 2048Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 392k freed
Adding 2096472k swap on /dev/sda3.  Priority:-1 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,2), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
