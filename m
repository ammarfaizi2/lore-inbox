Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbTAJXoh>; Fri, 10 Jan 2003 18:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTAJXoh>; Fri, 10 Jan 2003 18:44:37 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:19475 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S266637AbTAJXo1>;
	Fri, 10 Jan 2003 18:44:27 -0500
Message-ID: <3E1F5C96.5030901@walrond.org>
Date: Fri, 10 Jan 2003 23:51:50 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: acpi-devel@sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ACPI patches updated (20030109)
References: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>
Content-Type: multipart/mixed;
 boundary="------------060604030803020205010200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060604030803020205010200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Linux 2.5 bk which includes these patches still does not discover two 
pci buses on an asus pr-dls dual P4 Xeon machine; scsi and e1000 missing.

Linux 2.4 bk works fine

I attach dmesg output from both 2.4-bk and 2.5-bk with Acpi debug 
messages enabled incase it helps. I have tried to fathom this myself, 
but no luck so far. PCI and ACPI is a lot to take in.... Any help 
apprieciated

Grover, Andrew wrote:
> Hi all,
> 
> ACPI patches based upon the 20030109 label have been released.
> http://sourceforge.net/projects/acpi . The non-Linux releases will be
> available at
> http://developer.intel.com/technology/iapc/acpi/downloads.htm , by
> tomorrow.
> 
> Regards -- Andy
> 

--------------060604030803020205010200
Content-Type: text/plain;
 name="dmesg-2.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.4"

Linux version 2.4.21-pre3 (root@r2d2.office) (gcc version 3.2) #6 SMP Fri Jan 10 23:42:43 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fffa000 (usable)
 BIOS-e820: 000000007fffa000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f0490
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 524282
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294906 pages.
ACPI: Searched entire block, no RSDP was found.
ACPI: RSDP located at physical address c00f4ff0
RSD PTR  v0 [ASUS  ]
__va_range(0x7fffa000, 0x68): idx=8 mapped at ffff6000
ACPI table found: RSDT v1 [ASUS   PR-DLS   16944.11825]
__va_range(0x7fffa145, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fffa145, 0x74): idx=8 mapped at ffff6000
ACPI table found: FACP v1 [ASUS   PR-DLS   16944.11825]
__va_range(0x7fffa034, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fffa034, 0x28): idx=8 mapped at ffff6000
ACPI table found: BOOT v1 [ASUS   PR-DLS   16944.11825]
__va_range(0x7fffa05c, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fffa05c, 0x4d): idx=8 mapped at ffff6000
ACPI table found: SPCR v1 [ASUS   PR-DLS   16944.11825]
__va_range(0x7fffa0a9, 0x24): idx=8 mapped at ffff6000
__va_range(0x7fffa0a9, 0x9c): idx=8 mapped at ffff6000
ACPI table found: APIC v1 [ASUS   PR-DLS   16944.11825]
__va_range(0x7fffa0a9, 0x9c): idx=8 mapped at ffff6000
IOAPIC (id[0x2] address[0xfec00000] global_irq_base[0x0])
IOAPIC (id[0x3] address[0xfec01000] global_irq_base[0x10])
IOAPIC (id[0x4] address[0xfec02000] global_irq_base[0x20])
INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
LAPIC_NMI (acpi_id[0x0000] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC (acpi_id[0x0000] id[0x0] enabled[1])
CPU 0 (0x0000) enabledProcessor #0 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC_NMI (acpi_id[0x0001] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC (acpi_id[0x0001] id[0x1] enabled[1])
CPU 1 (0x0100) enabledProcessor #1 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC_NMI (acpi_id[0x0002] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC (acpi_id[0x0002] id[0x6] enabled[1])
CPU 2 (0x0600) enabledProcessor #6 Pentium 4(tm) XEON(tm) APIC version 16

LAPIC_NMI (acpi_id[0x0003] polarity[0x1] trigger[0x1] lint[0x1])
LAPIC (acpi_id[0x0003] id[0x7] enabled[1])
CPU 3 (0x0700) enabledProcessor #7 Pentium 4(tm) XEON(tm) APIC version 16

4 CPUs total
Local APIC address fee00000
Enabling the CPU's according to the ACPI table
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: ASUS     Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #8 Version 17 at 0xFEC00000.
I/O APIC #9 Version 17 at 0xFEC01000.
I/O APIC #10 Version 17 at 0xFEC02000.
Enabling APIC mode: Flat.	Using 3 I/O APICs
Processors: 4
Kernel command line: ro root=/dev/nfs ip=dhcp console=tty0 console=ttyS0,115200n8 init=/boot.sh 
Initializing CPU#0
Detected 2591.727 MHz processor.
Calibrating delay loop... 5164.23 BogoMIPS
Memory: 2069488k/2097128k available (1447k kernel code, 27256k reserved, 367k data, 276k init, 1179624k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.69 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU2: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5177.34 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU:     After generic, caps: bfebfbff 00000000 00000000 00000000
CPU:             Common caps: bfebfbff 00000000 00000000 00000000
CPU3: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 4 processors activated (20696.26 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
Setting 9 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 9 ... ok.
Setting 10 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 10 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 8-0, 8-3, 8-10, 8-12, 8-14, 8-15, 9-0, 9-1, 9-4, 9-5, 9-8, 9-9, 9-10, 9-11, 9-12, 9-13, 9-14, 9-15, 10-0, 10-1, 10-2, 10-3, 10-4, 10-5, 10-6, 10-7, 10-8, 10-9, 10-10, 10-11, 10-12, 10-13, 10-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 16.
number of IO-APIC #8 registers: 16.
number of IO-APIC #9 registers: 16.
number of IO-APIC #10 registers: 16.
testing the IO APIC.......................

IO APIC #8......
.... register #00: 08000000
.......    : physical APIC id: 08
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 08000000
.......     : arbitration: 08
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 001 01  0    0    0   0   0    1    1    41
 05 001 01  0    0    0   0   0    1    1    49
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 001 01  1    1    0   1   0    1    1    71
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    79
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #9......
.... register #00: 09000000
.......    : physical APIC id: 09
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 09000000
.......     : arbitration: 09
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 001 01  1    1    0   1   0    1    1    81
 03 001 01  1    1    0   1   0    1    1    89
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  1    1    0   1   0    1    1    91
 07 001 01  1    1    0   1   0    1    1    99
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #10......
.... register #00: 0A000000
.......    : physical APIC id: 0A
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0A000000
.......     : arbitration: 0A
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
 0e 001 01  1    1    0   1   0    1    1    A1
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ11 -> 0:11
IRQ13 -> 0:13
IRQ18 -> 1:2
IRQ19 -> 1:3
IRQ22 -> 1:6
IRQ23 -> 1:7
IRQ46 -> 2:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2591.6430 MHz.
..... host bus clock speed is 99.6785 MHz.
cpu: 0, clocks: 996785, slice: 199357
CPU0<T0:996784,T1:797424,D:3,S:199357,C:996785>
cpu: 1, clocks: 996785, slice: 199357
cpu: 2, clocks: 996785, slice: 199357
cpu: 3, clocks: 996785, slice: 199357
CPU1<T0:996784,T1:598064,D:6,S:199357,C:996785>
CPU2<T0:996784,T1:398704,D:9,S:199357,C:996785>
CPU3<T0:996784,T1:199344,D:12,S:199357,C:996785>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf1510, last bus=22
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 0e [IRQ]
PCI: Discovered primary peer bus 12 [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 18
PCI->APIC IRQ transform: (B0,I3,P0) -> 46
PCI->APIC IRQ transform: (B14,I4,P0) -> 22
PCI->APIC IRQ transform: (B14,I4,P1) -> 23
PCI->APIC IRQ transform: (B18,I2,P0) -> 19
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
 tbxface-0099 [01] Acpi_load_tables      : ACPI Tables successfully loaded
Parsing Methods:..........................................................................................................................................................................................................
202 Control Methods found and parsed (643 nodes total)
ACPI Namespace successfully loaded at root c034d2a0
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [-11] Acpi_enable           : Transition to ACPI mode successful
Executing device _INI methods:..............................................................
62 Devices found: 62 _STA, 4 _INI
Completing Region and Field initialization:........
8/12 Regions, 0/0 Fields initialized (643 nodes total)
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
Processor[1]: C0 C1
Processor[2]: C0 C1
Processor[3]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 S Server Adapter
  Hardware receive checksums enabled

NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.101
IP-Config: Complete:
      device=eth1, addr=10.0.0.101, mask=255.255.0.0, gw=10.0.0.1,
     host=hal1.office, domain=office, nis-domain=(none),
     bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=/eboot/slash/hal.office
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 276k freed
Warning: unable to open an initial console.
e100: eth1 NIC Link is Up 100 Mbps Full duplex
svc: unknown version (3)

--------------060604030803020205010200
Content-Type: text/plain;
 name="dmesg-2.5.56"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.5.56"

the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
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

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 04000000
.......     : arbitration: 04
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
IRQ0 -> 0:0
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2591.0353 MHz.
..... host bus clock speed is 99.0667 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xf1510, last bus=22
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
device class cpu: adding device CPU 1
interfaces: adding device CPU 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109
 tbxface-0098 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................................................................................................................................................
Table [DSDT] - 643 Objects with 62 Devices 202 Methods 12 Regions
ACPI Namespace successfully loaded at root c039c5fc
evxfevnt-0073 [04] acpi_enable           : Transition to ACPI mode successful
   evgpe-0262: *** Info: GPE Block0 defined as GPE0 to GPE31
   evgpe-0262: *** Info: GPE Block1 defined as GPE32 to GPE63
Executing all Device _STA and_INI methods:..............................................................
62 Devices found containing: 62 _STA, 4 _INI methods
Completing Region/Field/Buffer/Package initialization:.......................................................................
Initialized 8/12 Regions 0/0 Fields 49/49 Buffers 14/14 Packages (643 nodes)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKQ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKR] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKS] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKT] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKV] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKW] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKX] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKY] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKZ] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
pci_link-0249 [07] acpi_pci_link_get_curr: Invalid use of IRQ 0
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 10 11 12 14 15, disabled)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:0f.02 not present in PCI namespace
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
ACPI: PCI Root Bridge [PCI2] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2._PRT]
ACPI: PCI Root Bridge [PCI3] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI3._PRT]
ACPI: PCI Root Bridge [PCI4] (00:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI4._PRT]
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 11 resulted in IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 11 resulted in IRQ 9
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 0
ACPI: PCI Interrupt Link [LNKI] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKJ] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKK] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKL] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKN] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKO] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKQ] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKR] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKS] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKT] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKU] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKV] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKW] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKX] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKY] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKZ] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNK2] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
pci_link-0343 [03] acpi_pci_link_set     : Attempt to enable at IRQ 5 resulted in IRQ 10
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 0
IOAPIC[2]: Set PCI routing entry (4-14 -> 0xa9 -> IRQ 46)
00:00:03[A] -> 4-14 -> IRQ 46
IOAPIC[1]: Set PCI routing entry (3-2 -> 0xb1 -> IRQ 18)
00:00:02[A] -> 3-2 -> IRQ 18
IOAPIC[1]: Set PCI routing entry (3-10 -> 0xb9 -> IRQ 26)
00:00:04[A] -> 3-10 -> IRQ 26
IOAPIC[2]: Set PCI routing entry (4-11 -> 0xc1 -> IRQ 43)
00:00:04[B] -> 4-11 -> IRQ 43
IOAPIC[2]: Set PCI routing entry (4-12 -> 0xc9 -> IRQ 44)
00:00:04[C] -> 4-12 -> IRQ 44
IOAPIC[2]: Set PCI routing entry (4-13 -> 0xd1 -> IRQ 45)
00:00:04[D] -> 4-13 -> IRQ 45
IOAPIC[1]: Set PCI routing entry (3-8 -> 0xd9 -> IRQ 24)
00:00:04[A] -> 3-8 -> IRQ 24
IOAPIC[2]: Set PCI routing entry (4-5 -> 0xe1 -> IRQ 37)
00:00:04[B] -> 4-5 -> IRQ 37
IOAPIC[2]: Set PCI routing entry (4-6 -> 0xe9 -> IRQ 38)
00:00:04[C] -> 4-6 -> IRQ 38
IOAPIC[2]: Set PCI routing entry (4-7 -> 0x32 -> IRQ 39)
00:00:04[D] -> 4-7 -> IRQ 39
IOAPIC[1]: Set PCI routing entry (3-5 -> 0x3a -> IRQ 21)
00:00:03[A] -> 3-5 -> IRQ 21
IOAPIC[2]: Set PCI routing entry (4-2 -> 0x42 -> IRQ 34)
00:00:03[B] -> 4-2 -> IRQ 34
IOAPIC[2]: Set PCI routing entry (4-3 -> 0x4a -> IRQ 35)
00:00:03[C] -> 4-3 -> IRQ 35
IOAPIC[2]: Set PCI routing entry (4-4 -> 0x52 -> IRQ 36)
00:00:03[D] -> 4-4 -> IRQ 36
IOAPIC[1]: Set PCI routing entry (3-4 -> 0x5a -> IRQ 20)
00:00:02[A] -> 3-4 -> IRQ 20
IOAPIC[1]: Set PCI routing entry (3-15 -> 0x62 -> IRQ 31)
00:00:02[B] -> 3-15 -> IRQ 31
IOAPIC[2]: Set PCI routing entry (4-0 -> 0x6a -> IRQ 32)
00:00:02[C] -> 4-0 -> IRQ 32
IOAPIC[2]: Set PCI routing entry (4-1 -> 0x72 -> IRQ 33)
00:00:02[D] -> 4-1 -> IRQ 33
IOAPIC[1]: Set PCI routing entry (3-6 -> 0x7a -> IRQ 22)
00:00:04[A] -> 3-6 -> IRQ 22
IOAPIC[1]: Set PCI routing entry (3-7 -> 0x82 -> IRQ 23)
00:00:04[B] -> 3-7 -> IRQ 23
IOAPIC[1]: Set PCI routing entry (3-9 -> 0x8a -> IRQ 25)
00:00:02[A] -> 3-9 -> IRQ 25
IOAPIC[2]: Set PCI routing entry (4-8 -> 0x92 -> IRQ 40)
00:00:02[B] -> 4-8 -> IRQ 40
Pin 3-6 already programmed
Pin 3-7 already programmed
IOAPIC[1]: Set PCI routing entry (3-3 -> 0x9a -> IRQ 19)
00:00:02[A] -> 3-3 -> IRQ 19
IOAPIC[1]: Set PCI routing entry (3-1 -> 0xa2 -> IRQ 17)
00:00:02[A] -> 3-1 -> IRQ 17
IOAPIC[1]: Set PCI routing entry (3-12 -> 0xaa -> IRQ 28)
00:00:02[B] -> 3-12 -> IRQ 28
IOAPIC[1]: Set PCI routing entry (3-13 -> 0xb2 -> IRQ 29)
00:00:02[C] -> 3-13 -> IRQ 29
IOAPIC[1]: Set PCI routing entry (3-14 -> 0xba -> IRQ 30)
00:00:02[D] -> 3-14 -> IRQ 30
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Processor [CPU3] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
device class 'tty': registering
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

e100: selftest OK.
Freeing alive device c27ef800, eth%d
e100: eth0: Intel(R) PRO/100 S Server Adapter
  Hardware receive checksums enabled

Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
device class 'input': registering
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.101
IP-Config: Complete:
      device=eth0, addr=10.0.0.101, mask=255.255.0.0, gw=10.0.0.1,
     host=hal1.office, domain=office, nis-domain=(none),
     bootserver=10.0.0.1, rootserver=10.0.0.1, rootpath=/eboot/slash/hal.office
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 312k freed
e100: eth0 NIC Link is Up 100 Mbps Full duplex

--------------060604030803020205010200--

