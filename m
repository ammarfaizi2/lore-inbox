Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTAUUqv>; Tue, 21 Jan 2003 15:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTAUUqv>; Tue, 21 Jan 2003 15:46:51 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:15370 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S267221AbTAUUqp>;
	Tue, 21 Jan 2003 15:46:45 -0500
Message-ID: <3E2DB36F.1000804@walrond.org>
Date: Tue, 21 Jan 2003 20:54:07 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: Andy Grover <agrover@groveronline.com>, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
Subject: Re: [PATCH] SMP parsing rewrite, phase 1
References: <Pine.LNX.4.44.0301201834310.26042-100000@dexter.groveronline.com> <3E2DAE2F.1070503@walrond.org>
Content-Type: multipart/mixed;
 boundary="------------070606010909010907030004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070606010909010907030004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

In case it's useful, lots of weird stuff happens when I boot with 
pci=noacpi (see attachment),none of which results in a successful boot :(

I particularly liked this bit...

PCI: Probing PCI hardware
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 12
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 18!

;)

--------------070606010909010907030004
Content-Type: text/plain;
 name="minicom.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="minicom.cap"

Linux version 2.5.59 (root@r2d2.office) (gcc version 3.2) #2 SMP Tue Jan 21 17:30:26 GMT 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfffa000 (usable)
 BIOS-e820: 00000000bfffa000 - 00000000bffff000 (ACPI data)
 BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 819200 pages, LIFO batch:16
found SMP MP-table at 000f0490
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
ACPI: RSDP (v000 ASUS                       ) @ 0x000f4ff0
ACPI: RSDT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa000
ACPI: FADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa145
ACPI: BOOT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa034
ACPI: SPCR (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa05c
ACPI: MADT (v001 ASUS   PR-DLS   16944.11825) @ 0xbfffa0a9
ACPI: DSDT (v001   ASUS PR-DLS   00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
ACPI: IOAPIC (id[0x03] address[0xfec01000] global_irq_base[0x10])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfec01000, IRQ 16-31
ACPI: IOAPIC (id[0x04] address[0xfec02000] global_irq_base[0x20])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfec02000, IRQ 32-47
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: ro root=/dev/nfs ip=dhcp console=tty0 console=ttyS0,115200n8 init=/boot.sh pci=noacpi 
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2591.566 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 5111.80 BogoMIPS
Memory: 3100432k/4194304k available (1692k kernel code, 44152k reserved, 453k data, 312k init, 2228200k highmem)
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Machine check exception polling timer started.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
per-CPU timeslice cutoff: 1462.69 usecs.
task migration cache decay timeout: 2 msecs.
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
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.60GHz stepping 07
Total of 2 processors activated (10289.15 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2591.0225 MHz.
..... host bus clock speed is 99.0662 MHz.
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
PCI: PCI BIOS revision 2.10 entry at 0xf1510, last bus=22
PCI: Using configuration type 1
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
ACPI Namespace successfully loaded at root c038b7fc
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
pci_bind-0191 [04] acpi_pci_bind         : Device 00:00:0f.02 not present in PCI namespace
ACPI: PCI Root Bridge [PCI1] (00:00)
ACPI: PCI Root Bridge [PCI2] (00:00)
ACPI: PCI Root Bridge [PCI3] (00:00)
ACPI: PCI Root Bridge [PCI4] (00:00)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
PCI: Probing PCI hardware
PCI: Discovered peer bus 0e
PCI: Discovered peer bus 12
PCI: Discovered primary peer bus 04 [IRQ]
PCI: Discovered primary peer bus 13 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0201] at 00:0f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 14!
PCI BIOS passed nonexistent PCI bus 18!
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Enabling SEP on CPU 0
Enabling SEP on CPU 1
highmem bounce pool size: 64 pages
aio_setup: sizeof(struct page) = 40
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Processor [CPU2] (supports C1)
ACPI: Processor [CPU3] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Intel(R) PRO/100 Network Driver - version 2.1.29-k1
Copyright (c) 2002 Intel Corporation

Freeing alive device c39c3800, eth%d
e100: eth0: Intel(R) PRO/100 S Server Adapter
  Hardware receive checksums enabled

Intel(R) PRO/1000 Network Driver - version 4.4.19-k1
Copyright (c) 1999-2002 Intel Corporation.
eth1: Intel(R) PRO/1000 Network Connection
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 32768 buckets, 256Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
Sending DHCP requests .<3>e100: eth0 NIC Link is Up 100 Mbps Full duplex
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
.<6>NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out
NETDEV WATCHDOG: eth1: transmit timed out

--------------070606010909010907030004--

