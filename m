Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbSLEUtJ>; Thu, 5 Dec 2002 15:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbSLEUtJ>; Thu, 5 Dec 2002 15:49:09 -0500
Received: from mail.ifip.com ([63.113.106.66]:64225 "EHLO mail.ifip.com")
	by vger.kernel.org with ESMTP id <S267417AbSLEUs7>;
	Thu, 5 Dec 2002 15:48:59 -0500
Message-ID: <3DEFBEB7.9080500@markerman.com>
Date: Thu, 05 Dec 2002 16:01:43 -0500
From: Byron Albert <byron@markerman.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: host buss on p4 xeon 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I am testing some new dual 2.4/2.8ghz Xeon DP boxes. They all have the 
ServerWorks GC -LE Chipset. I was looking at the dmesg out put and it 
says that the host buss is 100mhz but I in all the docs about the mother 
board it says it should 400. Is this some other number or is there some 
patches I need to get the faster bus speeds?

Thanks
Byron

..... CPU clock speed is 2394.9664 MHz.
..... host bus clock speed is 99.7902 MHz.


Linux version 2.4.19 (root@fkwww-new.iworld.com) (gcc version 2.96 
20000731 (Red Hat Linux 7.1 2.96-98)) #12 SMP Sun Nov 17 23:35:55 EST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
 BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000efffac40 (usable)
 BIOS-e820: 00000000efffac40 - 00000000f0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000110000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009c940
hm, page 0009c000 reserved twice.
hm, page 0009d000 reserved twice.
hm, page 0009c000 reserved twice.
hm, page 0009d000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE, contact 
linux-smp@vger.kernel.org if you experience SMP problems!
On node 0 totalpages: 1048576
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 819200 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00fdfc0
RSD PTR  v0 [IBM   ]
__va_range(0xefffff80, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [IBM    SERONYXP 0.4096]
__va_range(0xefffff00, 0x24): idx=8 mapped at ffff6000
__va_range(0xefffff00, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [IBM    SERONYXP 0.4096]
__va_range(0xeffffe40, 0x24): idx=8 mapped at ffff6000
__va_range(0xeffffe40, 0x92): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [IBM    SERONYXP 0.4096]
__va_range(0xeffffe40, 0x92): idx=8 mapped at ffff6000
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0001] id[0x6] enabled[1])
CPU 1 (0x0600) enabledProcessor #6 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0002] id[0x1] enabled[1])
CPU 2 (0x0100) enabledProcessor #1 Unknown CPU [15:2] APIC version 16

LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
CPU 3 (0x0700) enabledProcessor #7 Unknown CPU [15:2] APIC version 16

IOAPIC (id[0xe] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0xd] address[0xfec01000] global_irq_base[0x10])
IOAPIC (id[0xc] address[0xfec02000] global_irq_base[0x20])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
LAPIC_NMI (acpi_id[0x0000] polarity[0x0] trigger[0x0] lint[0x1])
LAPIC_NMI (acpi_id[0x0006] polarity[0x0] trigger[0x0] lint[0x1])
LAPIC_NMI (acpi_id[0x0001] polarity[0x0] trigger[0x0] lint[0x1])
LAPIC_NMI (acpi_id[0x0007] polarity[0x0] trigger[0x0] lint[0x1])
4 CPUs total
Local APIC address fee00000
__va_range(0xeffffd80, 0x24): idx=8 mapped at ffff6000
__va_range(0xeffffd80, 0x4b): idx=8 mapped at ffff6000
ACPI table found: ASF! v16 [IBM    SERONYXP 0.1]
ACPI: Unsupported table ASF!
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM ENSW Product ID: GEODE SMP    APIC at: 0xFEE00000
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
I/O APIC #12 Version 17 at 0xFEC02000.
Processors: 4
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: auto BOOT_IMAGE=linux ro root=803 
BOOT_FILE=/boot/vmlinuz-2.4.19
Initializing CPU#0
Detected 2394.810 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4771.02 BogoMIPS
Memory: 3879816k/4194304k available (1425k kernel code, 51920k reserved, 
372k data, 276k init, 3014632k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
per-CPU timeslice cutoff: 1462.92 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Booting processor 2/6 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU2: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Booting processor 3/7 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4784.12 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU3: Intel(R) XEON(TM) CPU 2.40GHz stepping 04
Total of 4 processors activated (19123.40 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 14 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 14 ... ok.
Setting 13 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 13 ... ok.
Setting 12 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 12 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 14-3, 14-4, 14-5, 14-7, 14-9, 14-10, 13-0, 
13-1, 13-3, 13-5, 13-6, 13-7, 13-8, 13-9, 13-11, 13-12, 13-15, 12-0, 
12-1, 12-2, 12-3, 12-4, 12-5, 12-6, 12-7, 12-8, 12-9, 12-10, 12-11, 
12-12, 12-13, 12-14, 12-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
number of MP IRQ sources: 14.
number of IO-APIC #14 registers: 16.
number of IO-APIC #13 registers: 16.
number of IO-APIC #12 registers: 16.
testing the IO APIC.......................

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0E000000
.......     : arbitration: 0E
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 00F 0F  0    0    0   0   0    1    1    39
 02 00F 0F  0    0    0   0   0    1    1    31
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 00F 0F  0    0    0   0   0    1    1    41
 07 000 00  1    0    0   0   0    0    0    00
 08 00F 0F  0    0    0   0   0    1    1    49
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 00F 0F  1    1    0   1   0    1    1    51
 0c 00F 0F  0    0    0   0   0    1    1    59
 0d 00F 0F  0    0    0   0   0    1    1    61
 0e 00F 0F  0    0    0   0   0    1    1    69
 0f 00F 0F  0    0    0   0   0    1    1    71

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0D000000
.......     : arbitration: 0D
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 00F 0F  1    1    0   1   0    1    1    79
 03 000 00  1    0    0   0   0    0    0    00
 04 00F 0F  1    1    0   1   0    1    1    81
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 00F 0F  1    1    0   1   0    1    1    89
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 00F 0F  1    1    0   1   0    1    1    91
 0e 00F 0F  1    1    0   1   0    1    1    99
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #12......
.... register #00: 0C000000
.......    : physical APIC id: 0C
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ6 -> 0:6
IRQ8 -> 0:8
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ18 -> 1:2
IRQ20 -> 1:4
IRQ26 -> 1:10
IRQ29 -> 1:13
IRQ30 -> 1:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2394.9664 MHz.
..... host bus clock speed is 99.7902 MHz.
cpu: 0, clocks: 997902, slice: 199580
CPU0<T0:997888,T1:798304,D:4,S:199580,C:997902>
cpu: 1, clocks: 997902, slice: 199580
cpu: 2, clocks: 997902, slice: 199580
cpu: 3, clocks: 997902, slice: 199580
CPU1<T0:997888,T1:598720,D:8,S:199580,C:997902>
CPU2<T0:997888,T1:399136,D:12,S:199580,C:997902>
CPU3<T0:997888,T1:199568,D:0,S:199580,C:997902>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd7ec, last bus=8
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 02
PCI: Discovered peer bus 06
PCI: Discovered peer bus 08
PCI->APIC IRQ transform: (B0,I6,P0) -> 26
PCI->APIC IRQ transform: (B0,I15,P0) -> 11
PCI->APIC IRQ transform: (B2,I3,P0) -> 20
PCI->APIC IRQ transform: (B6,I8,P0) -> 29
PCI->APIC IRQ transform: (B6,I8,P1) -> 30
PCI->APIC IRQ transform: (B8,I2,P0) -> 18
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
ServerWorks CSB5: chipset revision 147
ServerWorks CSB5: not 100% native mode: will probe irqs later
ServerWorks CSB5: simplex device:  DMA disabled
ide0: ServerWorks CSB5 Bus-Master DMA disabled (BIOS)
ServerWorks CSB5: simplex device:  DMA disabled
ide1: ServerWorks CSB5 Bus-Master DMA disabled (BIOS)
hda: LG CD-ROM CRN-8245B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Compaq SMART2 Driver (v 2.4.21)
Compaq CISS Driver (v 2.4.5)
Intel(R) PRO/1000 Network Driver - version 4.3.2-k1
Copyright (c) 1999-2002 Intel Corporation.
PCI: Setting latency timer of device 06:08.0 to 64
eth0: Intel(R) PRO/1000 Network Connection
PCI: Setting latency timer of device 06:08.1 to 64
eth1: Intel(R) PRO/1000 Network Connection
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
PCI: Setting latency timer of device 02:03.0 to 64
eth2: OEM i82557/i82558 10/100 Ethernet, 00:50:8B:B1:B4:F8, IRQ 20.
  Board assembly 726837-017, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
SCSI subsystem driver Revision: 1.00
scsi0 : IBM PCI ServeRAID 5.10.21
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: SERVERAID         Rev: 1.00
  Type:   Processor                          ANSI SCSI revision: 02
  Vendor: IBM       Model: 32P0032a S320  1  Rev: 1  
  Type:   Processor                          ANSI SCSI revision: 02
megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
megaraid: no BIOS enabled.
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
SCSI device sda: 35547136 512-byte hdwr sectors (18200 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 35547136 512-byte hdwr sectors (18200 MB)
 sdb: sdb1
SCSI device sdc: 35547136 512-byte hdwr sectors (18200 MB)
 sdc: sdc1
SCSI device sdd: 35547136 512-byte hdwr sectors (18200 MB)
 sdd: sdd1
SCSI device sde: 71094272 512-byte hdwr sectors (36400 MB)
 sde: sde1
Fusion MPT base driver 2.00.11
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: 0 MPT adapters found, 0 installed.
Fusion MPT SCSI Host driver 2.00.11
Fusion MPT LAN driver 2.00.11
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack (8192 buckets, 65536 max)
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 276k freed
Adding Swap: 2096252k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on sd(8,3), internal journal
reiserfs: checking transaction log (device 08:11) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:21) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:31) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 08:41) ...
Using r5 hash to sort names
ReiserFS version 3.6.25

