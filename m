Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVLSCPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVLSCPU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 21:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVLSCPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 21:15:19 -0500
Received: from mtai03.charter.net ([209.225.8.183]:22527 "EHLO
	mtai03.charter.net") by vger.kernel.org with ESMTP id S1030241AbVLSCPS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 21:15:18 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Message-ID: <43A616E6.1060308@cybsft.com>
Date: Sun, 18 Dec 2005 20:11:50 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-rt2 won't boot on dual 933
References: <43A5DAE4.8090908@cybsft.com> <1134953473.13138.217.camel@localhost.localdomain> <43A60630.4070304@cybsft.com> <Pine.LNX.4.58.0512182056010.10119@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0512182056010.10119@gandalf.stny.rr.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------090707030503020908010509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090707030503020908010509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Steven Rostedt wrote:
> On Sun, 18 Dec 2005, K.R. Foley wrote:
> 
>>> KR,
>>>
>>> Does your kernel boot without CONFIG_DEBUG_PREEMPT?
>>>
>>> -- Steve
>> No. Already tried and got a different dump. Not sure if it was just a
>> dump or a dump initiated by an oops. In an hour or so I will go down and
>> capture that.
>>
> 
> In a hour or so, I will be in bed.  I'll look at it tomorrow, I have too
> much on my plate to pull an "Ingo" and stay up till (what?) 4am pumping
> out patches (Actually, I did that last night).
> 
> Way to go Ingo!  I'll take a closer look at all your stuff tomorrow.
> 
> kr, I'll look at your capture tomorrow as well.  I'll try to do what I
> can and give Ingo a break.  He deserves it.
> 
> -- Steve
> 

OK. With CONFIG_DEBUG_PREEMPT disabled I do get an oops and a dump. I
have attached the log for this one. The only difference in the config is
the CONFIG_DEBUG_PREEMPT.


-- 
   kr

--------------090707030503020908010509
Content-Type: text/plain;
 name="rc5-rt2-2.cap"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc5-rt2-2.cap"

Linux version 2.6.15-rc5-rt2 (kr@porky.cybersoft.int) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #8 SMP PREEMPT Sun Dec 18 14:49:33 CST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff9e000 (usable)
 BIOS-e820: 000000001ff9e000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000fe710
DMI 2.3 present.
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Detected 931.007 MHz processor.
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,38400 console=tty0 nmi_watchdog=1 
Initializing CPU#0
WARNING: experimental RCU implementation.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 505716k/523896k available (2257k kernel code, 17796k reserved, 913k data, 232k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1862.46 BogoMIPS (lpj=931234)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1861.67 BogoMIPS (lpj=930836)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3724.14 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Event source lapic installed with caps set: 04
checking TSC synchronization across 2 CPUs: passed.
Event source lapic installed with caps set: 04
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 452k freed
BUG: Unable to handle kernel paging request at virtual address 2007044f
 printing eip:
c0131f53
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    0
EIP:    0060:[<c0131f53>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15-rc5-rt2) 
EIP is at set_workqueue_thread_prio+0x13/0x80
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 2007035f
esi: c1d5ab80   edi: ffffffec   ebp: dff01f84   esp: dff01f6c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process swapper (pid: 1, threadinfo=dff00000 task=c1d5f7f0 stack_left=7992 worst_left=-1)
Stack: c1d5ab80 dff01f88 c0117e23 dff8d280 00000000 c1d5ab80 dff01fac c013201e 
       c1d5ab80 00000000 00000001 00000001 ffffffec dff00000 00000000 00000000 
       dff01fc4 c0132444 c1d5ab80 00000001 00000001 ffffffec dff01fcc c041cbf8 
Call Trace:
 [<c010408f>] show_stack+0x7f/0xa0 (28)
 [<c0104268>] show_registers+0x198/0x200 (56)
 [<c0104470>] die+0x100/0x190 (68)
 [<c0333b35>] do_page_fault+0x385/0x58c (96)
 [<c0103d23>] error_code+0x4f/0x54 (84)
 [<c013201e>] set_workqueue_prio+0x5e/0xd0 (40)
 [<c0132444>] init_workqueues+0x44/0x80 (24)
 [<c041cbf8>] do_basic_setup+0x8/0x30 (8)
 [<c01003ff>] init+0xbf/0x2b0 (24)
 [<c010138d>] kernel_thread_helper+0x5/0x18 (537911324)
------------------------------
| showing all locks held by: |  (swapper/1 [c1d5f7f0, 125]):
------------------------------

#001:             [c0392104] {kernel_sem.lock}
... acquired at:               __reacquire_kernel_lock+0x2e/0x70

Code: f6 74 08 89 34 24 e8 3d 3f 00 00 8b 5d f8 8b 75 fc 89 ec 5d c3 8d 76 00 55 89 e5 56 53 83 ec 10 8b 75 08 8b 45 0c 8b 16 c1 e0 08 <8b> 9c 10 f0 00 00 00 8b 45 14 89 45 f4 8b 45 18 89 1c 24 89 44 
 <0>Kernel panic - not syncing: Attempted to kill init!
 [<c01040ce>] dump_stack+0x1e/0x20 (20)
 [<c011ed9f>] panic+0x5f/0x120 (28)
 [<c01225e1>] do_exit+0x481/0x4f0 (44)
 [<c01044f4>] die+0x184/0x190 (68)
 [<c0333b35>] do_page_fault+0x385/0x58c (96)
 [<c0103d23>] error_code+0x4f/0x54 (84)
 [<c013201e>] set_workqueue_prio+0x5e/0xd0 (40)
 [<c0132444>] init_workqueues+0x44/0x80 (24)
 [<c041cbf8>] do_basic_setup+0x8/0x30 (8)
 [<c01003ff>] init+0xbf/0x2b0 (24)
 [<c010138d>] kernel_thread_helper+0x5/0x18 (537911324)
------------------------------
| showing all locks held by: |  (swapper/1 [c1d5f7f0, 125]):
------------------------------

#001:             [c0392104] {kernel_sem.lock}
... acquired at:               __reacquire_kernel_lock+0x2e/0x70

 
--------------090707030503020908010509--
