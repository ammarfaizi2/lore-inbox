Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264671AbSJ3Mkt>; Wed, 30 Oct 2002 07:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264670AbSJ3Mkt>; Wed, 30 Oct 2002 07:40:49 -0500
Received: from [80.247.74.2] ([80.247.74.2]:31139 "EHLO foradada.isolaweb.it")
	by vger.kernel.org with ESMTP id <S264667AbSJ3Mkn>;
	Wed, 30 Oct 2002 07:40:43 -0500
Message-Id: <5.1.1.6.0.20021030132848.03a12ec0@mail.isolaweb.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 30 Oct 2002 13:45:48 +0100
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-scanner: scanned by Antivirus Service IsolaWeb Agency - (http://www.isolaweb.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a problem with a DAT on a Compaq Proliant ML350 with PIII 1GHz,
1Gb RAM, RAID controller Smart Array 451 with 3 x HDD 9Gb RAID 5
and an internal SCSI controller Adaptec 7899 Ultra160 where is connected
only a DAT 12/24 Gb. Current installed distribution is RH7.3 with its kernel
2.4.18-10 but I've tryed the standard 2.4.19 with the same problem.
The problem is that the DAT don't work any more with Linux. This DAT work
well on Win2K :-(! Below  there is some logs and a 'ps fax' showing a tar in
D state.

Does anyone know a solution ?

Thanks in advance,

Roberto Fichera

=====================================================
Linux version 2.4.18-10custom (root@custom) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-112)) #1 Wed Oct 30 11:26:14 CET 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000048000000 (usable)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
256MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f02c0
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 294912
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 65536 pages.
Intel MultiProcessor Specification v1.4
     Virtual Wire compatibility mode.
OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 16
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Processors: 1
Kernel command line: auto BOOT_IMAGE=linux ro root=4806 
BOOT_FILE=/boot/vmlinuz-2.4.18-10
Initializing CPU#0
Detected 993.400 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1979.18 BogoMIPS
Memory: 1161504k/1179648k available (855k kernel code, 17756k reserved, 
218k data, 212k init, 262144k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 993.2873 MHz.
..... host bus clock speed is 132.4380 MHz.
cpu: 0, clocks: 1324380, slice: 662190
CPU0<T0:1324368,T1:662176,D:2,S:662190,C:1324380>
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
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
allocated 64 pages and 64 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.5.0 initialized
Journalled Block Device driver loaded
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10e
block: 1024 slots per queue, batch=256
Compaq SMART2 Driver (v 2.4.21)
cpqarray: Device 0x46 has been found at bus 4 dev 4 func 0
PCI: Found IRQ 11 for device 04:04.0
cpqarray: Finding drives on ida0 (Smart Array 431)
cpqarray ida/c0d0: blksz=512 nr_blks=71106240
blk: queue c026b300, I/O limit 4095Mb (mask 0xffffffff)
Partition check:
  ida/c0d0: p1 p2 < p5 p6 >
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
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
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 526296k swap-space (priority -1)
EXT3 FS 2.4-0.9.18, 14 May 2002 on ida0(72,6), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on ida0(72,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 01:04.0
PCI: Sharing IRQ 11 with 01:04.1
PCI: Found IRQ 11 for device 01:04.1
PCI: Sharing IRQ 11 with 01:04.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
         <Adaptec (Compaq OEM) 3960D Ultra160 SCSI adapter>
         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.6
         <Adaptec (Compaq OEM) 3960D Ultra160 SCSI adapter>
         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
   Vendor: COMPAQ    Model: SDT-9000          Rev: 4.20
   Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 6, lun 0
(scsi0:A:6): 10.000MB/s transfers (10.000MHz, offset 15)
st0: Block limits 1 - 16777215 bytes.

=====================================================
cat /proc/scsi/aic7xxx/0

Adaptec AIC7xxx driver version: 6.2.6
aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Corrupted Serial EEPROM
Channel A Target 0 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 4 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
	Goal: 10.000MB/s transfers (10.000MHz, offset 15)
	Curr: 10.000MB/s transfers (10.000MHz, offset 15)
	Channel A Target 6 Lun 0 Settings
		Commands Queued 14
		Commands Active 1
		Command Openings 0
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Channel A Target 7 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
	User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

=====================================================
ps fax

   PID TTY      STAT   TIME COMMAND
     1 ?        S      0:00 init [3]
     2 ?        SW     0:00 [keventd]
     3 ?        SWN    0:00 [ksoftirqd_CPU0]
     4 ?        SW     0:00 [kswapd]
     5 ?        SW     0:00 [bdflush]
     6 ?        SW     0:00 [kupdated]
     8 ?        SW     0:00 [kjournald]
   116 ?        SW     0:00 [kjournald]
   419 ?        S      0:00 syslogd -m 0
   424 ?        S      0:00 klogd -x
   477 ?        S      0:00 xinetd -stayalive -reuse -pidfile 
/var/run/xinetd.pid
   520 ?        S      0:00 lpd Waiting
   551 ?        S      0:00 sendmail: accepting connections
   570 ?        S      0:00 crond
   612 ?        S      0:00 xfs -droppriv -daemon
   630 ?        S      0:00 smbd -D
   635 ?        S      0:00 nmbd -D
   639 ?        S      0:00  \_ nmbd -D
   672 ?        S      0:00 /usr/sbin/atd
   689 tty3     S      0:00 /sbin/mingetty tty3
   690 tty4     S      0:00 /sbin/mingetty tty4
   691 tty5     S      0:00 /sbin/mingetty tty5
   692 tty6     S      0:00 /sbin/mingetty tty6
   756 ?        S      0:00 acushare -start
  1075 ?        S      0:00 login -- root
  1079 tty1     S      0:00  \_ -bash
  1363 tty1     D      0:00      \_ tar cvf /dev/st0 ./linux/COPYING 
./linux/CRED
  1341 ?        S      0:00 login -- roberto
  1367 tty2     S      0:00  \_ -bash
  1412 tty2     S      0:00      \_ su
  1413 tty2     S      0:00          \_ bash
  1505 tty2     R      0:00              \_ ps fax
  1345 ?        SW     0:00 [scsi_eh_0]
  1346 ?        SW     0:00 [scsi_eh_1]

=====================================================
lsmod

Module                  Size  Used by    Tainted: P
aic7xxx               124864   1  (autoclean)
st                     28788   1  (autoclean)
scsi_mod               95648   2  (autoclean) [aic7xxx st]
nls_iso8859-1           3488   0  (autoclean)
nls_cp437               5120   0  (autoclean)
vfat                   11804   0  (autoclean)
fat                    36056   0  (autoclean) [vfat]
floppy                 52480   0  (autoclean)

=====================================================
cat /proc/interrupts

CPU0
   0:     248523          XT-PIC  timer
   1:       7747          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
  11:       7883          XT-PIC  ida0, aic7xxx, aic7xxx
  15:       6818          XT-PIC  eth0
NMI:          0
LOC:     248489
ERR:          0
MIS:          0

=====================================================
cat /proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0378-037a : parport0
03c0-03df : vga+
0cf8-0cff : PCI conf1
1000-2fff : PCI Bus #01
   1000-10ff : Adaptec AHA-3960D / AIC-7899A U160/m
   1400-14ff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
   1800-18ff : ATI Technologies Inc Rage XL
   1c00-1cff : Compaq Computer Corporation Advanced System Management 
Controller
   2000-203f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
     2000-203f : eepro100
3000-300f : ServerWorks OSB4 IDE Controller
b000-b0ff : Digital Equipment Corporation DECchip 21554
   b000-b0ff : cpqarray

=====================================================
cat /proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cd000-000d0fff : Extension ROM
000f0000-000fffff : System ROM
00100000-47ffffff : System RAM
   00100000-001d5fa5 : Kernel code
   001d5fa6-0020caff : Kernel data
f5000000-f5000fff : Digital Equipment Corporation DECchip 21554
f5100000-f6ffffff : PCI Bus #01
   f5100000-f5100fff : Adaptec AHA-3960D / AIC-7899A U160/m
     f5100000-f5100fff : aic7xxx
   f5200000-f5200fff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
     f5200000-f5200fff : aic7xxx
   f5300000-f53fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   f5400000-f5400fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
     f5400000-f5400fff : eepro100
   f5500000-f5500fff : ATI Technologies Inc Rage XL
   f5600000-f56000ff : Compaq Computer Corporation Advanced System 
Management Controller
   f6000000-f6ffffff : ATI Technologies Inc Rage XL
f7000000-f7000fff : ServerWorks OSB4/CSB5 OHCI USB Controller
fff80000-ffffffff : reserved

=====================================================
lspci -v

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Flags: bus master, medium devsel, latency 64

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Flags: bus master, medium devsel, latency 64

00:01.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
	I/O behind bridge: 00001000-00002fff
	Memory behind bridge: f5100000-f6ffffff
	Capabilities: [dc] Power Management version 1

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
	Subsystem: ServerWorks OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master 
SecP PriP])
	Flags: bus master, medium devsel, latency 66
	I/O ports at 3000 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04) 
(prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at f7000000 (32-bit, non-prefetchable) [size=4K]

01:04.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
	Subsystem: Compaq Computer Corporation Compaq 64-Bit/66MHz Dual Channel 
Wide Ultra3 SCSI Adapter
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	BIST result: 00
	I/O ports at 1000 [disabled] [size=256]
	Memory at f5100000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

01:04.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
	Subsystem: Compaq Computer Corporation Compaq 64-Bit/66MHz Dual Channel 
Wide Ultra3 SCSI Adapter
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
	BIST result: 00
	I/O ports at 1400 [disabled] [size=256]
	Memory at f5200000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

01:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Compaq Computer Corporation NC3163 Fast Ethernet NIC (embedded, 
WOL)
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
	Subsystem: Compaq Computer Corporation Integrated Smart Array
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at b000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
	Capabilities: [ec] #06 [0080]


______________________________________
E-mail protetta dal servizio antivirus di IsolaWeb Agency & ISP
http://wwww.isolaweb.it
