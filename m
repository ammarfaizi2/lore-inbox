Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130048AbRCHOSl>; Thu, 8 Mar 2001 09:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130038AbRCHOSc>; Thu, 8 Mar 2001 09:18:32 -0500
Received: from linux.kappa.ro ([194.102.255.131]:42892 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130050AbRCHOSS>;
	Thu, 8 Mar 2001 09:18:18 -0500
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Thu, 8 Mar 2001 16:17:23 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: Kernel crash - reboot or hang
Message-ID: <20010308161723.A9138@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello,

I NEED TO TRACE THIS!!!

I had two crashes with 2.4.2 and 2.4.2-pre2 on my local SMTP/POP3/SAMBA/WWW
server (once under some load and the second one - with 2.4.2-pre2 - while
it was almost idle).

The machine is an HP Netserver LHII without the standard raid card that
comes with it (see bellow for dmesg output for a better description of
hardware).

I do not see any corruption nor any messages in logs.


Should I use kdb or just remote logging would do the job?


-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.4.3-pre2 (root@linux) (gcc version 2.95.2 19991024 (release)) #1 SMP Mon Mar 5 18:08:49 EET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 000000000000eb0e @ 00000000000f14f2 (reserved)
 BIOS-e820: 0000000000e00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000100000 @ 0000000000f00000 (usable)
 BIOS-e820: 000000001f000000 @ 0000000001000000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 000000000000eb0e @ 00000000ffff14f2 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fd8d0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: LH II        APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    MMX  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    MMX  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is EISA  
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=802
Initializing CPU#0
Detected 300.694 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 599.65 BogoMIPS
Memory: 512764k/524288k available (1348k kernel code, 11136k reserved, 522k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
CPU: After generic, caps: 0080fbff 00000000 00000000 00000000
CPU: Common caps: 0080fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
CPU: After generic, caps: 0080fbff 00000000 00000000 00000000
CPU: Common caps: 0080fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1463.01 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 1000000
Getting ID: e000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/0 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 0) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 601.29 BogoMIPS
Stack at about c189bfbc
CPU: Before vendor init, caps: 0080fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0080fbff 00000000 00000000 00000000
CPU: After generic, caps: 0080fbff 00000000 00000000 00000000
CPU: Common caps: 0080fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium II (Klamath) stepping 04
CPU has booted.
Before bogomips.
Total of 2 processors activated (1200.94 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
..TIMER: vector=49 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  1    1    0   0   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 300.6832 MHz.
..... host bus clock speed is 66.8184 MHz.
cpu: 0, clocks: 668184, slice: 222728
CPU0<T0:668176,T1:445440,D:8,S:222728,C:668184>
cpu: 1, clocks: 668184, slice: 222728
CPU1<T0:668176,T1:222720,D:0,S:222728,C:668184>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf5ed4, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: No more nibble data (0 bytes)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 340746kB/209674kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:A0:C9:B5:7B:58, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 690106-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
8139too Fast Ethernet driver 0.9.15 loaded
eth1: RealTek RTL8139 Fast Ethernet at 0xe0802800, 00:00:21:d7:a7:b6, IRQ 11
eth1:  Identified 8139 chip type 'RTL-8139A'
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
ahc_pci:0:10:0: Using left over BIOS settings
ahc_pci:0:11:0: Using left over BIOS settings
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: HP        Model: 4.26GB A 80-LXY4  Rev: LXY4
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: SONY      Model: CD-ROM CDU-415    Rev: 1.1n
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
scsi0:0:0:0: Tagged Queuing enabled.  Depth 8
  Vendor: HP        Model: 9.10GB A 80-1226  Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi1, channel 0, id 5, lun 0
  Vendor: HP        Model: 9.10GB A 80-1226  Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 6, lun 0
scsi1:0:5:0: Tagged Queuing enabled.  Depth 8
scsi1:0:6:0: Tagged Queuing enabled.  Depth 8
(scsi0:A:5): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sda: 8330543 512-byte hdwr sectors (4265 MB)
Partition check:
 sda: sda1 sda2
(scsi1:A:5): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdb: 17773524 512-byte hdwr sectors (9100 MB)
 sdb: sdb1
(scsi1:A:6): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
SCSI device sdc: 17773524 512-byte hdwr sectors (9100 MB)
 sdc: sdc1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack (4096 buckets, 32768 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 136512k swap-space (priority -1)
reiserfs: checking transaction log (device 08:11) ...
reiserfs: replayed 3 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:21) ...
reiserfs: replayed 1 transactions in 3 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25

--PNTmBPCT7hxwcZjr--
