Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUIWFqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUIWFqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUIWFqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:46:51 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:49618 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S262418AbUIWFqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:46:46 -0400
Message-ID: <41526341.8070902@bigpond.net.au>
Date: Thu, 23 Sep 2004 15:46:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
References: <20040922131210.6c08b94c.akpm@osdl.org> <20040923050740.GZ9106@holomorphy.com>
In-Reply-To: <20040923050740.GZ9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Sep 22, 2004 at 01:12:10PM -0700, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
>>- Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, aka
>>  the "zaphod" cpu scheduler.
>>  It has a number of tunables and lots of documentation - see the changelog
>>  entry in zaphod-scheduler.patch for details.
> 
> 
> Something's a tad off here. Should be easy enough to fix up.
> 
> 
> -- wli
> 
> Button XIR
> Software Power ON
> 4-slot Sun Enterprise 3000, No Keyboard
> OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
> Copyright 2002 Sun Microsystems, Inc.  All rights reserved
> Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.
> 
> 
> 
> {6} ok boot net:dhcp -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
> Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
> 39b200
> PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
> Linux version 2.6.9-rc2-mm2 (wli@analyticity) (gcc version 3.3.4 (Debian 1:3.3.4-12)) #2 SMP Wed Sep 22 21:53:53 PDT 2004
> ARCH: SUN4U
> Remapping the kernel... done.
> Booting Linux...
> Ethernet address: 08:00:20:89:ed:b7
> CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
> FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
> FHC(board 5): Version[1] PartID[fa0] Manuf[3e]
> FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
> FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff8000000ec00
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(0): Oops [#1]
> TSTATE: 0000000080d01603 TPC: 000000000041d7cc TNPC: 000000000041d7d0 Y: 00000000    Not tainted
> TPC: <sched_clock+0xc/0x40>
> g0: f880200000000010 g1: 00000000007b1800 g2: 0000000000000000 g3: 0000000000000030
> g4: 00000000006e5600 g5: 000000000079c018 g6: 00000000006e1600 g7: 0000000000000000
> o0: fffff80001e50ac0 o1: 0000000000100000 o2: fffff80001e50ac0 o3: 0000000000000000
> o4: 0000000000000006 o5: 0000000000000000 sp: 00000000006e4af1 ret_pc: 000000000078010c
> RPC: <__alloc_bootmem+0x2c/0x80>
> l0: 00000000006ef640 l1: 0000000000002018 l2: 0000000000001ff0 l3: 0000000000077e8c
> l4: 0000000000001f80 l5: 0000000000000000 l6: 00000000006ef400 l7: 0000000000792000
> i0: fffff80001f4a238 i1: 0000000000000000 i2: 0000000000000000 i3: 000000000000000c
> i4: fffff80001f4a238 i5: 0000000000000000 i6: 00000000006e4bb1 i7: 000000000077e530
> I7: <sched_init+0xf0/0x140>
> Caller[000000000077e530]: sched_init+0xf0/0x140
> Caller[0000000000778688]: start_kernel+0x48/0x200
> Caller[0000000000404674]: tlb_fixup_done+0x58/0x60
> Caller[0000000000000000]: 0x0
> Instruction DUMP: 9de3bf40  03001ec6  c4586148 <c658a008> 9fc0c000  01000000  03001ec6  c4586160  904a0002
> Kernel panic - not syncing: Attempted to kill the idle task!
>  <0>Press L1-A to return to the boot prom

This looks the problem of sched_clock() being called before it's ready 
(that we experienced with 2.6.9-rc2 on IA32 systems) only this time it's 
fatal :-(

A quick workaround for this would be to initialize idle->sched_timestamp 
in init_idle() and current->sched_timestamp in sched_init() to the 
INITIAL_JIFFIES converted to nanoseconds instead of using sched_clock().

Another solution would be to set them to a value much greater than the 
nanosecond equivalent of INITIAL_JIFFIES (e.g. 1ULL << 63) and let the 
code that handles the non monotonic behaviour of sched_clock() sort it 
out later.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

