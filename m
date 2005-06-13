Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFMRw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFMRw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFMRw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:52:29 -0400
Received: from jellyfish.highlyscyld.com ([216.88.134.137]:37584 "EHLO
	jellyfish.highlyscyld.com") by vger.kernel.org with ESMTP
	id S261158AbVFMRvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:51:42 -0400
Subject: RE:x86_64 Opteron dual core panics on boot
From: Andreas Junge <ajunge@penguincomputing.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Jun 2005 10:48:07 -0700
Message-Id: <1118684887.19967.12.camel@jellyfish.highlyscyld.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, we have the same kernel panic as described in Tom Duffy's message
when booting our dual (not dual core) Opteron 248's. About one in ten
boots ends up in a kernel panic.

Andreas Junge

-------------------------

Bootdata ok (command line is ro root=LABEL=/ rhgb console=ttyS0,38400n8
console=tty0 debug)
Linux version 2.6.11-1.27_FC3smp (bhcompile@crowe.devel.redhat.com) (gcc
version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 SMP Tue May 17 20:38:05
EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfffe000 (ACPI data)
 BIOS-e820: 00000000bfffe000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff700000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
ACPI: RSDP (v000 ACPIAM                                ) @
0x00000000000f7f00
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000520 MSFT 0x00000097) @
0x00000000bfff0000
ACPI: FADT (v002 A M I  OEMFACP  0x04000520 MSFT 0x00000097) @
0x00000000bfff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x04000520 MSFT 0x00000097) @
0x00000000bfff0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x04000520 MSFT 0x00000097) @
0x00000000bfffe040
ACPI: SRAT (v001 A M I  OEMSRAT  0x04000520 MSFT 0x00000097) @
0x00000000bfff4520
ACPI: DSDT (v001  TUNA_ TUNA_110 0x00000110 INTL 0x02002026) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-7fffffff
SRAT: Node 1 PXM 1 80000000-bfffffff
SRAT: Node 0 PXM 0 0-7fffffff
Bootmem setup node 0 0000000000000000-000000007fffffff
Bootmem setup node 1 0000000080000000-00000000bfffffff
On node 0 totalpages: 524287
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 520191 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 262143
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 262143 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 4000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 4000000
Built 2 zonelists
Kernel command line: ro root=LABEL=/ rhgb console=ttyS0,38400n8
console=tty0 debug
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2211.365 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3024176k/5242880k available (2317k kernel code, 0k reserved,
1224k data, 220k init)
Calibrating delay loop... 4308.99 BogoMIPS (lpj=2154496)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
CPU0: AMD Opteron(tm) Processor 248 stepping 0a
per-CPU timeslice cutoff: 1023.91 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp ffff810081447f58
Initializing CPU#1
Calibrating delay loop... <7>spurious 8259A interrupt: IRQ7.
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at timer:418
invalid operand: 0000 [1] SMP 
CPU 1 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.11-1.27_FC3smp
RIP: 0010:[<ffffffff80141c3e>] <ffffffff80141c3e>{cascade+46}
RSP: 0018:ffff810002c17ed0  EFLAGS: 00010087

