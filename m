Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbULFWBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbULFWBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULFWBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:01:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29355 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261671AbULFWBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:01:06 -0500
Subject: 2.6.10-rc2-mm4 panic on AMD64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, ak@suse.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Dec 2004 13:40:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I get following panic while booting 2.6.10-rc2-mm4 on my
4-way AMD64 box. Is this known or fixed ?

Thanks,
Badari

Linux version 2.6.10-rc2-mm4n (root@elm3b29) (gcc version 3.3.3 (SuSE
Linux)) #2 SMP Mon Dec 6 12:18:32 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfef0000 (usable)
 BIOS-e820: 00000000dfef0000 - 00000000dfeff000 (ACPI data)
 BIOS-e820: 00000000dfeff000 - 00000000dff00000 (ACPI NVS)
 BIOS-e820: 00000000dff00000 - 00000000e0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001e0000000 (usable)
Scanning NUMA topology in Northbridge 24
Number of nodes 4 (30030)
Node 0 MemBase 0000000000000000 Limit 000000017fffffff
Node 1 MemBase 0000000180000000 Limit 000000019fffffff
Node 2 MemBase 00000001a0000000 Limit 00000001bfffffff
Node 3 MemBase 00000001c0000000 Limit 00000001dfffffff
node 1 shift 24 addr 180000000 conflict 0
Using node hash shift of 25
Bootmem setup node 0 0000000000000000-000000017fffffff
Bootmem setup node 1 0000000180000000-000000019fffffff
Bootmem setup node 2 00000001a0000000-00000001bfffffff
Bootmem setup node 3 00000001c0000000-00000001dfffffff
No mptable found.
--- zone 0: 1000 pages
--- zone 1: ff000 pages
--- zone 2: 7ffff pages
--- zone 3: 0 pages
--- zone 0: 0 pages
--- zone 1: 0 pages
--- zone 2: 1ffff pages
--- zone 3: 0 pages
--- zone 0: 0 pages
--- zone 1: 0 pages
--- zone 2: 1ffff pages
--- zone 3: 0 pages
--- zone 0: 0 pages
--- zone 1: 0 pages
--- zone 2: 1ffff pages
--- zone 3: 0 pages
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:5 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfa400000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfa400000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfa401000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfa401000, GSI 28-31
ACPI: IOAPIC (id[0x07] address[0xfa402000] gsi_base[32])
IOAPIC[3]: apic_id 7, version 17, address 0xfa402000, GSI 32-35
ACPI: IOAPIC (id[0x08] address[0xfa404000] gsi_base[36])
IOAPIC[4]: apic_id 8, version 17, address 0xfa404000, GSI 36-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Built 4 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hda2 vga=0 splash=silent console=tty0
console=ttyS0,38400 desktop resume=/dev/hda1 showopts
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1398.204 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 7146204k/7864320k available (3046k kernel code, 0k reserved,
1866k data, 232k init)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0
Unable to handle kernel paging request at ffffffffd5a4a4fb RIP:
<ffffffff80657607>{numa_add_cpu+7}
PML4 103027 PGD 1c070d067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.10-rc2-mm4n
RIP: 0010:[<ffffffff80657607>] <ffffffff80657607>{numa_add_cpu+7}
RSP: 0018:ffffffff80645f68  EFLAGS: 00010202
RAX: 0000000055554cdf RBX: 0000000000000000 RCX: 0000000000000411
RDX: 0000000000000000 RSI: 00000000fffffbff RDI: 0000000055554cdf
RBP: 5555555555554cdf R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000000 R12: ffffffff80100150
R13: 00000000ffffffff R14: 0000ffffffff8010 R15: ffffffff80645fb0
FS:  0000000000000000(0000) GS:ffffffff8063c9c0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: ffffffffd5a4a4fb CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff80644000, task
ffffffff804ef1c0)
Stack: ffffffff8064debe 00000000000008a0 00000000000008a0
ffffffff804ef1c0
       ffffffff8064672b ffffffff805d7960 ffffffff80646268
0000000000000000
       0000000000090000 80108e0000100150
Call Trace:<ffffffff8064debe>{identify_cpu+830}
<ffffffff8064672b>{start_kernel+427}
       <ffffffff80646268>{_sinittext+616}
                                           
Code: 48 0f b6 80 1c 58 4f 80 48 c1 e0 03 f0 0f ab b8 60 b8 5d 80
RIP <ffffffff80657607>{numa_add_cpu+7} RSP <ffffffff80645f68>
CR2: ffffffffd5a4a4fb
 <0>Kernel panic - not syncing: Attempted to kill the idle task!
                                                                 



