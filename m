Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUAOXI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAOXI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:08:26 -0500
Received: from cfa.harvard.edu ([131.142.10.1]:4763 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S263584AbUAOXIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:08:12 -0500
Date: Thu, 15 Jan 2004 18:08:11 -0500 (EST)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: SMP kernel, only single processor appears (fwd)
Message-ID: <Pine.SOL.4.58.0401151807310.9382@antu.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Intel 7505VB2 dual Xeon motherboard with 2x2.66GHz CPUs, Redhat
9.0 and self-compiled 2.4.23 kernel. Interestingly, I see only one CPU
with e.g. "top", or cat /proc/cpuinfo, etc.

I have to tell though that I installed this system by cloning the disk of
another PC, which is running a single processor; then booting in the dual
processor computer from the cloned disk (with a bootfloppy), and then
recompiling the kernel (and rebooting to the new SMP enabled kernel).
Seems to me that this is not enough, and I might have missed something.

Any advice would be welcome.

Thanks
Gaspar

Jan 15 16:20:47 cfhat2 syslogd 1.4.1: restart.
Jan 15 16:20:47 cfhat2 syslog: syslogd startup succeeded
Jan 15 16:20:47 cfhat2 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Jan 15 16:20:47 cfhat2 kernel: Linux version 2.4.23-xfs-smp (root@cfhat2.cfa.harvard.edu) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #1 SMP Wed Jan 14 20:22:41 EST 2004
Jan 15 16:20:47 cfhat2 kernel: BIOS-provided physical RAM map:
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 000000007ff70000 - 000000007ff7b000 (ACPI data)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 000000007ff7b000 - 000000007ff80000 (ACPI NVS)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
Jan 15 16:20:47 cfhat2 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Jan 15 16:20:47 cfhat2 kernel: 1151MB HIGHMEM available.
Jan 15 16:20:47 cfhat2 kernel: 896MB LOWMEM available.
Jan 15 16:20:47 cfhat2 kernel: found SMP MP-table at 000f6130
Jan 15 16:20:47 cfhat2 kernel: hm, page 000f6000 reserved twice.
Jan 15 16:20:47 cfhat2 kernel: hm, page 000f7000 reserved twice.
Jan 15 16:20:47 cfhat2 kernel: hm, page 0009b000 reserved twice.
Jan 15 16:20:47 cfhat2 kernel: hm, page 0009c000 reserved twice.
Jan 15 16:20:47 cfhat2 kernel: On node 0 totalpages: 524144
Jan 15 16:20:47 cfhat2 kernel: zone(0): 4096 pages.
Jan 15 16:20:47 cfhat2 kernel: zone(1): 225280 pages.
Jan 15 16:20:47 cfhat2 kernel: zone(2): 294768 pages.
Jan 15 16:20:47 cfhat2 kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6170
Jan 15 16:20:47 cfhat2 kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7ff7701a
Jan 15 16:20:47 cfhat2 kernel: ACPI: FADT (v001 INTEL  E7505    0x06040000 PTL  0x00000008) @ 0x7ff7ae94
Jan 15 16:20:47 cfhat2 kernel: ACPI: MADT (v001 PTLTD  ^I APIC   0x06040000  LTP 0x00000000) @ 0x7ff7af08
Jan 15 16:20:47 cfhat2 kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7ff7af88
Jan 15 16:20:47 cfhat2 kernel: ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x7ff7afb0
Jan 15 16:20:47 cfhat2 kernel: ACPI: DSDT (v001  INTEL    E7505 0x06040000 MSFT 0x0100000e) @ 0x00000000
Jan 15 16:20:47 cfhat2 kernel: ACPI: Local APIC address 0xfee00000
Jan 15 16:20:47 cfhat2 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jan 15 16:20:47 cfhat2 kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Jan 15 16:20:47 cfhat2 kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Jan 15 16:20:47 cfhat2 kernel: Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
Jan 15 16:20:47 cfhat2 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Jan 15 16:20:47 cfhat2 kernel: ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Jan 15 16:20:47 cfhat2 kernel: Using ACPI for processor (LAPIC) configuration information
Jan 15 16:20:47 cfhat2 kernel: Intel MultiProcessor Specification v1.4
Jan 15 16:20:47 cfhat2 kernel:     Virtual Wire compatibility mode.
Jan 15 16:20:47 cfhat2 kernel: OEM ID:   Product ID: SE7505VB2    APIC at: 0xFEE00000
Jan 15 16:20:47 cfhat2 kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Jan 15 16:20:47 cfhat2 kernel: I/O APIC #3 Version 32 at 0xFEC80000.
Jan 15 16:20:47 cfhat2 kernel: I/O APIC #4 Version 32 at 0xFEC80400.
Jan 15 16:20:47 cfhat2 kernel: Enabling APIC mode: Flat.^IUsing 3 I/O APICs
Jan 15 16:20:47 cfhat2 kernel: Processors: 2
Jan 15 16:20:47 cfhat2 kernel: Kernel command line: auto BOOT_IMAGE=2423-xfs.4 ro BOOT_FILE=/boot/bzImage-2.4.23-xfs.4 hdc=ide-scsi root=/dev/hda5
Jan 15 16:20:47 cfhat2 kernel: ide_setup: hdc=ide-scsi
Jan 15 16:20:47 cfhat2 kernel: Initializing CPU#0
Jan 15 16:20:47 cfhat2 kernel: Detected 2657.872 MHz processor.
Jan 15 16:20:47 cfhat2 kernel: Console: colour VGA+ 80x25
Jan 15 16:20:47 cfhat2 kernel: Calibrating delay loop... 5308.41 BogoMIPS
Jan 15 16:20:47 cfhat2 kernel: Memory: 2068060k/2096576k available (2268k kernel code, 28112k reserved, 663k data, 148k init, 1179072k highmem)
Jan 15 16:20:47 cfhat2 kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Jan 15 16:20:47 cfhat2 syslog: klogd startup succeeded
Jan 15 16:20:47 cfhat2 kernel: Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jan 15 16:20:47 cfhat2 kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Jan 15 16:20:47 cfhat2 kernel: Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Jan 15 16:20:47 cfhat2 kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Jan 15 16:20:47 cfhat2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jan 15 16:20:47 cfhat2 kernel: CPU: L2 cache: 512K
Jan 15 16:20:47 cfhat2 kernel: CPU: Physical Processor ID: 0
Jan 15 16:20:47 cfhat2 kernel: Intel machine check architecture supported.
Jan 15 16:20:47 cfhat2 kernel: Intel machine check reporting enabled on CPU#0.
Jan 15 16:20:47 cfhat2 kernel: Enabling fast FPU save and restore... done.
Jan 15 16:20:47 cfhat2 kernel: Enabling unmasked SIMD FPU exception support... done.
Jan 15 16:20:47 cfhat2 kernel: Checking 'hlt' instruction... OK.
Jan 15 16:20:47 cfhat2 kernel: POSIX conformance testing by UNIFIX
Jan 15 16:20:47 cfhat2 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jan 15 16:20:47 cfhat2 kernel: CPU: L2 cache: 512K
Jan 15 16:20:47 cfhat2 kernel: CPU: Physical Processor ID: 0
Jan 15 16:20:47 cfhat2 kernel: Intel machine check reporting enabled on CPU#0.
Jan 15 16:20:47 cfhat2 kernel: CPU0: Intel(R) Xeon(TM) CPU 2.66GHz stepping 07
Jan 15 16:20:47 cfhat2 kernel: per-CPU timeslice cutoff: 1463.01 usecs.
Jan 15 16:20:47 cfhat2 kernel: enabled ExtINT on CPU#0
Jan 15 16:20:47 cfhat2 kernel: ESR value before enabling vector: 00000000
Jan 15 16:20:47 cfhat2 kernel: ESR value after enabling vector: 00000000
Jan 15 16:20:47 cfhat2 kernel: Error: only one processor found.
Jan 15 16:20:47 cfhat2 kernel: WARNING: No sibling found for CPU 0.
Jan 15 16:20:47 cfhat2 kernel: ENABLING IO-APIC IRQs
Jan 15 16:20:47 cfhat2 kernel: Setting 2 in the phys_id_present_map
Jan 15 16:20:47 cfhat2 kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Jan 15 16:20:47 cfhat2 kernel: Setting 3 in the phys_id_present_map
Jan 15 16:20:47 cfhat2 kernel: ...changing IO-APIC physical APIC ID to 3 ... ok.
Jan 15 16:20:47 cfhat2 kernel: Setting 4 in the phys_id_present_map
Jan 15 16:20:47 cfhat2 irqbalance: irqbalance startup succeeded
Jan 15 16:20:47 cfhat2 kernel: ...changing IO-APIC physical APIC ID to 4 ... ok.
Jan 15 16:20:47 cfhat2 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Jan 15 16:20:47 cfhat2 kernel: testing the IO APIC.......................
Jan 15 16:20:47 cfhat2 kernel:
Jan 15 16:20:47 cfhat2 last message repeated 2 times
Jan 15 16:20:47 cfhat2 kernel: .................................... done.
Jan 15 16:20:47 cfhat2 kernel: Using local APIC timer interrupts.
Jan 15 16:20:47 cfhat2 kernel: calibrating APIC timer ...
Jan 15 16:20:47 cfhat2 kernel: ..... CPU clock speed is 2657.8856 MHz.
Jan 15 16:20:47 cfhat2 kernel: ..... host bus clock speed is 132.8942 MHz.
Jan 15 16:20:47 cfhat2 kernel: cpu: 0, clocks: 1328942, slice: 664471
Jan 15 16:20:47 cfhat2 kernel: CPU0<T0:1328928,T1:664448,D:9,S:664471,C:1328942>
Jan 15 16:20:47 cfhat2 kernel: Waiting on wait_init_idle (map = 0x0)
Jan 15 16:20:47 cfhat2 kernel: All processors have done init_idle
Jan 15 16:20:47 cfhat2 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd8f5, last bus=5
Jan 15 16:20:47 cfhat2 kernel: PCI: Using configuration type 1
Jan 15 16:20:47 cfhat2 kernel: PCI: Probing PCI hardware
Jan 15 16:20:47 cfhat2 kernel: PCI: Probing PCI hardware (bus 00)
Jan 15 16:20:47 cfhat2 kernel: PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
Jan 15 16:20:47 cfhat2 kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
Jan 15 16:20:47 cfhat2 kernel: PCI: Using IRQ router PIIX/ICH [8086/24c0] at 00:1f.0
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B0,I29,P0) -> 16
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B0,I29,P1) -> 19
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B0,I29,P2) -> 18
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B0,I29,P3) -> 23
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B3,I2,P0) -> 28
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B4,I1,P0) -> 48
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B5,I2,P0) -> 17
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B5,I3,P0) -> 18
Jan 15 16:20:47 cfhat2 kernel: PCI->APIC IRQ transform: (B5,I4,P0) -> 19
