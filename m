Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUIAOHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUIAOHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 10:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUIAOHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 10:07:49 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:14266 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S266703AbUIAOFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 10:05:34 -0400
Message-ID: <4135CB2E.8010204@free.fr>
Date: Wed, 01 Sep 2004 15:14:22 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: voluntary-preempt-2.6.9-rc1-bk4-Q5 : nic 3c59x unavalaible
Content-Type: multipart/mixed;
 boundary="------------070506020902070104030006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070506020902070104030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm getting the following messages with 2.6.9-rc1-bk4-Q5.
One of the NIC (eth0) is unusable (eth0 is a 3c59x card). This problem 
doesn't occur with 2.6.9-rc1-bk4.

Aug 31 22:10:38 tigre01 kernel: eth0: Setting full-duplex based on MII 
#24 link partner capability of 01e1.
Aug 31 22:11:03 tigre01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 31 22:11:03 tigre01 kernel: eth0: transmit timed out, tx_status 00 
status e601.
Aug 31 22:11:03 tigre01 kernel:   diagnostics: net 0cf2 media 8880 dma 
0000003a fifo 0000
Aug 31 22:11:03 tigre01 kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Aug 31 22:11:03 tigre01 kernel:   Flags; bus-master 1, dirty 61(13) 
current 61(13)
Aug 31 22:11:03 tigre01 kernel:   Transmit list 00000000 vs. d9992a20.
Aug 31 22:11:03 tigre01 kernel:   0: @d9992200  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   1: @d99922a0  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   2: @d9992340  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   3: @d99923e0  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   4: @d9992480  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   5: @d9992520  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   6: @d99925c0  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   7: @d9992660  length 8000002a status 
0001002a
Aug 31 22:11:03 tigre01 kernel:   8: @d9992700  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   9: @d99927a0  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   10: @d9992840  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   11: @d99928e0  length 80000062 status 
80010062
Aug 31 22:11:03 tigre01 kernel:   12: @d9992980  length 80000062 status 
80010062
Aug 31 22:11:03 tigre01 kernel:   13: @d9992a20  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   14: @d9992ac0  length 80000062 status 
00010062
Aug 31 22:11:03 tigre01 kernel:   15: @d9992b60  length 80000062 status 
00010062
Aug 31 22:11:33 tigre01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 31 22:11:33 tigre01 kernel: eth0: transmit timed out, tx_status 00 
status e601.
Aug 31 22:11:33 tigre01 kernel:   diagnostics: net 0cf2 media 8880 dma 
0000003a fifo 0000
Aug 31 22:11:33 tigre01 kernel: eth0: Interrupt posted but not delivered 
-- IRQ blocked by another device?
Aug 31 22:11:33 tigre01 kernel:   Flags; bus-master 1, dirty 77(13) 
current 77(13)
Aug 31 22:11:33 tigre01 kernel:   Transmit list 00000000 vs. d9992a20.
Aug 31 22:11:33 tigre01 kernel:   0: @d9992200  length 80000062 status 
00010062
Aug 31 22:11:33 tigre01 kernel:   1: @d99922a0  length 8000002a status 
0001002a
Aug 31 22:11:33 tigre01 kernel:   2: @d9992340  length 80000062 status 
00010062
Aug 31 22:11:33 tigre01 kernel:   3: @d99923e0  length 8000002a status 
0001002a
Aug 31 22:11:33 tigre01 kernel:   4: @d9992480  length 8000002a status 
0001002a
...

This box is : Athlon 2500+, nForce2 chipset, 2 nic (3c59x , forcedeth).

On my second box (Thinkpad T23), 2.6.9-rc1-bk4-Q5 is running perfectly. -0)

Any idea? (see attached logs)

Thanks,
Remi





--------------070506020902070104030006
Content-Type: text/plain;
 name="trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trace"

Aug 31 22:04:38 tigre01 kernel: BIOS-provided physical RAM map:
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Aug 31 22:04:38 tigre01 kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Aug 31 22:04:38 tigre01 kernel: 511MB LOWMEM available.
Aug 31 22:04:38 tigre01 syslog: klogd startup succeeded
Aug 31 22:04:38 tigre01 irqbalance: irqbalance startup succeeded
Aug 31 22:04:38 tigre01 kernel: DMI 2.2 present.
Aug 31 22:04:38 tigre01 kernel: ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f75c0
Aug 31 22:04:38 tigre01 kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Aug 31 22:04:38 tigre01 kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Aug 31 22:04:38 tigre01 kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff74c0
Aug 31 22:04:38 tigre01 kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Aug 31 22:04:38 tigre01 kernel: ACPI: PM-Timer IO Port: 0x4008
Aug 31 22:04:38 tigre01 kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Aug 31 22:04:38 tigre01 kernel: Processor #0 6:10 APIC version 16
Aug 31 22:04:38 tigre01 kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Aug 31 22:04:38 tigre01 kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Aug 31 22:04:38 tigre01 kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Aug 31 22:04:38 tigre01 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Aug 31 22:04:38 tigre01 portmap: portmap startup succeeded
Aug 31 22:04:38 tigre01 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Aug 31 22:04:38 tigre01 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
Aug 31 22:04:38 tigre01 kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Aug 31 22:04:38 tigre01 nfslock: rpc.statd startup succeeded
Aug 31 22:04:38 tigre01 rpc.statd[2071]: Version 1.0.1 Starting
Aug 31 22:04:38 tigre01 kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Aug 31 22:04:38 tigre01 kernel: Using ACPI (MADT) for SMP configuration information
Aug 31 22:04:38 tigre01 keytable: Loading keymap: 
Aug 31 22:04:38 tigre01 kernel: Built 1 zonelists
Aug 31 22:04:38 tigre01 kernel: Kernel command line: ro root=/dev/hdb1
Aug 31 22:04:38 tigre01 kernel: Initializing CPU#0
Aug 31 22:04:38 tigre01 kernel: CPU 0 irqstacks, hard=c0631000 soft=c0611000
Aug 31 22:04:38 tigre01 kernel: PID hash table entries: 2048 (order 11: 16384 bytes)
Aug 31 22:04:38 tigre01 kernel: Detected 1829.874 MHz processor.
Aug 31 22:04:38 tigre01 kernel: Using pmtmr for high-res timesource
Aug 31 22:04:38 tigre01 kernel: Console: colour VGA+ 80x25
Aug 31 22:04:38 tigre01 keytable: ^[[60G[  
Aug 31 22:04:38 tigre01 kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Aug 31 22:04:38 tigre01 keytable: 
Aug 31 22:04:38 tigre01 kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Aug 31 22:04:38 tigre01 keytable: Loading system font: 
Aug 31 22:04:38 tigre01 kernel: Memory: 508212k/524224k available (3239k kernel code, 15516k reserved, 1515k data, 408k init, 0k highmem)
Aug 31 22:04:38 tigre01 kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Aug 31 22:04:38 tigre01 keytable: ^[[60G
Aug 31 22:04:38 tigre01 kernel: Security Scaffold v1.0.0 initialized
Aug 31 22:04:38 tigre01 keytable: 
Aug 31 22:04:38 tigre01 kernel: SELinux:  Initializing.
Aug 31 22:04:38 tigre01 rc: Starting keytable:  succeeded
Aug 31 22:04:38 tigre01 kernel: SELinux:  Starting in permissive mode
Aug 31 22:04:38 tigre01 kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Aug 31 22:04:38 tigre01 kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Aug 31 22:04:38 tigre01 kernel: CPU: L2 Cache: 512K (64 bytes/line)
Aug 31 22:04:38 tigre01 random: Initializing random number generator:  succeeded
Aug 31 22:04:38 tigre01 kernel: Intel machine check architecture supported.
Aug 31 22:04:39 tigre01 kernel: Intel machine check reporting enabled on CPU#0.
Aug 31 22:04:39 tigre01 kernel: Enabling fast FPU save and restore... done.
Aug 31 22:04:39 tigre01 kernel: Enabling unmasked SIMD FPU exception support... done.
Aug 31 22:04:39 tigre01 kernel: Checking 'hlt' instruction... OK.
Aug 31 22:04:39 tigre01 kernel:  tbxface-0117 [02] acpi_load_tables      : ACPI Tables successfully acquired
Aug 31 22:04:39 tigre01 kernel: Parsing all Control Methods:....................................................................................................................................................................................................................................................................
Aug 31 22:04:39 tigre01 kernel: Table [DSDT](id F004) - 701 Objects with 75 Devices 260 Methods 27 Regions
Aug 31 22:04:39 tigre01 kernel: ACPI Namespace successfully loaded at root c06a4d1c
Aug 31 22:04:39 tigre01 udev: Creating initial udev device nodes:  succeeded
Aug 31 22:04:39 tigre01 kernel: evxfevnt-0093 [03] acpi_enable           : Transition to ACPI mode successful
Aug 31 22:04:39 tigre01 kernel: Badness in schedule at kernel/sched.c:2637
Aug 31 22:04:39 tigre01 kernel:  [<c0427b6c>] schedule+0xeec/0xf00
Aug 31 22:04:39 tigre01 kernel:  [<c01053ca>] kernel_thread+0x8a/0xa0
Aug 31 22:04:39 tigre01 kernel:  [<c0100550>] init+0x0/0x260
Aug 31 22:04:39 tigre01 kernel:  [<c0427b8b>] preempt_schedule+0xb/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c0427bcc>] preempt_schedule+0x4c/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c01004c2>] rest_init+0x82/0xb0
Aug 31 22:04:39 tigre01 kernel:  [<c05a6a2f>] start_kernel+0x18f/0x1c0
Aug 31 22:04:39 tigre01 kernel:  [<c05a6420>] unknown_bootoption+0x0/0x180
Aug 31 22:04:39 tigre01 kernel: (swapper/1): new 2609 us maximum-latency critical section.
Aug 31 22:04:39 tigre01 kernel:  => started at: <preempt_schedule+0x47/0x70>
Aug 31 22:04:39 tigre01 kernel:  => ended at:   <finish_task_switch+0x57/0xd0>
Aug 31 22:04:39 tigre01 kernel:  [<c0152407>] check_preempt_timing+0x1c7/0x230
Aug 31 22:04:39 tigre01 kernel:  [<c0120837>] finish_task_switch+0x57/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c0120837>] finish_task_switch+0x57/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c01525b4>] sub_preempt_count+0x54/0x60
Aug 31 22:04:39 tigre01 kernel:  [<c01525b4>] sub_preempt_count+0x54/0x60
Aug 31 22:04:39 tigre01 kernel:  [<c0120837>] finish_task_switch+0x57/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c01208d3>] schedule_tail+0x23/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c01076c6>] ret_from_fork+0x6/0x14
Aug 31 22:04:39 tigre01 kernel:  [<c0100550>] init+0x0/0x260
Aug 31 22:04:39 tigre01 kernel:  [<c0105334>] kernel_thread_helper+0x0/0xc
Aug 31 22:04:39 tigre01 kernel: Badness in schedule at kernel/sched.c:2637
Aug 31 22:04:39 tigre01 kernel:  [<c0427b6c>] schedule+0xeec/0xf00
Aug 31 22:04:39 tigre01 kernel:  [<c01081d4>] common_interrupt+0x18/0x20
Aug 31 22:04:39 tigre01 kernel:  [<c0427b8b>] preempt_schedule+0xb/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c0427bcc>] preempt_schedule+0x4c/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c012088e>] finish_task_switch+0xae/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c01208d3>] schedule_tail+0x23/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c01076c6>] ret_from_fork+0x6/0x14
Aug 31 22:04:39 tigre01 kernel:  [<c0100550>] init+0x0/0x260
Aug 31 22:04:39 tigre01 kernel:  [<c0105334>] kernel_thread_helper+0x0/0xc
Aug 31 22:04:39 tigre01 kernel: CPU0: AMD Athlon(tm) XP 2500+ stepping 00
Aug 31 22:04:39 tigre01 kernel: per-CPU timeslice cutoff: 1462.74 usecs.
Aug 31 22:04:39 tigre01 kernel: task migration cache decay timeout: 2 msecs.
Aug 31 22:04:39 tigre01 kernel: Total of 1 processors activated (3620.86 BogoMIPS).
Aug 31 22:04:39 tigre01 kernel: ENABLING IO-APIC IRQs
Aug 31 22:04:39 tigre01 kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Aug 31 22:04:39 tigre01 kernel: ..MP-BIOS bug: 8254 timer not connected to IO-APIC
Aug 31 22:04:39 tigre01 kernel: ...trying to set up timer (IRQ0) through the 8259A ...  failed.
Aug 31 22:04:39 tigre01 kernel: ...trying to set up timer as Virtual Wire IRQ... failed.
Aug 31 22:04:39 tigre01 kernel: ...trying to set up timer as ExtINT IRQ... works.
Aug 31 22:04:39 tigre01 kernel: (swapper/1): new 230829 us maximum-latency critical section.
Aug 31 22:04:39 tigre01 kernel:  => started at: <init+0x32/0x260>
Aug 31 22:04:39 tigre01 kernel:  => ended at:   <cond_resched+0xd/0x40>
Aug 31 22:04:39 tigre01 kernel:  [<c0152407>] check_preempt_timing+0x1c7/0x230
Aug 31 22:04:39 tigre01 kernel:  [<c042846d>] cond_resched+0xd/0x40
Aug 31 22:04:39 tigre01 kernel:  [<c042846d>] cond_resched+0xd/0x40
Aug 31 22:04:39 tigre01 kernel:  [<c01524ad>] touch_preempt_timing+0x3d/0x50
Aug 31 22:04:39 tigre01 kernel:  [<c01524ad>] touch_preempt_timing+0x3d/0x50
Aug 31 22:04:39 tigre01 kernel:  [<c042846d>] cond_resched+0xd/0x40
Aug 31 22:04:39 tigre01 kernel:  [<c015fa0f>] kmem_cache_alloc+0xaf/0xc0
Aug 31 22:04:39 tigre01 kernel:  [<c012546e>] dup_task_struct+0x2e/0x100
Aug 31 22:04:39 tigre01 kernel:  [<c026496f>] selinux_task_create+0x3f/0x50
Aug 31 22:04:39 tigre01 kernel:  [<c0126849>] copy_process+0x89/0xfa0
Aug 31 22:04:39 tigre01 kernel:  [<c013ecbe>] alloc_pidmap+0xe/0x1d0
Aug 31 22:04:39 tigre01 kernel:  [<c012776e>] do_fork+0xe/0x1c3
Aug 31 22:04:39 tigre01 kernel:  [<c01277cf>] do_fork+0x6f/0x1c3
Aug 31 22:04:39 tigre01 kernel:  [<c0133da1>] mod_timer+0x11/0x70
Aug 31 22:04:39 tigre01 kernel:  [<c0105351>] kernel_thread+0x11/0xa0
Aug 31 22:04:39 tigre01 kernel:  [<c01053ca>] kernel_thread+0x8a/0xa0
Aug 31 22:04:39 tigre01 kernel:  [<c0143500>] kthread+0x0/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c0105334>] kernel_thread_helper+0x0/0xc
Aug 31 22:04:39 tigre01 kernel:  [<c01435fc>] keventd_create_kthread+0x2c/0x60
Aug 31 22:04:39 tigre01 kernel:  [<c0143500>] kthread+0x0/0xd0
Aug 31 22:04:39 tigre01 kernel:  [<c014373a>] kthread_create+0x10a/0x160
Aug 31 22:04:39 tigre01 kernel:  [<c010aa62>] do_softirq+0x12/0x61
Aug 31 22:04:39 tigre01 kernel:  [<c01435d0>] keventd_create_kthread+0x0/0x60
Aug 31 22:04:39 tigre01 kernel:  [<c0124240>] migration_thread+0x0/0x2b0
Aug 31 22:04:39 tigre01 kernel:  [<c0124544>] migration_call+0x54/0x130
Aug 31 22:04:39 tigre01 kernel:  [<c0124240>] migration_thread+0x0/0x2b0
Aug 31 22:04:39 tigre01 kernel:  [<c05b6f80>] migration_init+0x30/0x60
Aug 31 22:04:39 tigre01 kernel:  [<c01004fd>] do_pre_smp_initcalls+0xd/0x20
Aug 31 22:04:39 tigre01 kernel:  [<c01005b7>] init+0x67/0x260
Aug 31 22:04:39 tigre01 kernel:  [<c0100550>] init+0x0/0x260
Aug 31 22:04:39 tigre01 kernel:  [<c0105339>] kernel_thread_helper+0x5/0xc
Aug 31 22:04:39 tigre01 kernel: Brought up 1 CPUs
Aug 31 22:04:39 tigre01 kernel: NET: Registered protocol family 16
Aug 31 22:04:39 tigre01 kernel: EISA bus registered
Aug 31 22:04:39 tigre01 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
Aug 31 22:04:39 tigre01 kernel: PCI: Using configuration type 1
Aug 31 22:04:39 tigre01 kernel: mtrr: v2.0 (20020519)
Aug 31 22:04:39 tigre01 kernel: ACPI: Subsystem revision 20040715
Aug 31 22:04:39 tigre01 kernel: evgpeblk-0980 [07] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs at 0000000000004020 on int 0x9
Aug 31 22:04:39 tigre01 kernel: evgpeblk-0989 [07] ev_create_gpe_block   : Found 9 Wake, Enabled 0 Runtime GPEs in this block
Aug 31 22:04:39 tigre01 kernel: evgpeblk-0980 [07] ev_create_gpe_block   : GPE 20 to 5F [_GPE] 8 regs at 00000000000044A0 on int 0x9
Aug 31 22:04:39 tigre01 kernel: evgpeblk-0989 [07] ev_create_gpe_block   : Found 0 Wake, Enabled 0 Runtime GPEs in this block
Aug 31 22:04:39 tigre01 kernel: requesting new irq thread for IRQ9...
Aug 31 22:04:39 tigre01 kernel: Completing Region/Field/Buffer/Package initialization:........................................................................
Aug 31 22:04:39 tigre01 kernel: Initialized 27/27 Regions 1/1 Fields 28/28 Buffers 16/24 Packages (710 nodes)
Aug 31 22:04:39 tigre01 kernel: Executing all Device _STA and_INI methods:..............................................................................
Aug 31 22:04:39 tigre01 kernel: 78 Devices found containing: 78 _STA, 1 _INI methods
Aug 31 22:04:39 tigre01 kernel: ACPI: Interpreter enabled
Aug 31 22:04:39 tigre01 kernel: ACPI: Using IOAPIC for interrupt routing
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Aug 31 22:04:39 tigre01 kernel: PCI: Probing PCI hardware (bus 00)
Aug 31 22:04:39 tigre01 kernel: PCI: nForce2 C1 Halt Disconnect fixup
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 11 *12 14 15)
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:39 tigre01 kernel: ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Aug 31 22:04:40 tigre01 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug 31 22:04:40 tigre01 kernel: PnPBIOS: Scanning system for PnP BIOS support...
Aug 31 22:04:40 tigre01 kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf00
Aug 31 22:04:40 tigre01 kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf30, dseg 0xf0000
Aug 31 22:04:40 tigre01 kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Aug 31 22:04:40 tigre01 kernel: SCSI subsystem initialized
Aug 31 22:04:40 tigre01 kernel: PCI: Using ACPI for IRQ routing
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 169
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 177
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 185
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 193
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 177
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 21
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 21 (level, high) -> IRQ 185
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 201
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
Aug 31 22:04:40 tigre01 kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 209
Aug 31 22:04:40 tigre01 kernel: get_random_bytes called before random driver initialization
Aug 31 22:04:40 tigre01 kernel: TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
Aug 31 22:04:37 tigre01 network: Bringing up interface eth0:  succeeded 
Aug 31 22:04:40 tigre01 kernel: Machine check exception polling timer started.
Aug 31 22:04:40 tigre01 kernel: audit: initializing netlink socket (disabled)
Aug 31 22:04:40 tigre01 kernel: audit(1093989837.807:0): initialized
Aug 31 22:04:40 tigre01 kernel: Total HugeTLB memory allocated, 0
Aug 31 22:04:40 tigre01 kernel: VFS: Disk quotas dquot_6.5.1
Aug 31 22:04:40 tigre01 kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Aug 31 22:04:40 tigre01 kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug 31 22:04:40 tigre01 kernel: SELinux:  Registering netfilter hooks
Aug 31 22:04:40 tigre01 kernel: Initializing Cryptographic API
Aug 31 22:04:40 tigre01 kernel: isapnp: Scanning for PnP cards...
Aug 31 22:04:40 tigre01 kernel: isapnp: No Plug & Play device found
Aug 31 22:04:40 tigre01 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Aug 31 22:04:40 tigre01 kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Aug 31 22:04:40 tigre01 kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
Aug 31 22:04:40 tigre01 kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug 31 22:04:40 tigre01 kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug 31 22:04:40 tigre01 kernel: parport: PnPBIOS parport detected.
Aug 31 22:04:40 tigre01 kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Aug 31 22:04:40 tigre01 kernel: requesting new irq thread for IRQ7...
Aug 31 22:04:40 tigre01 kernel: Using anticipatory io scheduler
Aug 31 22:04:40 tigre01 kernel: Floppy drive(s): fd0 is 1.44M
Aug 31 22:04:40 tigre01 kernel: requesting new irq thread for IRQ6...
Aug 31 22:04:40 tigre01 kernel: IRQ#6 thread started up.
Aug 31 22:04:40 tigre01 kernel: FDC 0 is a post-1991 82077
Aug 31 22:04:40 tigre01 kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug 31 22:04:40 tigre01 kernel: loop: loaded (max 8 devices)
Aug 31 22:04:40 tigre01 kernel: nbd: registered device at major 43
Aug 31 22:04:40 tigre01 kernel: PPP generic driver version 2.4.2
Aug 31 22:04:40 tigre01 kernel: netconsole: not configured, aborting
Aug 31 22:04:40 tigre01 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug 31 22:04:40 tigre01 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 31 22:04:40 tigre01 kernel: NFORCE2: IDE controller at PCI slot 0000:00:09.0
Aug 31 22:04:40 tigre01 kernel: NFORCE2: chipset revision 162
Aug 31 22:04:40 tigre01 kernel: NFORCE2: not 100%% native mode: will probe irqs later
Aug 31 22:04:40 tigre01 kernel: NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
Aug 31 22:04:40 tigre01 kernel: NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
Aug 31 22:04:40 tigre01 kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Aug 31 22:04:40 tigre01 kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Aug 31 22:04:40 tigre01 kernel: hda: ST330630A, ATA DISK drive
Aug 31 22:04:40 tigre01 kernel: hdb: HDS722580VLAT20, ATA DISK drive
Aug 31 22:04:40 tigre01 kernel: requesting new irq thread for IRQ14...
Aug 31 22:04:40 tigre01 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug 31 22:04:40 tigre01 kernel: hdc: Maxtor 51024U2, ATA DISK drive
Aug 31 22:04:40 tigre01 kernel: hdd: SAMSUNG CD-R/RW SW-408B, ATAPI CD/DVD-ROM drive
Aug 31 22:04:40 tigre01 kernel: requesting new irq thread for IRQ15...
Aug 31 22:04:41 tigre01 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug 31 22:04:41 tigre01 kernel: hda: max request size: 128KiB
Aug 31 22:04:41 tigre01 kernel: hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=59303/16/63, UDMA(33)
Aug 31 22:04:41 tigre01 kernel: hda: cache flushes supported
Aug 31 22:04:41 tigre01 kernel:  hda:IRQ#14 thread started up.
Aug 31 22:04:41 tigre01 kernel:  hda1 hda2 hda3 hda4 < hda5 hda6 >
Aug 31 22:04:41 tigre01 kernel: hdb: max request size: 1024KiB
Aug 31 22:04:41 tigre01 kernel: hdb: 160836480 sectors (82348 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(33)
Aug 31 22:04:41 tigre01 kernel: hdb: cache flushes supported
Aug 31 22:04:41 tigre01 kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Aug 31 22:04:41 tigre01 kernel: hdc: max request size: 128KiB
Aug 31 22:04:41 tigre01 kernel: IRQ#15 thread started up.
Aug 31 22:04:41 tigre01 kernel: hdc: 20010816 sectors (10245 MB) w/2048KiB Cache, CHS=19852/16/63, UDMA(66)
Aug 31 22:04:41 tigre01 kernel: hdc: cache flushes supported
Aug 31 22:04:41 tigre01 kernel:  hdc: hdc1
Aug 31 22:04:41 tigre01 kernel: hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Aug 31 22:04:41 tigre01 kernel: Uniform CD-ROM driver Revision: 3.20
Aug 31 22:04:41 tigre01 kernel: ide-floppy driver 0.99.newide
Aug 31 22:04:41 tigre01 kernel: mice: PS/2 mouse device common for all mice
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ12...
Aug 31 22:04:41 tigre01 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug 31 22:04:41 tigre01 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ1...
Aug 31 22:04:41 tigre01 kernel: IRQ#1 thread started up.
Aug 31 22:04:41 tigre01 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug 31 22:04:41 tigre01 kernel: EISA: Probing bus 0 at eisa0
Aug 31 22:04:41 tigre01 kernel: Cannot allocate resource for EISA slot 4
Aug 31 22:04:41 tigre01 kernel: Cannot allocate resource for EISA slot 5
Aug 31 22:04:41 tigre01 kernel: EISA: Detected 0 cards.
Aug 31 22:04:41 tigre01 kernel: oprofile: using NMI interrupt.
Aug 31 22:04:41 tigre01 kernel: NET: Registered protocol family 2
Aug 31 22:04:41 tigre01 kernel: IP: routing cache hash table of 2048 buckets, 32Kbytes
Aug 31 22:04:41 tigre01 kernel: TCP: Hash tables configured (established 16384 bind 16384)
Aug 31 22:04:41 tigre01 kernel: NET: Registered protocol family 1
Aug 31 22:04:41 tigre01 kernel: NET: Registered protocol family 17
Aug 31 22:04:41 tigre01 kernel: NET: Registered protocol family 8
Aug 31 22:04:41 tigre01 kernel: NET: Registered protocol family 20
Aug 31 22:04:41 tigre01 kernel: ACPI: (supports S0 S1 S3 S4 S4bios S5)
Aug 31 22:04:41 tigre01 kernel: ACPI wakeup devices: 
Aug 31 22:04:41 tigre01 kernel: HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: write access will be enabled during recovery.
Aug 31 22:04:41 tigre01 kernel: IRQ#7 thread started up.
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: recovery complete.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Aug 31 22:04:41 tigre01 kernel: Freeing unused kernel memory: 408k freed
Aug 31 22:04:41 tigre01 kernel: usbcore: registered new driver usbfs
Aug 31 22:04:41 tigre01 kernel: usbcore: registered new driver hub
Aug 31 22:04:41 tigre01 kernel: ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 193
Aug 31 22:04:41 tigre01 kernel: ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ193...
Aug 31 22:04:41 tigre01 kernel: ehci_hcd 0000:00:02.2: irq 193, pci mem e0815000
Aug 31 22:04:41 tigre01 kernel: ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
Aug 31 22:04:41 tigre01 kernel: ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
Aug 31 22:04:41 tigre01 kernel: usb usb1: Product: nVidia Corporation nForce2 USB Controller
Aug 31 22:04:41 tigre01 kernel: usb usb1: Manufacturer: Linux 2.6.9-rc1 ehci_hcd
Aug 31 22:04:41 tigre01 kernel: usb usb1: SerialNumber: 0000:00:02.2
Aug 31 22:04:41 tigre01 kernel: hub 1-0:1.0: USB hub found
Aug 31 22:04:41 tigre01 kernel: hub 1-0:1.0: 6 ports detected
Aug 31 22:04:41 tigre01 kernel: IRQ#193 thread started up.
Aug 31 22:04:41 tigre01 kernel: usbcore: registered new driver usbkbd
Aug 31 22:04:41 tigre01 kernel: drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug 31 22:04:41 tigre01 kernel: usbcore: registered new driver usbmouse
Aug 31 22:04:41 tigre01 kernel: drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb1, internal journal
Aug 31 22:04:41 tigre01 kernel: ACPI: PCI interrupt 0000:01:09.0[A] -> GSI 17 (level, high) -> IRQ 201
Aug 31 22:04:41 tigre01 kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Aug 31 22:04:41 tigre01 kernel: 0000:01:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xc000. Vers LK1.1.19
Aug 31 22:04:41 tigre01 kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.28.
Aug 31 22:04:41 tigre01 kernel: ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 177
Aug 31 22:04:41 tigre01 kernel: eth1: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb2, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb3, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hda1, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hda2, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hda3, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hda5, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hda6, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdc1, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb7, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb6, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: kjournald starting.  Commit interval 5 seconds
Aug 31 22:04:41 tigre01 kernel: EXT3 FS on hdb5, internal journal
Aug 31 22:04:41 tigre01 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ4...
Aug 31 22:04:41 tigre01 kernel: IRQ#4 thread started up.
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ3...
Aug 31 22:04:41 tigre01 kernel: IRQ#3 thread started up.
Aug 31 22:04:41 tigre01 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 31 22:04:41 tigre01 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 31 22:04:41 tigre01 kernel: requesting new irq thread for IRQ201...
Aug 31 22:04:41 tigre01 kernel: IRQ#201 thread started up.
Aug 31 22:04:53 tigre01 rc: Starting pcmcia:  succeeded
Aug 31 22:04:54 tigre01 netfs: Mounting other filesystems:  failed
Aug 31 22:04:54 tigre01 autofs: automount startup succeeded
Aug 31 22:04:55 tigre01 kernel: NET: Registered protocol family 10
Aug 31 22:04:55 tigre01 kernel: Disabled Privacy Extensions on device c04ff8e0(lo)
Aug 31 22:04:55 tigre01 kernel: IPv6 over IPv4 tunneling driver
Aug 31 22:04:55 tigre01 xinetd[5078]: xinetd Version 2.3.10 started with libwrap options compiled in.
Aug 31 22:04:55 tigre01 xinetd[5078]: Started working: 4 available services
Aug 31 22:04:58 tigre01 xinetd: xinetd startup succeeded
Aug 31 22:04:59 tigre01 sendmail: sendmail startup succeeded
Aug 31 22:04:59 tigre01 sendmail: sm-client startup succeeded
Aug 31 22:05:01 tigre01 spamassassin: spamd startup succeeded
Aug 31 22:05:01 tigre01 gpm: gpm startup succeeded
Aug 31 22:05:03 tigre01 httpd: httpd startup succeeded
Aug 31 22:05:04 tigre01 canna:  succeeded
Aug 31 22:05:04 tigre01 crond: crond startup succeeded
Aug 31 22:05:07 tigre01 kernel: lp0: using parport0 (interrupt-driven).
Aug 31 22:05:07 tigre01 kernel: lp0: console ready
Aug 31 22:05:08 tigre01 cups: cupsd startup succeeded
Aug 31 22:05:10 tigre01 xfs: xfs startup succeeded
Aug 31 22:05:10 tigre01 anacron: anacron startup succeeded
Aug 31 22:05:23 tigre01 login(pam_unix)[5532]: session opened for user root by LOGIN(uid=0)
Aug 31 22:05:23 tigre01  -- root[5532]: ROOT LOGIN ON tty1
Aug 31 22:10:38 tigre01 kernel: eth0: Setting full-duplex based on MII #24 link partner capability of 01e1.
Aug 31 22:11:03 tigre01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 31 22:11:03 tigre01 kernel: eth0: transmit timed out, tx_status 00 status e601.
Aug 31 22:11:03 tigre01 kernel:   diagnostics: net 0cf2 media 8880 dma 0000003a fifo 0000
Aug 31 22:11:03 tigre01 kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Aug 31 22:11:03 tigre01 kernel:   Flags; bus-master 1, dirty 61(13) current 61(13)
Aug 31 22:11:03 tigre01 kernel:   Transmit list 00000000 vs. d9992a20.
Aug 31 22:11:03 tigre01 kernel:   0: @d9992200  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   1: @d99922a0  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   2: @d9992340  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   3: @d99923e0  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   4: @d9992480  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   5: @d9992520  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   6: @d99925c0  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   7: @d9992660  length 8000002a status 0001002a
Aug 31 22:11:03 tigre01 kernel:   8: @d9992700  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   9: @d99927a0  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   10: @d9992840  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   11: @d99928e0  length 80000062 status 80010062
Aug 31 22:11:03 tigre01 kernel:   12: @d9992980  length 80000062 status 80010062
Aug 31 22:11:03 tigre01 kernel:   13: @d9992a20  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   14: @d9992ac0  length 80000062 status 00010062
Aug 31 22:11:03 tigre01 kernel:   15: @d9992b60  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 31 22:11:33 tigre01 kernel: eth0: transmit timed out, tx_status 00 status e601.
Aug 31 22:11:33 tigre01 kernel:   diagnostics: net 0cf2 media 8880 dma 0000003a fifo 0000
Aug 31 22:11:33 tigre01 kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Aug 31 22:11:33 tigre01 kernel:   Flags; bus-master 1, dirty 77(13) current 77(13)
Aug 31 22:11:33 tigre01 kernel:   Transmit list 00000000 vs. d9992a20.
Aug 31 22:11:33 tigre01 kernel:   0: @d9992200  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel:   1: @d99922a0  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   2: @d9992340  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel:   3: @d99923e0  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   4: @d9992480  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   5: @d9992520  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   6: @d99925c0  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   7: @d9992660  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   8: @d9992700  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel:   9: @d99927a0  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel:   10: @d9992840  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   11: @d99928e0  length 80000062 status 80010062
Aug 31 22:11:33 tigre01 kernel:   12: @d9992980  length 80000062 status 80010062
Aug 31 22:11:33 tigre01 kernel:   13: @d9992a20  length 8000002a status 0001002a
Aug 31 22:11:33 tigre01 kernel:   14: @d9992ac0  length 80000062 status 00010062
Aug 31 22:11:33 tigre01 kernel:   15: @d9992b60  length 8000002a status 0001002a
Aug 31 22:12:38 tigre01 kernel: NETDEV WATCHDOG: eth0: transmit timed out
Aug 31 22:12:38 tigre01 kernel: eth0: transmit timed out, tx_status 00 status e601.
Aug 31 22:12:38 tigre01 kernel:   diagnostics: net 0cf2 media 8880 dma 0000003a fifo 0000
Aug 31 22:12:38 tigre01 kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Aug 31 22:12:38 tigre01 kernel:   Flags; bus-master 1, dirty 94(14) current 94(14)
Aug 31 22:12:38 tigre01 kernel:   Transmit list 00000000 vs. d9992ac0.
Aug 31 22:12:38 tigre01 kernel:   0: @d9992200  length 8000002a status 0001002a
Aug 31 22:12:38 tigre01 kernel:   1: @d99922a0  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   2: @d9992340  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   3: @d99923e0  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   4: @d9992480  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   5: @d9992520  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   6: @d99925c0  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   7: @d9992660  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   8: @d9992700  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   9: @d99927a0  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   10: @d9992840  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   11: @d99928e0  length 80000062 status 00010062
Aug 31 22:12:38 tigre01 kernel:   12: @d9992980  length 80000062 status 80010062
Aug 31 22:12:38 tigre01 kernel:   13: @d9992a20  length 8000002a status 8001002a
Aug 31 22:12:38 tigre01 kernel:   14: @d9992ac0  length 8000002a status 0001002a
Aug 31 22:12:38 tigre01 kernel:   15: @d9992b60  length 8000002a status 0001002a
Aug 31 22:14:17 tigre01 init: Switching to runlevel: 0

--------------070506020902070104030006
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [40] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=x1
	Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01ea (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80ac
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 169
	Region 0: I/O ports at e400 [size=32]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at e4003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 185
	Region 0: Memory at e4004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc. A7N8X Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin C routed to IRQ 193
	Region 0: Memory at e4005000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2080]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (500ns min, 1250ns max)
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at d800 [size=128]
	Region 2: Memory at e4001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e2000000-e3ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 0c11
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 201
	Region 0: I/O ports at c000 [size=128]
	Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0322 (rev a1) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 80df
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


--------------070506020902070104030006--
