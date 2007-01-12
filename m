Return-Path: <linux-kernel-owner+w=401wt.eu-S932123AbXALPtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbXALPtk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbXALPtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:49:40 -0500
Received: from 216-54-166-2.static.twtelecom.net ([216.54.166.2]:14657 "EHLO
	mx2.compro.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932123AbXALPtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:49:39 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 10:49:39 EST
X-IronPort-AV: i="4.13,178,1167627600"; 
   d="scan'208"; a="296954:sNHT27416160"
Message-ID: <45A7ABB8.2030808@compro.net>
Date: Fri, 12 Jan 2007 10:39:36 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.17 - weird, boot CPU (#0) not listed by the BIOS.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan S4881 Thunder K8QW 4 processor (8 cores). Kernel 2.6.16.37 boots
and runs fine.
However kernel 2.6.17 and up doesn't. Here is my boot error msg.


kernel /vmlinuz-2.6.17-smp  root=/dev/sda5inux version 2.6.17-smp (root@badboy1)
(gcc version 4.1.0 (SUSE Linux)) #1 SMP PREEMPT Fri Jan 12 07:53:35 EST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000093800 (usable)
 BIOS-e820: 0000000000093800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfea0000 (usable)
 BIOS-e820: 00000000cfea0000 - 00000000cfea4000 (ACPI data)
 BIOS-e820: 00000000cfea4000 - 00000000cff00000 (ACPI NVS)
 BIOS-e820: 00000000cff00000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f71f0
DMI present.
ACPI: PM-Timer IO Port: 0x8008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x10] enabled)
Processor #16 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x11] enabled)
Processor #17 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x12] enabled)
Processor #18 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x13] enabled)
Processor #19 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x14] enabled)
Processor #20 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x15] enabled)
Processor #21 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x16] enabled)
Processor #22 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x17] enabled)
Processor #23 15:1 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x01] address[0xda200000] gsi_base[24])
IOAPIC[1]: apic_id 1, version 17, address 0xda200000, GSI 24-27
ACPI: IOAPIC (id[0x02] address[0xda201000] gsi_base[28])
IOAPIC[2]: apic_id 2, version 17, address 0xda201000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at d1000000 (gap: d0000000:10000000)
Built 1 zonelists
Kernel command line: root=/dev/sda5 vga=normal resume=/dev/sda2  splash=silent
"console=ttyS0,19200"
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2411.454 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3366304k/4194304k available (1529k kernel code, 38968k reserved, 633k
data, 184k init, 2488960k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4827.61 BogoMIPS (lpj=9655232)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Core 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI Warning (nsload-0106): Zero-length AML block in table [SSDT] [20060127]
CPU0: AMD Athlon(tm) or Opteron(tm) CPU-model unknown stepping 02
weird, boot CPU (#0) not listed by the BIOS.

It then just reboots. Any ideas what I need to do for 2.6.17 and up kernels. I
have tried all the
way up to 2.6.20-rc4.

Thanks
Mark
