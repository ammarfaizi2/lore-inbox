Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbTC1DuF>; Thu, 27 Mar 2003 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTC1DuF>; Thu, 27 Mar 2003 22:50:05 -0500
Received: from holomorphy.com ([66.224.33.161]:54189 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262186AbTC1Dtk> convert rfc822-to-8bit;
	Thu, 27 Mar 2003 22:49:40 -0500
Date: Thu, 27 Mar 2003 20:00:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 64GB NUMA-Q before pgcl
Message-ID: <20030328040036.GA13178@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Script started on Thu Mar 27 19:29:41 2003
$ sscreen -x
[?1049h[r[H[?7h[?1;4;6l[4l[?1h=(B[1;24r[H[H
Broadcast message from root (ttyS0) (Thu Mar 27 19:13:14 2003):

The system is going down for system halt NOW!
INIT: Sending processes the TERM signal
INIT: Stopping internet superserver: inetd.
Stopping network benchmark server: netserver.
Stopping OpenBSD Secure Shell server: sshd.
Stopping NTP server: ntpd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Thu Mar 27 19:13:23 PST 2003.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces... done.
Deactivating swap... done.
Unmounting local filesystems... done.
Synchronizing SCSI caches:
Shutting down devices
Power down.
Bell in window 4                    Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
Press any key to continue.
[H[H
    GRUB  version 0.92  (639K lower / 3144704K upper memory)

 +-------------------------------------------------------------------------+ 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
|| 
+-------------------------------------------------------------------------+
      Use the ^ and v keys to select which entry is highlighted.
      Press enter to boot the selected OS, 'e' to edit the
      commands before booting, or 'c' for a command-line.[5;78H  | Boot Debian Install (single quad) (hd0,0)                               | 
Boot Debian Install (multiquad <= 8, 1gig) (hd0,0)                      | 
maneesh's test kernel                                                   | 
install grub on sda                                                     | 
                                                                        | 
                                                                        | 
                                                                        | 
                                                                        | 
                                                                        | 
                                                                        | 
                                                                        | 
                                                                        |  [5;3H Boot Debian Install (single quad) (hd0,0)                               [H[H
    GRUB  version 0.92  (639K lower / 3144704K upper memory)

 [ Minimal BASH-like line editing is supported.  For the first word, TAB
   lists possible command completions.  Anywhere else TAB lists the possible
   completions of a device/filename.  ESC at any time exits. ]

grub>                                                                          root (hd0,1)
 Filesystem type is ext2fs, partition type 0x83

grub>                                                                          kernel /home/wli/vmlinuz-akpm root=/dev/sda2 console=ttyS0,38400n8 debu<00n8 debug                                                                    grub> kernel /home/wli/vmlinuz-akpm root=/dev/sda2 console=ttyS0,38400n8 debug 
   [Linux-bzImage, setup=0xa00, size=0x128a01]

grub>                                                                          boot
Linux version 2.5.65-mm2 (wli@megeira) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Thu Mar 20 17:10:09 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000fff800000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000c0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000fff800000 (usable)
Reserving 23040 pages of KVA for lmem_map of node 1
Shrinking node 1 from 4194304 pages to 4171264 pages
Reserving 23040 pages of KVA for lmem_map of node 2
Shrinking node 2 from 6291456 pages to 6268416 pages
Reserving 23040 pages of KVA for lmem_map of node 3
Shrinking node 3 from 8388608 pages to 8365568 pages
Reserving 23040 pages of KVA for lmem_map of node 4
Shrinking node 4 from 10485760 pages to 10462720 pages
Reserving 23040 pages of KVA for lmem_map of node 5
Shrinking node 5 from 12582912 pages to 12559872 pages
Reserving 23040 pages of KVA for lmem_map of node 6
Shrinking node 6 from 14680064 pages to 14657024 pages
Reserving 22528 pages of KVA for lmem_map of node 7
Shrinking node 7 from 16775168 pages to 16752640 pages
Reserving total of 160768 pages for numa KVA remap
64632MB HIGHMEM available.
268MB LOWMEM available.
min_low_pfn = 1057, max_low_pfn = 68608, highstart_pfn = 229376
Low memory ends at vaddr d0c00000
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f2600000 - f8000000
node 2 will remap to vaddr ecc00000 - f2600000
node 3 will remap to vaddr e7200000 - ecc00000
node 4 will remap to vaddr e1800000 - e7200000
node 5 will remap to vaddr dbe00000 - e1800000
node 6 will remap to vaddr d6400000 - dbe00000
node 7 will remap to vaddr d0c00000 - d6400000
High memory starts at vaddr f8000000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 2097152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 64512 pages, LIFO batch:15
  HighMem zone: 2028544 pages, LIFO batch:16
On node 1 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 2 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 3 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 4 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 5 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 6 totalpages: 2074112
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2074112 pages, LIFO batch:16
On node 7 totalpages: 2072576
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2072576 pages, LIFO batch:16
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          <6>Found an OEM MPC table at   7012ec - parsing it ... 
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
Translation: record 35, type 4, quad 0, global 20, local 18
Translation: record 36, type 3, quad 1, global 3, local 0
Translation: record 37, type 3, quad 1, global 4, local 1
Translation: record 38, type 4, quad 1, global 21, local 18
Translation: record 39, type 3, quad 2, global 5, local 0
Translation: record 40, type 3, quad 2, global 6, local 1
Translation: record 41, type 3, quad 2, global 7, local 2
Translation: record 42, type 4, quad 2, global 22, local 18
Translation: record 43, type 3, quad 3, global 8, local 0
Translation: record 44, type 3, quad 3, global 9, local 1
Translation: record 45, type 3, quad 3, global 10, local 2
Translation: record 46, type 4, quad 3, global 23, local 18
Translation: record 47, type 3, quad 4, global 11, local 0
Translation: record 48, type 3, quad 4, global 12, local 1
Translation: record 49, type 3, quad 4, global 13, local 2
Translation: record 50, type 4, quad 4, global 24, local 18
Translation: record 51, type 3, quad 5, global 14, local 0
Translation: record 52, type 3, quad 5, global 15, local 1
Translation: record 53, type 4, quad 5, global 25, local 18
Translation: record 54, type 3, quad 6, global 16, local 0
Translation: record 55, type 3, quad 6, global 17, local 1
Translation: record 56, type 4, quad 6, global 26, local 18
Translation: record 57, type 3, quad 7, global 18, local 0
Translation: record 58, type 3, quad 7, global 19, local 1
Translation: record 59, type 4, quad 7, global 27, local 18
Translation: record 60, type 2, quad 0, global 13, local 14
Translation: record 61, type 2, quad 0, global 14, local 13
Translation: record 62, type 2, quad 1, global 15, local 14
Translation: record 63, type 2, quad 1, global 16, local 13
Translation: record 64, type 2, quad 2, global 17, local 14
Translation: record 65, type 2, quad 2, global 18, local 13
Translation: record 66, type 2, quad 3, global 19, local 14
Translation: record 67, type 2, quad 3, global 20, local 13
Translation: record 68, type 2, quad 4, global 21, local 14
Translation: record 69, type 2, quad 4, global 22, local 13
Translation: record 70, type 2, quad 5, global 23, local 14
Translation: record 71, type 2, quad 5, global 24, local 13
Translation: record 72, type 2, quad 6, global 25, local 14
Translation: record 73, type 2, quad 6, global 26, local 13
Translation: record 74, type 2, quad 7, global 27, local 14
Translation: record 75, type 2, quad 7, global 28, local 13
APIC at: 0xFEC08000
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Processor #0 6:10 APIC version 17 (quad 1, apic 17)
Processor #4 6:10 APIC version 17 (quad 1, apic 24)
Processor #1 6:10 APIC version 17 (quad 1, apic 18)
Processor #2 6:10 APIC version 17 (quad 1, apic 20)
Processor #0 6:10 APIC version 17 (quad 2, apic 33)
Processor #4 6:10 APIC version 17 (quad 2, apic 40)
Processor #1 6:10 APIC version 17 (quad 2, apic 34)
Processor #2 6:10 APIC version 17 (quad 2, apic 36)
Processor #0 6:10 APIC version 17 (quad 3, apic 49)
Processor #4 6:10 APIC version 17 (quad 3, apic 56)
Processor #1 6:10 APIC version 17 (quad 3, apic 50)
Processor #2 6:10 APIC version 17 (quad 3, apic 52)
Processor #0 6:10 APIC version 17 (quad 4, apic 65)
Processor #4 6:10 APIC version 17 (quad 4, apic 72)
Processor #1 6:10 APIC version 17 (quad 4, apic 66)
Processor #2 6:10 APIC version 17 (quad 4, apic 68)
Processor #0 6:10 APIC version 17 (quad 5, apic 81)
Processor #4 6:10 APIC version 17 (quad 5, apic 88)
Processor #1 6:10 APIC version 17 (quad 5, apic 82)
Processor #2 6:10 APIC version 17 (quad 5, apic 84)
Processor #0 6:10 APIC version 17 (quad 6, apic 97)
Processor #4 6:10 APIC version 17 (quad 6, apic 104)
Processor #1 6:10 APIC version 17 (quad 6, apic 98)
Processor #2 6:10 APIC version 17 (quad 6, apic 100)
Processor #0 6:10 APIC version 17 (quad 7, apic 113)
Processor #4 6:10 APIC version 17 (quad 7, apic 120)
Processor #1 6:10 APIC version 17 (quad 7, apic 114)
Processor #2 6:10 APIC version 17 (quad 7, apic 116)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #20 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #21 is EISA   (node 1)
Bus #5 is PCI    (node 2)
Bus #6 is PCI    (node 2)
Bus #7 is PCI    (node 2)
Bus #22 is EISA   (node 2)
Bus #8 is PCI    (node 3)
Bus #9 is PCI    (node 3)
Bus #10 is PCI    (node 3)
Bus #23 is EISA   (node 3)
Bus #11 is PCI    (node 4)
Bus #12 is PCI    (node 4)
Bus #13 is PCI    (node 4)
Bus #24 is EISA   (node 4)
Bus #14 is PCI    (node 5)
Bus #15 is PCI    (node 5)
Bus #25 is EISA   (node 5)
Bus #16 is PCI    (node 6)
Bus #17 is PCI    (node 6)
Bus #26 is EISA   (node 6)
Bus #18 is PCI    (node 7)
Bus #19 is PCI    (node 7)
Bus #27 is EISA   (node 7)
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
Enabling APIC mode:  NUMA-Q.  Using 2 I/O APICs
Processors: 32
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Building zonelist for node : 4
Building zonelist for node : 5
Building zonelist for node : 6
Building zonelist for node : 7
Kernel command line: root=/dev/sda2 console=ttyS0,38400n8 debug mem=67100672K
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 700.418 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Initializing highpages for node 4
Initializing highpages for node 5
Initializing highpages for node 6
Initializing highpages for node 7
Memory: 65306956k/67100672k available (1724k kernel code, 98252k reserved, 781k data, 284k init, 65134592k highmem)
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
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Cascades) stepping 04
per-CPU timeslice cutoff: 5854.90 usecs.
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
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Cascades) stepping 04
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU2: Intel Pentium III (Cascades) stepping 00
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU3: Intel Pentium III (Cascades) stepping 04
Booting processor 4/17 eip 2000
Storing NMI vector
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU4: Intel Pentium III (Cascades) stepping 01
Booting processor 5/18 eip 2000
Storing NMI vector
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU5: Intel Pentium III (Cascades) stepping 01
Booting processor 6/20 eip 2000
Storing NMI vector
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU6: Intel Pentium III (Cascades) stepping 01
Booting processor 7/24 eip 2000
Storing NMI vector
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU7: Intel Pentium III (Cascades) stepping 01
Booting processor 8/33 eip 2000
Storing NMI vector
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU8: Intel Pentium III (Cascades) stepping 04
Booting processor 9/34 eip 2000
Storing NMI vector
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU9: Intel Pentium III (Cascades) stepping 04
Booting processor 10/36 eip 2000
Storing NMI vector
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU10: Intel Pentium III (Cascades) stepping 04
Booting processor 11/40 eip 2000
Storing NMI vector
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 2
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU11: Intel Pentium III (Cascades) stepping 04
Booting processor 12/49 eip 2000
Storing NMI vector
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU12: Intel Pentium III (Cascades) stepping 00
Booting processor 13/50 eip 2000
Storing NMI vector
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 3
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU13: Intel Pentium III (Cascades) stepping 04
Booting processor 14/52 eip 2000
Storing NMI vector
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 3
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU14: Intel Pentium III (Cascades) stepping 00
Booting processor 15/56 eip 2000
Storing NMI vector
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU15: Intel Pentium III (Cascades) stepping 00
Booting processor 16/65 eip 2000
Storing NMI vector
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 4
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU16: Intel Pentium III (Cascades) stepping 00
Booting processor 17/66 eip 2000
Storing NMI vector
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 4
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU17: Intel Pentium III (Cascades) stepping 00
Booting processor 18/68 eip 2000
Storing NMI vector
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 4
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU18: Intel Pentium III (Cascades) stepping 00
Booting processor 19/72 eip 2000
Storing NMI vector
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 4
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU19: Intel Pentium III (Cascades) stepping 00
Booting processor 20/81 eip 2000
Storing NMI vector
Initializing CPU#20
masked ExtINT on CPU#20
Leaving ESR disabled.
Mapping cpu 20 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU20: Intel Pentium III (Cascades) stepping 00
Booting processor 21/82 eip 2000
Storing NMI vector
Initializing CPU#21
masked ExtINT on CPU#21
Leaving ESR disabled.
Mapping cpu 21 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU21: Intel Pentium III (Cascades) stepping 00
Booting processor 22/84 eip 2000
Storing NMI vector
Initializing CPU#22
masked ExtINT on CPU#22
Leaving ESR disabled.
Mapping cpu 22 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU22: Intel Pentium III (Cascades) stepping 00
Booting processor 23/88 eip 2000
Storing NMI vector
Initializing CPU#23
masked ExtINT on CPU#23
Leaving ESR disabled.
Mapping cpu 23 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU23: Intel Pentium III (Cascades) stepping 00
Booting processor 24/97 eip 2000
Storing NMI vector
Initializing CPU#24
masked ExtINT on CPU#24
Leaving ESR disabled.
Mapping cpu 24 to node 6
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU24: Intel Pentium III (Cascades) stepping 00
Booting processor 25/98 eip 2000
Storing NMI vector
Initializing CPU#25
masked ExtINT on CPU#25
Leaving ESR disabled.
Mapping cpu 25 to node 6
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU25: Intel Pentium III (Cascades) stepping 00
Booting processor 26/100 eip 2000
Storing NMI vector
Initializing CPU#26
masked ExtINT on CPU#26
Leaving ESR disabled.
Mapping cpu 26 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU26: Intel Pentium III (Cascades) stepping 00
Booting processor 27/104 eip 2000
Storing NMI vector
Initializing CPU#27
masked ExtINT on CPU#27
Leaving ESR disabled.
Mapping cpu 27 to node 6
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU27: Intel Pentium III (Cascades) stepping 00
Booting processor 28/113 eip 2000
Storing NMI vector
Initializing CPU#28
masked ExtINT on CPU#28
Leaving ESR disabled.
Mapping cpu 28 to node 7
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU28: Intel Pentium III (Cascades) stepping 01
Booting processor 29/114 eip 2000
Storing NMI vector
Initializing CPU#29
masked ExtINT on CPU#29
Leaving ESR disabled.
Mapping cpu 29 to node 7
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU29: Intel Pentium III (Cascades) stepping 00
Booting processor 30/116 eip 2000
Storing NMI vector
Initializing CPU#30
masked ExtINT on CPU#30
Leaving ESR disabled.
Mapping cpu 30 to node 7
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU30: Intel Pentium III (Cascades) stepping 00
Booting processor 31/120 eip 2000
Storing NMI vector
Initializing CPU#31
masked ExtINT on CPU#31
Leaving ESR disabled.
Mapping cpu 31 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU31: Intel Pentium III (Cascades) stepping 01
Total of 32 processors activated (44396.54 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 13-0, 14-0, 14-8, 14-18, 14-19, 14-20, 14-21, 14-22, 14-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
...trying to set up timer as Virtual Wire IRQ... works.
number of MP IRQ sources: 320.
number of IO-APIC #13 registers: 24.
number of IO-APIC #14 registers: 24.
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
.... register #02: 0E000000
.......     : arbitration: 0E
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
IRQ13 -> 0:13
IRQ14 -> 0:14
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0914 MHz.
..... host bus clock speed is 99.0987 MHz.
checking TSC synchronization across 32 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 164351 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 164351 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 164351 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 164351 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has -394007 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has -394007 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has -394007 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has -394007 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 227875 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 227875 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 227874 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 227875 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has 627665 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has 627665 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has 627665 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has 627665 usecs TSC skew! FIXED.
BIOS BUG: CPU#16 improperly initialized, has 232244 usecs TSC skew! FIXED.
BIOS BUG: CPU#17 improperly initialized, has 232244 usecs TSC skew! FIXED.
BIOS BUG: CPU#18 improperly initialized, has 232244 usecs TSC skew! FIXED.
BIOS BUG: CPU#19 improperly initialized, has 232244 usecs TSC skew! FIXED.
BIOS BUG: CPU#20 improperly initialized, has -278986 usecs TSC skew! FIXED.
BIOS BUG: CPU#21 improperly initialized, has -278986 usecs TSC skew! FIXED.
BIOS BUG: CPU#22 improperly initialized, has -278986 usecs TSC skew! FIXED.
BIOS BUG: CPU#23 improperly initialized, has -278986 usecs TSC skew! FIXED.
BIOS BUG: CPU#24 improperly initialized, has -180710 usecs TSC skew! FIXED.
BIOS BUG: CPU#25 improperly initialized, has -180710 usecs TSC skew! FIXED.
BIOS BUG: CPU#26 improperly initialized, has -180710 usecs TSC skew! FIXED.
BIOS BUG: CPU#27 improperly initialized, has -180710 usecs TSC skew! FIXED.
BIOS BUG: CPU#28 improperly initialized, has -398432 usecs TSC skew! FIXED.
BIOS BUG: CPU#29 improperly initialized, has -398432 usecs TSC skew! FIXED.
BIOS BUG: CPU#30 improperly initialized, has -398432 usecs TSC skew! FIXED.
BIOS BUG: CPU#31 improperly initialized, has -398432 usecs TSC skew! FIXED.
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
PCI: Using configuration type 1
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
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
PCI->APIC IRQ transform: (B2,I12,P0) -> 40
PCI->APIC IRQ transform: (B2,I13,P0) -> 36
PCI->APIC IRQ transform: (B2,I15,P0) -> 28
PCI->APIC IRQ transform: (B0,I10,P0) -> 23
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI: using PPB(B0,I12,P0) to get irq 15
PCI->APIC IRQ transform: (B1,I4,P0) -> 15
PCI: using PPB(B0,I12,P1) to get irq 13
PCI->APIC IRQ transform: (B1,I5,P1) -> 13
PCI: using PPB(B0,I12,P2) to get irq 11
PCI->APIC IRQ transform: (B1,I6,P2) -> 11
PCI: using PPB(B0,I12,P3) to get irq 7
PCI->APIC IRQ transform: (B1,I7,P3) -> 7
Enabling SEP on CPU 1
Enabling SEP on CPU 2
Enabling SEP on CPU 3
Enabling SEP on CPU 20
Enabling SEP on CPU 21
Enabling SEP on CPU 22
Enabling SEP on CPU 23
Enabling SEP on CPU 29
Enabling SEP on CPU 28
Enabling SEP on CPU 30
Enabling SEP on CPU 31
Enabling SEP on CPU 13
Enabling SEP on CPU 6
Enabling SEP on CPU 7
Enabling SEP on CPU 8
Enabling SEP on CPU 9
Enabling SEP on CPU 25
Enabling SEP on CPU 24
Enabling SEP on CPU 14
Enabling SEP on CPU 4
Enabling SEP on CPU 5
Enabling SEP on CPU 27
Enabling SEP on CPU 26
Enabling SEP on CPU 10
Enabling SEP on CPU 11
Enabling SEP on CPU 12
Enabling SEP on CPU 15
Enabling SEP on CPU 17
Enabling SEP on CPU 18
Enabling SEP on CPU 19
Enabling SEP on CPU 16
Enabling SEP on CPU 0
Total HugeTLB memory allocated, 0
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.06
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.4.1, February 10, 2002)
eth0: Adaptec Starfire 6915 at 0xf8a53000, 00:00:d1:ec:cf:9d, IRQ 15.
eth0: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth0: scatter-gather and hardware TCP cksumming disabled.
eth1: Adaptec Starfire 6915 at 0xf8ad4000, 00:00:d1:ec:cf:9e, IRQ 13.
eth1: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth1: scatter-gather and hardware TCP cksumming disabled.
eth2: Adaptec Starfire 6915 at 0xf8b55000, 00:00:d1:ec:cf:9f, IRQ 11.
eth2: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
eth3: Adaptec Starfire 6915 at 0xf8bd6000, 00:00:d1:ec:cf:a0, IRQ 7.
eth3: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2944 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

anticipatory scheduling elevator
(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM OEM   Model: DCHS09X           Rev: 5454
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:2): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:3): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:3:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:4): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM OEM   Model: DCHS09X           Rev: 5454
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:4:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:5): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:5:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:8): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:8:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:9): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:9:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
(scsi0:A:10): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:10:0: Tagged Queuing enabled.  Depth 253
anticipatory scheduling elevator
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c021e1c2>] scsi_register+0x6e/0x3ac
 [<c0243197>] isp1020_detect+0x67/0x2c0
 [<c021e53a>] scsi_register_host+0x3a/0x94
 [<c0105101>] init+0x75/0x1f4
 [<c010508c>] init+0x0/0x1f4
 [<c01071e5>] kernel_thread_helper+0x5/0xc

qlogicisp : new isp1020 revision ID (3)
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c021e1c2>] scsi_register+0x6e/0x3ac
 [<c0243197>] isp1020_detect+0x67/0x2c0
 [<c021e53a>] scsi_register_host+0x3a/0x94
 [<c0105101>] init+0x75/0x1f4
 [<c010508c>] init+0x0/0x1f4
 [<c01071e5>] kernel_thread_helper+0x5/0xc

qlogicisp : new isp1020 revision ID (5)
scsi1 : QLogic ISP1020 SCSI on PCI bus 02 device 68 irq 36 MEM base 0xf8c59000
anticipatory scheduling elevator
scsi2 : QLogic ISP1020 SCSI on PCI bus 02 device 78 irq 28 MEM base 0xf8c5b000
anticipatory scheduling elevator
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 17796077 512-byte hdwr sectors (9112 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdc: drive cache: write through
 sdc: unknown partition table
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdd: drive cache: write through
 sdd: unknown partition table
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
SCSI device sde: 17796077 512-byte hdwr sectors (9112 MB)
SCSI device sde: drive cache: write through
 sde: sde1 < >
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
SCSI device sdf: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdf: drive cache: write through
 sdf: unknown partition table
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
SCSI device sdg: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdg: drive cache: write through
 sdg: unknown partition table
Attached scsi disk sdg at scsi0, channel 0, id 8, lun 0
SCSI device sdh: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdh: drive cache: write through
 sdh: unknown partition table
Attached scsi disk sdh at scsi0, channel 0, id 9, lun 0
SCSI device sdi: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdi: drive cache: write through
 sdi: unknown partition table
Attached scsi disk sdi at scsi0, channel 0, id 10, lun 0
input: PC Speaker
oprofile: using NMI interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 262144 buckets, 4096Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 284k freed
INIT: version 2.84 booting
Activating swap.
Checking root file system...
fsck 1.32 (09-Nov-2002)
/dev/sda2: clean, 84725/513024 files, 675816/1024143 blocks
System time was Fri Mar 28 03:33:33 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Fri Mar 28 03:33:35 UTC 2003.
Checking all file systems...
fsck 1.32 (09-Nov-2002)
Setting kernel variables..
Mounting local filesystems...
nothing was mounted
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... eth0: Link is down
done.
Loading the saved-state of the serial devices... 
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
Setting up general console font...eth0: Link is up, running at 100Mbit full-duplex
  done.
cannot (un)set powersave mode

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Thu Mar 27 19:33:39 PST 2003

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting internet superserver: inetd.
Starting network benchmark server: netserver.
Starting OpenBSD Secure Shell server: sshd.
Starting NTP server: ntpd.

Debian GNU/Linux testing/unstable megeira ttyS0

megeira login: root
Password: 
Last login: Thu Mar 27 15:07:58 2003 on ttyS0
Linux megeira 2.5.65-mm2 #1 SMP Thu Mar 20 17:10:09 PST 2003 i686 unknown unknown GNU/Linux
megeira:~# cat /proc/mm me  eminfo
MemTotal:     65310668 kB
MemFree:      65261044 kB
Buffers:           956 kB
Cached:           8420 kB
SwapCached:          0 kB
Active:           6932 kB
Inactive:         3900 kB
HighTotal:    65134592 kB
HighFree:     65116864 kB
LowTotal:       176076 kB
LowFree:        144180 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:           4728 kB
Slab:             8824 kB
Committed_AS:     2324 kB
PageTables:        196 kB
ReverseMaps:       368
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
megeira:~# shutdown -h now
[?5hBroadcast message from root (ttyS0) (Thu Mar 27 19:34:56 2003):

The system is going down for system halt NOW!
INIT: INIT: Sending processes the TERM signal
megeira:~# INIT:Stopping internet superserver: inetd.
Stopping network benchmark server: netserver.
Stopping OpenBSD Secure Shell server: sshd.
Stopping NTP server: ntpd.
Saving the System Clock time to the Hardware Clock...
Hardware Clock updated to Thu Mar 27 19:35:04 PST 2003.
Stopping kernel log daemon: klogd.
Stopping system log daemon: syslogd.
Sending all processes the TERM signal... done.
Sending all processes the KILL signal... done.
Saving random seed... done.
Unmounting remote filesystems... done.
Deconfiguring network interfaces... done.
Deactivating swap... done.
Unmounting local filesystems... done.
Synchronizing SCSI caches: 
Shutting down devices
Power down.
[?1l>[24;1H
[?1049l[detached]
$ 

Script done on Thu Mar 27 19:48:16 2003
