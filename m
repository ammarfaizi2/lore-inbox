Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUBUVwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 16:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUBUVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 16:52:45 -0500
Received: from littlegreenmen.armory.com ([192.122.209.37]:896 "EHLO
	littlegreenmen.armory.com") by vger.kernel.org with ESMTP
	id S261622AbUBUVwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 16:52:37 -0500
Date: Sat, 21 Feb 2004 13:52:28 -0800
From: Phil White <cerise@littlegreenmen.armory.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.3 doesn't see my 2nd CPU
Message-ID: <20040221215228.GA4317@littlegreenmen.armory.com>
References: <20040221031717.GB4827@littlegreenmen.armory.com> <20040220202224.5f4394cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220202224.5f4394cf.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a BIOS upgrade.  Alas, no luck.  WIth acpi=force, I get more output,
(and recognition that a processor #1 exists), but I have the same crash in the
dmesg log and only 1 CPU is actually recognized.

-Phil/CERisE
----------------------------------------------------------------
Linux version 2.6.3-gentoo-r1 (root@littlegreenmen) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 SMP Fri Feb 20 16:54:42 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffe0000 (usable)
 BIOS-e820: 000000003ffe0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
ACPI: S3 and PAE do not like each other for now, S3 disabled.
found SMP MP-table at 000fb560
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 262112
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32736 pages, LIFO batch:7
DMI 2.1 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fb340
ACPI: RSDT (v001 OEMTYN OEMTYNTB 0x00000009 AMI  0x00000001) @ 0x3fff0000
ACPI: FADT (v001 OEMTYN OEMTYNTB 0x00000009 AMI  0x00000001) @ 0x3fff1000
ACPI: MADT (v001 OEMTYN OEMTYNTB 0x00000009 AMI  0x00000001) @ 0x3fff2000
ACPI: DSDT (v001 OEMTYN OEMTYNTB 0x00000012 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 20 high level)
ACPI BALANCE SET
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.3-g-r1 ro root=2141 acpi=force
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 801.837 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1032720k/1048448k available (2183k kernel code, 14832k reserved, 725k data, 176k init, 130944k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1585.15 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 732.15 usecs.
task migration cache decay timeout: 1 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Unable to handle kernel paging request<1>Unable to handle kernel paging request at virtual address 3f83ec0d
 printing eip:
3f83ec0d
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<3f83ec0d>]    Not tainted
EFLAGS: 00010082
EIP is at 0x3f83ec0d
eax: c1b3c000   ebx: 00000000   ecx: 00000001   edx: 00100100
esi: 00000000   edi: 00000026   ebp: 00000000   esp: c8008204
ds: 007b   es: 007b   ss: 0068
Process  (pid: 0, threadinfo=c8008000 task=3000801c)
Stack: c027abeb c1b3c000 00000002 c03a0b80 c027e74b 00000000 00000000 00000000 
       00000000 00000000 00000000 00000000 c03a0b80 00000026 00000efb 00000001 
       c012616f c03a0b80 c040c79b 00000026 00000f21 00000f21 00000efb c012627f 
Call Trace:
 [<c027abeb>] hide_cursor+0x2b/0x50
 [<c027e74b>] vt_console_print+0x32b/0x350
 [<c012616f>] __call_console_drivers+0x5f/0x70
 [<c012627f>] call_console_drivers+0x6f/0x130
 [<c0126632>] release_console_sem+0x62/0xf0
 [<c0126532>] printk+0x182/0x1d0
 [<c011d144>] do_page_fault+0x154/0x53a
 [<c011cff0>] do_page_fault+0x0/0x53a
 [<c010a1dd>] error_code+0x2d/0x38

Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 Stuck ??
CPU #1 not responding - cannot use it.
Total of 1 processors activated (1585.15 BogoMIPS).
------------------------------------------------------
On Fri, Feb 20, 2004 at 08:22:24PM -0800, Andrew Morton wrote:
> Phil White <cerise@littlegreenmen.armory.com> wrote:
> >
> > ACPI disabled because your bios is from 99 and too old
> >  You can enable it with acpi=force
> 
> Did you try acpi=force?  Look for a bios upgrade, too.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
