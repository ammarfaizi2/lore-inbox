Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288365AbSACWsw>; Thu, 3 Jan 2002 17:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288368AbSACWsg>; Thu, 3 Jan 2002 17:48:36 -0500
Received: from topic-gw2.topic.com.au ([203.37.31.2]:32494 "EHLO
	mailhost.topic.com.au") by vger.kernel.org with ESMTP
	id <S288365AbSACWsW>; Thu, 3 Jan 2002 17:48:22 -0500
Date: Fri, 4 Jan 2002 09:47:44 +1100
From: Jason Thomas <jason@topic.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in devfs
Message-ID: <20020103224744.GB29846@topic.com.au>
In-Reply-To: <20020103014507.GB19702@topic.com.au> <200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <200201030724.g037ONj04041@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Okay same thing.

On Thu, Jan 03, 2002 at 12:24:23AM -0700, Richard Gooch wrote:
> Grab devfs-patch-v199.6 from your local kernel.org mirror site and try
> again. If you still have the same problem, send the new ksymoops
> output as well as *complete* kernel boot logs.

they are attached.

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oops3

Linux version 2.4.17 (root@sothis) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 SMP Fri Jan 4 09:31:39 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
 BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
found SMP MP-table at 000f5530
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 262140
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32764 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: root=/dev/scsi/host0/bus0/target0/lun0/part1 ro
Initializing CPU#0
Detected 1004.523 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2005.40 BogoMIPS
Memory: 1029448k/1048560k available (1218k kernel code, 18724k reserved, 447k data, 228k init, 131056k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
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
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
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
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
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
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  1    1    0   1   0    1    1    99
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
..... CPU clock speed is 1004.3477 MHz.
..... host bus clock speed is 133.9128 MHz.
cpu: 0, clocks: 1339128, slice: 446376
CPU0<T0:1339120,T1:892736,D:8,S:446376,C:1339128>
cpu: 1, clocks: 1339128, slice: 446376
CPU1<T0:1339120,T1:446368,D:0,S:446376,C:1339128>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0d60, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
PCI: Enabling Via external APIC routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.8 (20011226) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:E0:18:05:1F:25, IRQ 10.
  Board assembly 733470-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 8, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c1010-33 detected with Symbios NVRAM
sym53c8xx: at PCI bus 0, device 8, function 1
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c1010-33 detected with Symbios NVRAM
sym53c1010-33-0: rev 0x1 on pci bus 0 device 8 function 0 irq 15
sym53c1010-33-0: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
sym53c1010-33-0: on-chip RAM at 0xf9800000
sym53c1010-33-0: restart (scsi reset).
sym53c1010-33-0: handling phase mismatch from SCRIPTS.
sym53c1010-33-0: Downloading SCSI SCRIPTS.
sym53c1010-33-1: rev 0x1 on pci bus 0 device 8 function 1 irq 11
sym53c1010-33-1: Symbios format NVRAM, ID 7, Fast-80, Parity Checking
sym53c1010-33-1: on-chip RAM at 0xf8800000
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
  Vendor: SEAGATE   Model: ST34573LW         Rev: 5702
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DDYS-T18350N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c1010-33-0-<0,0>: tagged command queue depth set to 8
sym53c1010-33-0-<1,0>: tagged command queue depth set to 8
sym53c1010-33-0-<2,0>: tagged command queue depth set to 8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
sym53c1010-33-0-<0,0>: phase change 6-7 11@000074b8 resid=2.
sym53c1010-33-0-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 15)
SCSI device sda: 8888924 512-byte hdwr sectors (4551 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2
sym53c1010-33-0-<1,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
sym53c1010-33-0-<2,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1
LVM version 1.0.1-rc4(ish)(03/10/2001)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 228k freed
Adding Swap: 2040244k swap-space (priority -1)
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
invalidate: dirty buffer
invalidate: busy buffer
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on lvm(58,0), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on lvm(58,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on lvm(58,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kernel BUG at dcache.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0144b52>]    Not tainted
EFLAGS: 00010286
eax: 0000001c   ebx: f7adbcd0   ecx: c028dbe0   edx: 000037f9
esi: f7a7c9a0   edi: f7adbca0   ebp: f7adbca0   esp: f7a6bf08
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 25, stackpage=f7a6b000)
Stack: c02408f3 0000028e f66d65a0 f7a7c9a0 f7aa3bc0 c016a33f f7adbca0 f7a7c9a0 
       f7adbca0 00000000 f7a6bfa4 f7aa50c0 c013be5e f7adbca0 00000000 f7a6bf74 
       c013c6c1 f7aa50c0 f7a6bf74 00000000 f682b000 00000000 f7a6bfa4 00000009 
Call Trace: [<c016a33f>] [<c013be5e>] [<c013c6c1>] [<c013c94a>] [<c013ce31>] 
   [<c013984d>] [<c0132824>] [<c0106dbb>] 

Code: 0f 0b 83 c4 08 f0 fe 0d a0 36 2e c0 0f 88 c3 63 0e 00 85 f6 
 

--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops3.done"

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
cpu: 0, clocks: 1339128, slice: 446376
cpu: 1, clocks: 1339128, slice: 446376
kernel BUG at dcache.c:654!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0144b52>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: f7adbcd0   ecx: c028dbe0   edx: 000037f9
esi: f7a7c9a0   edi: f7adbca0   ebp: f7adbca0   esp: f7a6bf08
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 25, stackpage=f7a6b000)
Stack: c02408f3 0000028e f66d65a0 f7a7c9a0 f7aa3bc0 c016a33f f7adbca0 f7a7c9a0 
       f7adbca0 00000000 f7a6bfa4 f7aa50c0 c013be5e f7adbca0 00000000 f7a6bf74 
       c013c6c1 f7aa50c0 f7a6bf74 00000000 f682b000 00000000 f7a6bfa4 00000009 
Call Trace: [<c016a33f>] [<c013be5e>] [<c013c6c1>] [<c013c94a>] [<c013ce31>] 
   [<c013984d>] [<c0132824>] [<c0106dbb>] 
Code: 0f 0b 83 c4 08 f0 fe 0d a0 36 2e c0 0f 88 c3 63 0e 00 85 f6 

>>EIP; c0144b52 <d_instantiate+22/58>   <=====
Trace; c016a33e <devfs_d_revalidate_wait+8a/bc>
Trace; c013be5e <cached_lookup+2e/54>
Trace; c013c6c0 <link_path_walk+5e0/850>
Trace; c013c94a <path_walk+1a/1c>
Trace; c013ce30 <__user_walk+34/50>
Trace; c013984c <sys_stat64+18/70>
Trace; c0132824 <sys_read+bc/c4>
Trace; c0106dba <system_call+32/38>
Code;  c0144b52 <d_instantiate+22/58>
00000000 <_EIP>:
Code;  c0144b52 <d_instantiate+22/58>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0144b54 <d_instantiate+24/58>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c0144b56 <d_instantiate+26/58>
   5:   f0 fe 0d a0 36 2e c0      lock decb 0xc02e36a0
Code;  c0144b5e <d_instantiate+2e/58>
   c:   0f 88 c3 63 0e 00         js     e63d5 <_EIP+0xe63d5> c022af26 <stext_lock+2c22/88ee>
Code;  c0144b64 <d_instantiate+34/58>
  12:   85 f6                     test   %esi,%esi


2 warnings issued.  Results may not be reliable.

--l76fUT7nc3MelDdI--
