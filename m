Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRHKSEH>; Sat, 11 Aug 2001 14:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268617AbRHKSD6>; Sat, 11 Aug 2001 14:03:58 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:1288 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S268614AbRHKSDw> convert rfc822-to-8bit; Sat, 11 Aug 2001 14:03:52 -0400
Date: Sat, 11 Aug 2001 20:01:54 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel crashes in 2.4.x with SMP
Message-Id: <20010811193940.34CD.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, 

I've tested 2.4.x on several computers with SMP.

One of them I wrote about earlier.. and another I've just recently been
able to get the kernel panic information from since it's located in
in another country.

It crashes with a similar message as the other..  is this an hw error?
or something else? ;) Maybe a bad driver for the E1000 nic.. ?

Dmesg:

0000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
 BIOS-e820: 000000002fff0000 - 000000002ffffc00 (ACPI data)
 BIOS-e820: 000000002ffffc00 - 0000000030000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6ac0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009f000 reserved twice.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: SBT2         APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=linux ro root=305 BOOT_FILE=/vmlinuz
Initializing CPU#0
Detected 931.030 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1854.66 BogoMIPS
Memory: 770632k/786368k available (1251k kernel code, 15344k reserved, 391k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
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
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.28 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1861.22 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3715.89 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 4 ... ok.
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-2, 4-5, 4-9, 4-10, 4-11, 5-5, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 5-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 0F000000
.......     : arbitration: 0F
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    89
 01 003 03  1    1    0   1   0    1    1    91
 02 003 03  1    1    0   1   0    1    1    99
 03 003 03  1    1    0   1   0    1    1    A1
 04 003 03  1    1    0   1   0    1    1    A9
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  1    1    0   1   0    1    1    B1
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ17 -> 1:1
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ20 -> 1:4
IRQ22 -> 1:6
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 930.9679 MHz.
..... host bus clock speed is 132.9952 MHz.
cpu: 0, clocks: 1329952, slice: 443317
CPU0<T0:1329952,T1:886624,D:11,S:443317,C:1329952>
cpu: 1, clocks: 1329952, slice: 443317
CPU1<T0:1329952,T1:443312,D:6,S:443317,C:1329952>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfdb47, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 01
PCI->APIC IRQ transform: (B0,I2,P0) -> 19
PCI->APIC IRQ transform: (B0,I3,P0) -> 18
PCI->APIC IRQ transform: (B1,I4,P0) -> 16
PCI->APIC IRQ transform: (B1,I4,P1) -> 17
PCI->APIC IRQ transform: (B1,I12,P0) -> 22
PCI->APIC IRQ transform: (B2,I8,P0) -> 20
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 511610kB/380538kB, 1536 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x5440-0x5447, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x5448-0x544f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD307AA, ATA DISK drive
hdb: SONY CDU4811, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63, UDMA(33)
hdb: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
DAC960: ***** DAC960 RAID Driver Version 2.4.10 of 1 February 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex eXtremeRAID 2000 PCI RAID Controller
DAC960#0:   Firmware Version: 6.00-01, Channels: 4, Memory Size: 32MB
DAC960#0:   PCI Bus: 2, Device: 8, Function: 0, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xF8000000 mapped at 0xF0800000, IRQ Channel: 20
DAC960#0:   Controller Queue Depth: 512, Maximum Blocks per Command: 2048
DAC960#0:   Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
DAC960#0:   Physical Devices:
DAC960#0:     0:0  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         TFFEB196
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:1  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3V888
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:2  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3K791
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:3  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3X071
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:4  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3K885
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:6  Vendor: ESG-SHV   Model: SCA HSBP M14      Revision: 0.01
DAC960#0:          Asynchronous
DAC960#0:     0:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     1:0  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3T862
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     1:1  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3T550
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     1:2  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3P559
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     1:3  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3W070
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     1:4  Vendor: IBM       Model: DDYS-T36950M      Revision: S93E
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number:         4FY3K011
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     1:6  Vendor: ESG-SHV   Model: SCA HSBP M14      Revision: 0.01
DAC960#0:          Asynchronous
DAC960#0:     1:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     2:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:     3:7  Vendor: MYLEX     Model: eXtremeRAID 2000  Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-0, Online, 716513280 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry: 255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Disabled
 rd/c0d0: rd/c0d0p1
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:B6:13:9F, IRQ 18.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
[drm:radeon_init] *ERROR* Cannot initialize agpgart module.
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 2048248k swap-space (priority -1)
DAC960#0: Physical Device 0:6 Found
DAC960#0: Physical Device 1:6 Found
DAC960#0: Physical Device 1:0 Found
DAC960#0: Physical Device 0:0 Found
DAC960#0: Physical Device 0:1 Found
DAC960#0: Physical Device 0:2 Found
DAC960#0: Physical Device 0:3 Found
DAC960#0: Physical Device 0:4 Found
DAC960#0: Physical Device 1:1 Found
DAC960#0: Physical Device 1:2 Found
DAC960#0: Physical Device 1:3 Found
DAC960#0: Physical Device 1:4 Found
DAC960#0: Physical Device 0:0 Online
DAC960#0: Physical Device 0:1 Online
DAC960#0: Physical Device 0:2 Online
DAC960#0: Physical Device 0:3 Online
DAC960#0: Physical Device 0:4 Online
DAC960#0: Physical Device 1:0 Online
DAC960#0: Physical Device 1:1 Online
DAC960#0: Physical Device 1:2 Online
DAC960#0: Physical Device 1:3 Online
DAC960#0: Physical Device 1:4 Online
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Online
DAC960#0: Controller Battery Backup Unit Found
DAC960#0: Enclosure 1 Temperature Sensor 0 OK
DAC960#0: Enclosure 2 Temperature Sensor 0 OK
Intel(R) PRO/1000 Network Driver - version 3.0.16
Copyright (c) 1999-2001 Intel Corporation.

Intel(R) PRO/1000 Network Connection
eth1:  Mem:0xf6020000  IRQ:22  Speed:1000 Mbps  Duplex:Full



Kernel Crash message:

Warning: kfree_skb passed an skb still on a list (from c01f0689)
invalid operand: 0000
CPU: 0
EIP: 0010:[<c01ed303>]
EFLAGS: 00010286
eax: 00000045 ebx: ef73e8a0 ecx: 00000002 edx: 02000000
esi: ef73ebc0 edi: 00000000 ebp: c02d657c esp: eb8fbe18
ds: 0018 es: 0018 ss: 0018
Prosess glftpd pid (pid: 1116, stackpage=eb8fb000)
Stack: c0269ca0 c01f0689 ef73e8a0 00000000 c01f0689 ef73ebc0 c02d6068 
00000001
       fffffffb 00000000 ef73ebc0 c0119adf c02d6068 ee671b60 c02ffa48 
00000000
       eb8fa000 00000246 c0237264 00000000 c02ffa48 00000001 ee671c38 
7fffffff
Call Trace: [<c01f0689>] [<c01f0689>] [<c0119adf>] [<c0237264>] [<c02023ef>]
    [<c021a4f5>] [<c01ea361>] [<c01ea46e>] [<c01324f7>] [<c0106cdb>]

Code: 0f 0b 83 c4 08 8b 44 24 0c 8b 40 28 85 c0 74 04 f0 ff 48 04
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing



EIP: 0010:[<c01ed303>]	-	c01ed3d0 T skb_clone

Call Trace: 
[<c01f0689>] 	c01f0630 t net_tx_action
[<c01f0689>] 	c01f0630 t net_tx_action
[<c0119adf>] 	c0119a70 T do_softirq
[<c0237264>]      c0230e5c T stext_lock <--?
[<c02023ef>]	c0202808 t tcp_close_state
[<c021a4f5>] 	c021a440 t inet_getname
[<c01ea361>]	c01ea324 T sock_recvmsg
[<c01ea46e>] 	c01ea47c t sock_write
[<c01324f7>]	c0132468 T sys_read
[<c0106cdb>]	c0106ca8 T system_call


regards,

Arnvid Karstad

