Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRGSTPs>; Thu, 19 Jul 2001 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265902AbRGSTPj>; Thu, 19 Jul 2001 15:15:39 -0400
Received: from mail.nep.net ([12.23.44.24]:52498 "HELO nep.net")
	by vger.kernel.org with SMTP id <S265844AbRGSTP2>;
	Thu, 19 Jul 2001 15:15:28 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A0389FF@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Tyan Thunder K7 & 2 1.2Ghz Athlon MPs
Date: Thu, 19 Jul 2001 15:24:09 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ok,

I am fairly inept when it comes to kernel and what the messages mean, I was
wondering if someone would explain a few messages to me.. I just compiled
the 2.4.6 kernel on a new computer with the Tyan Thunder K7 and 2 1.2Ghz AMD
Athlon MP CPUs, I have 1 GB of DDRAM in this computer.. I also am trying out
a Adaptec 2400A IDE Raid Card...  

I get the following messages, I will paste dmesg.log at the bottom if you
want to see it..
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs

>From what i gather that message can just be ignored, it stems from bios
vendors not following specs, and Linux is just making corrections.. Am I
right?

agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Unsupported AMD chipset (device id: 700c), you might want to try
agp_try_unsupported=1.
agpgart: no supported devices found.

Ok, I understand the AMD chipset on this board is new, my question here is,
how do I turn on agp_try_unsupported..  Patch the kernel?


Thanks for the help.

Ryan 


Dmesg.log

Linux version 2.4.6 (root@PostgreSQL) (gcc version 2.96 20000731 (Red Hat
Linux 7.1 2.96-85)) #2 SMP Thu Jul 19 12:37:40 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e5400 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f7780
hm, page 000f7000 reserved twice.
hm, page 000f8000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 16
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    Bootup CPU
Processor #0 Pentium(tm) Pro APIC version 16
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is PCI   
Bus #3 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 1, trig 1, bus 3, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 1, trig 1, bus 3, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 1, trig 1, bus 3, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 1, trig 1, bus 3, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 1, trig 1, bus 3, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 1, trig 1, bus 3, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 1, trig 1, bus 3, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 1, trig 1, bus 3, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 3, trig 3, bus 3, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 3, trig 3, bus 3, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 1, trig 1, bus 3, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 3, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 3, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 3, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 1, trig 1, bus 3, IRQ 10, APIC ID 2, APIC INT 10
Int: type 0, pol 1, trig 1, bus 3, IRQ 11, APIC ID 2, APIC INT 11
Int: type 0, pol 1, trig 1, bus 3, IRQ 12, APIC ID 2, APIC INT 12
Int: type 0, pol 1, trig 1, bus 3, IRQ 13, APIC ID 2, APIC INT 13
Int: type 0, pol 1, trig 1, bus 3, IRQ 14, APIC ID 2, APIC INT 14
Int: type 0, pol 1, trig 1, bus 3, IRQ 15, APIC ID 2, APIC INT 15
Int: type 0, pol 1, trig 1, bus 3, IRQ 16, APIC ID 2, APIC INT 16
Int: type 0, pol 1, trig 1, bus 3, IRQ 17, APIC ID 2, APIC INT 17
Lint: type 3, pol 1, trig 1, bus 3, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 1, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=Server ro root=309
BOOT_FILE=/boot/bzImage
Initializing CPU#0
Detected 1194.693 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2385.51 BogoMIPS
Memory: 1028472k/1048576k available (1214k kernel code, 19712k reserved,
477k data, 208k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
CPU0: AMD Athlon(tm) Processor stepping 01
per-CPU timeslice cutoff: 731.41 usecs.
Getting VERSION: 40010
Getting VERSION: 40010
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
Calibrating delay loop... 2385.51 BogoMIPS
Stack at about c2119fb8
CPU: Before vendor init, caps: 0183fbff c1c7fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After generic, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c7fbff 00000000 00000000
OK.
CPU1: AMD Athlon(tm) Processor stepping 01
CPU has booted.
Before bogomips.
Total of 2 processors activated (4771.02 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
..TIMER: vector=31 pin1=2 pin2=0
number of MP IRQ sources: 24.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
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
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  0    0    0   0   0    1    1    A9
 11 003 03  0    0    0   0   0    1    1    B1
 12 003 03  0    0    0   0   0    1    1    B9
 13 003 03  0    0    0   0   0    1    1    C1
 14 003 03  0    0    0   0   0    1    1    C9
 15 003 03  0    0    0   0   0    1    1    D1
 16 003 03  0    0    0   0   0    1    1    D9
 17 003 03  0    0    0   0   0    1    1    E1
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
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
IRQ20 -> 20
IRQ21 -> 21
IRQ22 -> 22
IRQ23 -> 23
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 1194.7246 MHz.
..... host bus clock speed is 265.4936 MHz.
cpu: 0, clocks: 2654936, slice: 884978
CPU0<T0:2654928,T1:1769936,D:14,S:884978,C:2654936>
cpu: 1, clocks: 2654936, slice: 884978
CPU1<T0:2654928,T1:884960,D:12,S:884978,C:2654936>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
querying PCI -> IRQ mapping bus:0, slot:8, pin:0.
querying PCI -> IRQ mapping bus:0, slot:15, pin:0.
querying PCI -> IRQ mapping bus:0, slot:16, pin:0.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
parport0: PC-style at 0x378 [PCSPP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 2100 Series
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
block: queued sectors max/low 683426kB/552354kB, 2048 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022, DID=7411
PCI_IDE: chipset revision 1
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/63
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 0 at 65.
i2o: PCI I2O controller at 0xF6000000 size=33554432
I2O: MTRR workaround for Intel i960 processor
i2o/iop0: Installed at IRQ10
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: LCT has 18 entries.
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others.
http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:0f.0: 3Com PCI 3c980 Cyclone at 0x1400,  00:e0:81:03:29:57, IRQ 11
  product code 0000 rev 00.3 date 00-00-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
00:0f.0: scatter/gather disabled. h/w checksums enabled
00:10.0: 3Com PCI 3c980 Cyclone at 0x1480,  00:e0:81:03:29:58, IRQ 11
  product code 0000 rev 00.3 date 00-00-00
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 7809.
  Enabling bus-master transmits and whole-frame receives.
00:10.0: scatter/gather disabled. h/w checksums enabled
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Unsupported AMD chipset (device id: 700c), you might want to try
agp_try_unsupported=1.
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
[drm:radeon_init] *ERROR* Cannot initialize agpgart module.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 265032k swap-space (priority -1)
Adding Swap: 265032k swap-space (priority -2)
Adding Swap: 265032k swap-space (priority -3)
Adding Swap: 265032k swap-space (priority -4)
