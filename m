Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTGRQxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268548AbTGRQxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:53:37 -0400
Received: from kenga.kmv.ru ([217.13.212.5]:42927 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S270248AbTGRQxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:53:20 -0400
Date: Fri, 18 Jul 2003 21:07:22 +0400
From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
To: linux-kernel@vger.kernel.org
Subject: [ACPI] 2.6.0-test1 error's
Message-ID: <20030718170722.GY7507@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-AV-Scanned: Avp!
X-Spam-Score: 10 total
X-Data-Status: msg.XXJaSopb@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux-kernel!

ACPI complian about errors on load kernel. dmesg included. 
Plz, CC to me in replies.

Linux version 2.6.0-test1 (root@BlackLife) (gcc version 3.3) #14 SMP Wed Jul 16 21:03:57 MSD 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f5d70
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 AWARD                      ) @ 0x000f7420
ACPI: RSDT (v001 AWARD  AWRDACPI 16944.11825) @ 0x1fff3000
ACPI: FADT (v001 AWARD  AWRDACPI 16944.11825) @ 0x1fff3040
ACPI: MADT (v001 AWARD           00000.00000) @ 0x1fff5140
ACPI: DSDT (v001 AWARD  AWRDACPI 00000.04096) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:3 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:3 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x1])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x0])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=linux-2.5.75 ro root=302 idebus=66 nmi_watchdog=1 panic=20 console=ttyS0,38400 console=tty0
ide_setup: idebus=66
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 300.747 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 591.87 BogoMIPS
Memory: 513580k/524224k available (2393k kernel code, 9900k reserved, 866k data, 168k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium II (Klamath) stepping 03
per-CPU timeslice cutoff: 1463.01 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 600.06 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Klamath) stepping 03
Total of 2 processors activated (1191.93 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 300.0627 MHz.
..... host bus clock speed is 100.0208 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 32
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb5f0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030619
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:..........................................................................
Table [DSDT](id F004) - 308 Objects with 26 Devices 74 Methods 20 Regions
ACPI Namespace successfully loaded at root c0472ebc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000400C on int 9
Completing Region/Field/Buffer/Package initialization:.......................  psargs-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
search_node dff388e8 start_node dff388e8 return_node 00000000
 psparse-1121: *** Error: , AE_NOT_FOUND
  nsinit-0293 [06] ns_init_one_object    : Could not execute arguments for [_PSL] (Package), AE_NOT_FOUND
.................................................
Initialized 20/20 Regions 25/25 Fields 19/19 Buffers 8/8 Packages (316 nodes)
Executing all Device _STA and_INI methods:...........................
27 Devices found containing: 27 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc200
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc228, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
Starting balanced_irq
Enabling SEP on CPU 1
Enabling SEP on CPU 0
VFS: Disk quotas dquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/W].
Limiting direct PCI/PCI transfers.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
  psargs-0352: *** Error: Looking up [\_PR_.CPU0] in namespace, AE_NOT_FOUND
search_node dff388e8 start_node dff388e8 return_node 00000000
 psparse-1121: *** Error: , AE_NOT_FOUND
acpi_thermal-0375 [15] acpi_thermal_get_trip_: Invalid passive threshold
ACPI: Thermal Zone [THRM] (1 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones

....
[skipp]

-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru

