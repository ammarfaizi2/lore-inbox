Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132221AbRADA14>; Wed, 3 Jan 2001 19:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132263AbRADA1r>; Wed, 3 Jan 2001 19:27:47 -0500
Received: from pcow025o.blueyonder.co.uk ([195.188.53.125]:6152 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S131802AbRADA1i>;
	Wed, 3 Jan 2001 19:27:38 -0500
Message-Id: <200101040027.AAA05009@calvin.demon.co.uk>
Date: Thu, 4 Jan 2001 00:27:35 +0000
From: Barrie Spence <b.spence@ieee.org>
To: linux-kernel@vger.kernel.org
Cc: linux-smp@vger.kernel.org
Subject: 2.4.0-prerelease - "APIC error on CPU0"
X-Mailer: Sylpheed version 0.4.6 (GTK+ 1.2.8; Linux 2.2.18; i686)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The beginning of of the dmesg output is unfortunately lost. This is an Intel Nightshade mobo with dual PIII/450. It's happy under 2.2.x.

    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
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
    PAT  present.
    PSE  present.
    MMX  present.
    FXSR  present.
    XMM  present.
Bus #0 is PCI   
Bus #1 is ISA   
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 1, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 1, trig 1, bus 1, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 1, trig 1, bus 1, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 1, trig 1, bus 1, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 1, trig 1, bus 1, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 1, trig 1, bus 1, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 1, trig 1, bus 1, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 1, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 1, trig 1, bus 1, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 1, trig 1, bus 1, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 1, trig 1, bus 1, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 1, trig 1, bus 1, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 34, APIC ID 2, APIC INT 15
Int: type 0, pol 3, trig 3, bus 0, IRQ 35, APIC ID 2, APIC INT 16
Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 2, APIC INT 14
Int: type 0, pol 3, trig 3, bus 0, IRQ 40, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 4b, APIC ID 2, APIC INT 16
Lint: type 3, pol 1, trig 1, bus 1, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=2.4.0pre ro root=805 BOOT_FILE=/boot/vmlinuz-2.4.0-prerelease
Initializing CPU#0
Detected 448.882 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 894.56 BogoMIPS
Memory: 255640k/262080k available (1105k kernel code, 6048k reserved, 81k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Katmai) stepping 02
per-CPU timeslice cutoff: 1464.52 usecs.
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
Calibrating delay loop... 894.56 BogoMIPS
Stack at about c1449fbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Katmai) stepping 02
CPU has booted.
Before bogomips.
Total of 2 processors activated (1789.13 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-17, 2-18, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 18.
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
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    71
 0f 003 03  0    0    0   0   0    1    1    79
 10 003 03  1    1    0   1   0    1    1    81
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 003 03  1    1    0   1   0    1    1    89
 14 003 03  1    1    0   1   0    1    1    91
 15 003 03  1    1    0   1   0    1    1    99
 16 003 03  1    1    0   1   0    1    1    A1
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ19 -> 19
IRQ20 -> 20
IRQ21 -> 21
IRQ22 -> 22
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 448.9183 MHz.
..... host bus clock speed is 99.7595 MHz.
cpu: 0, clocks: 997595, slice: 332531
CPU0<T0:997584,T1:665040,D:13,S:332531,C:997595>
cpu: 1, clocks: 997595, slice: 332531
CPU1<T0:997584,T1:332512,D:10,S:332531,C:997595>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdaf0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0
PCI->APIC IRQ transform: (B0,I11,P0) -> 16
PCI->APIC IRQ transform: (B0,I13,P0) -> 21
PCI->APIC IRQ transform: (B0,I13,P1) -> 22
PCI->APIC IRQ transform: (B0,I15,P0) -> 20
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
PCI->APIC IRQ transform: (B0,I18,P3) -> 22
PCI: Cannot allocate resource region 4 of device 00:12.1
  got res[1000:100f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
40 structures occupying 2040 bytes.
DMI table at 0x000F0D20.
BIOS Vendor: Intel Corporation
BIOS Version: NIGHTS0.86B.0084.P12.9908131042 
BIOS Release: 08/13/99
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c876 detected 
sym53c8xx: at PCI bus 0, device 13, function 1
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c876 detected 
sym53c8xx: at PCI bus 0, device 16, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Symbios NVRAM
sym53c876-0: rev 0x37 on pci bus 0 device 13 function 1 irq 22
sym53c876-0: ID 7, Fast-20, Parity Checking
sym53c876-0: on-chip RAM at 0xfa102000
sym53c876-0: restart (scsi reset).
sym53c876-0: Downloading SCSI SCRIPTS.
sym53c876-1: rev 0x37 on pci bus 0 device 13 function 0 irq 21
sym53c876-1: ID 7, Fast-20, Parity Checking
sym53c876-1: on-chip RAM at 0xfa101000
sym53c876-1: restart (scsi reset).
sym53c876-1: Downloading SCSI SCRIPTS.
sym53c875-2: rev 0x4 on pci bus 0 device 16 function 0 irq 19
sym53c875-2: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c875-2: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/4e/80/01/00/24
sym53c875-2: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/46/80/00/08/24
sym53c875-2: on-chip RAM at 0xfa103000
sym53c875-2: resetting, command processing suspended for 2 seconds
sym53c875-2: restart (scsi reset).
sym53c875-2: enabling clock multiplier
sym53c875-2: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx - version 1.6b
scsi1 : sym53c8xx - version 1.6b
scsi2 : sym53c8xx - version 1.6b
  Vendor: SEAGATE   Model: ST34520N          Rev: 1498
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-2: command processing resumed
  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c876-0-<0,0>: tagged command queue depth set to 4
  Vendor: QUANTUM   Model: ATLAS IV 9 WLS    Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c876-1-<6,0>: tagged command queue depth set to 4
  Vendor: CONNER    Model: CFP2107S  2.14GB  Rev: 1524
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: CONNER    Model: CFP2107S  2.14GB  Rev: 2B4B
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c875-2-<0,0>: tagged command queue depth set to 4
sym53c875-2-<2,0>: tagged command queue depth set to 4
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 6, lun 0
Detected scsi disk sdc at scsi2, channel 0, id 0, lun 0
Detected scsi disk sdd at scsi2, channel 0, id 2, lun 0
sym53c876-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c876-0-<0,0>: sync msg in: 1-3-1-c-f.
sym53c876-0-<0,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c876-0-<0,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
sym53c876-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c876-0-<0,0>: sync msg in: 1-3-1-c-f.
sym53c876-0-<0,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sda: 8888924 512-byte hdwr sectors (4551 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sym53c876-1-<6,0>: wide msgout: 1-2-3-1.
sym53c876-1-<6,0>: wide msgin: 1-2-3-1.
sym53c876-1-<6,0>: wide: wide=1 chg=0.
sym53c876-1-<6,0>: wide msgout: 1-2-3-1.
sym53c876-1-<6,0>: wide msgin: 1-2-3-1.
sym53c876-1-<6,0>: wide: wide=1 chg=0.
sym53c876-1-<6,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<6,0>: sync msg in: 1-3-1-c-10.
sym53c876-1-<6,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=0.
sym53c876-1-<6,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sdb: 17942584 512-byte hdwr sectors (9187 MB)
 sdb: sdb1
sym53c875-2-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-2-<0,0>: sync msg in: 1-3-1-19-f.
sym53c875-2-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-2-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
sym53c875-2-<0,0>: sync msgout: 1-3-1-c-10.
sym53c875-2-<0,0>: sync msg in: 1-3-1-19-f.
sym53c875-2-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sdc: 4194304 512-byte hdwr sectors (2147 MB)
 sdc: sdc1
sym53c875-2-<2,0>: sync msgout: 1-3-1-c-10.
sym53c875-2-<2,0>: sync msg in: 1-3-1-19-f.
sym53c875-2-<2,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c875-2-<2,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
sym53c875-2-<2,0>: sync msgout: 1-3-1-c-10.
sym53c875-2-<2,0>: sync msg in: 1-3-1-19-f.
sym53c875-2-<2,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sdd: 4194304 512-byte hdwr sectors (2147 MB)
 sdd: sdd1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 616272k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:FC:48:49, IRQ 20.
  Board assembly 677173-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
APIC error on CPU0: 00(02)
APIC error on CPU1: 00(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU0: 02(02)
APIC error on CPU1: 02(02)


--
Barrie Spence			Sanity Clause? There is no Sanity Clause
Home: b.spence@ieee.org		Telephone +44 1506 442304
Play: barrie_spence@agilent.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
