Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132476AbRBRNGz>; Sun, 18 Feb 2001 08:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132361AbRBRNGq>; Sun, 18 Feb 2001 08:06:46 -0500
Received: from pop.gmx.net ([194.221.183.20]:33219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132627AbRBRNG3>;
	Sun, 18 Feb 2001 08:06:29 -0500
Date: Sun, 18 Feb 2001 13:24:17 +0100
From: Hendrik Volker Brunn <hvb@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: sym53c875 - Tekram DC390 F read problems
Message-ID: <20010218132417.E195@gmx.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


sym53c875-0:0: ERROR (0:18) (1-21-4d) (f/3d) @ (script 820:11000000).
sym53c875-0: script cmd = 11000000
sym53c875-0: regdump: da 10 c0 3d 47 0f 00 07 46 01 80 21 80 01 01 00 00 80 d1 0f 08 ff ff ff.
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<1,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)

dmesg output is attached.
kernel 2.4.1

Hendrik

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl
## Linux 2.4.1-ac14 running on an i586 ##

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

 @ 000000000fff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
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
    Bootup CPU
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
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 20, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 10
Int: type 2, pol 3, trig 1, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=2.4.1 ro root=802 video=matrox:vesa:0x118,vf:85
Initializing CPU#0
Detected 266.680 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 532.48 BogoMIPS
Memory: 254652k/262080k available (1447k kernel code, 7040k reserved, 506k data, 248k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
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
per-CPU timeslice cutoff: 1464.17 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
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
CPU#1 (phys ID: 1) waiting for CALLOUT
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
Calibrating delay loop... 532.48 BogoMIPS
Stack at about c1449fbc
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
Total of 2 processors activated (1064.96 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 22.
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
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    91
 0f 003 03  0    0    0   0   0    1    1    99
 10 003 03  1    1    0   1   0    1    1    A1
 11 003 03  1    1    0   1   0    1    1    A9
 12 003 03  1    1    0   1   0    1    1    B1
 13 003 03  1    1    0   1   0    1    1    B9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
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
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 266.6706 MHz.
..... host bus clock speed is 66.6673 MHz.
cpu: 0, clocks: 666673, slice: 222224
CPU0<T0:666672,T1:444448,D:0,S:222224,C:666673>
cpu: 1, clocks: 666673, slice: 222224
CPU1<T0:666672,T1:222224,D:0,S:222224,C:666673>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfaff0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE32 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.1 present.
30 structures occupying 845 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 10/30/98
Board Vendor: Gigabyte Technology Co. Ltd..
Board Name: i440BX-W977.
Board Version:  .
Starting kswapd v1.8
0x278: FIFO is 16 bytes
0x278: writeIntrThreshold is 16
0x278: readIntrThreshold is 16
0x278: PWord is 8 bits
0x278: Interrupts are ISA-Pulses
0x278: ECP port cfgA=0x10 cfgB=0x78
0x278: ECP settings irq=5 dma=<none or set by other means>
parport0: PC-style at 0x278 (0x678) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 5 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Xerox DocuPrint
matroxfb: Matrox Millennium II (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 1024x768x32bpp (virtual: 1024x1024)
matroxfb: framebuffer at 0xE4000000, mapped to 0xd0805000, size 4194304
Console: switching to colour frame buffer device 128x48
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169053kB/56351kB, 512 slots per queue
loop: enabling 8 loop devices
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
8139too Fast Ethernet driver 0.9.13 loaded
eth0: RealTek RTL8139 Fast Ethernet at 0xd0c06000, 00:e0:7d:93:52:36, IRQ 19
eth0:  Identified 8139 chip type 'RTL-8139C'
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 9, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x3 on pci bus 0 device 9 function 0 irq 17
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-0: on-chip RAM at 0xe9000000
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
  Vendor: COMPAQ    Model: 4691SS            Rev: T171
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MICROP    Model: 3391WS            Rev: X501
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-0-<0,0>: tagged command queue depth set to 4
sym53c875-0-<1,0>: tagged command queue depth set to 4
scsi1: WARNING: unusual hostadapter SCSI id 0; please verify!
scsi1 : AM53/79C974 PCscsi driver rev. 0.5; host I/O address: 0xe000; irq: 16

Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)
SCSI device sda: 17773500 512-byte hdwr sectors (9100 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<1,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)
SCSI device sdb: 17780058 512-byte hdwr sectors (9103 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1 p2
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE32 PnP detected
sb: ISAPnP reports 'Creative SB AWE32 PnP' at i/o 0x220, irq 5, dma 1, 5
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE32 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM512k)>
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 248k freed
Adding Swap: 524280k swap-space (priority -1)
reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting full-duplex based on MII #32 link partner ability of 41e1.
sym53c875-0:0: ERROR (0:18) (1-21-4d) (f/3d) @ (script 820:11000000).
sym53c875-0: script cmd = 11000000
sym53c875-0: regdump: da 10 c0 3d 47 0f 00 07 46 01 80 21 80 01 01 00 00 80 d1 0f 08 ff ff ff.
sym53c875-0: restart (scsi reset).
sym53c875-0: Downloading SCSI SCRIPTS.
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: wide msgout: 1-2-3-1.
sym53c875-0-<0,0>: wide msgin: 1-2-3-1.
sym53c875-0-<0,0>: wide: wide=1 chg=0.
sym53c875-0-<0,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<0,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<0,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: wide msgout: 1-2-3-1.
sym53c875-0-<1,0>: wide msgin: 1-2-3-1.
sym53c875-0-<1,0>: wide: wide=1 chg=0.
sym53c875-0-<1,0>: sync msgout: 1-3-1-19-10.
sym53c875-0-<1,0>: sync msg in: 1-3-1-19-f.
sym53c875-0-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-0-<1,*>: FAST-10 WIDE SCSI 20.0 MB/s (100 ns, offset 15)

--sm4nu43k4a2Rpi4c--
