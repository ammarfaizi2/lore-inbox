Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUIWFHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUIWFHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUIWFHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:07:49 -0400
Received: from holomorphy.com ([207.189.100.168]:13012 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268279AbUIWFHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:07:45 -0400
Date: Wed, 22 Sep 2004 22:07:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
Message-ID: <20040923050740.GZ9106@holomorphy.com>
References: <20040922131210.6c08b94c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922131210.6c08b94c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 01:12:10PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm2/
> - Added Peter Williams' Single Priority Array (SPA) O(1) CPU Scheduler, aka
>   the "zaphod" cpu scheduler.
>   It has a number of tunables and lots of documentation - see the changelog
>   entry in zaphod-scheduler.patch for details.

Something's a tad off here. Should be easy enough to fix up.


-- wli

Button XIR
Software Power ON
4-slot Sun Enterprise 3000, No Keyboard
OpenBoot 3.2.30, 3840 MB memory installed, Serial #9039287.
Copyright 2002 Sun Microsystems, Inc.  All rights reserved
Ethernet address 8:0:20:89:ed:b7, Host ID: 8089edb7.



{6} ok boot net:dhcp -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
Boot device: /sbus@3,0/SUNW,hme@3,8c00000:dhcp  File and args: -p root=/dev/nfs nfsroot=/mnt/f/e3k/debian ip=dhcp debug initcall_debug profile=1
39b200
PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Linux version 2.6.9-rc2-mm2 (wli@analyticity) (gcc version 3.3.4 (Debian 1:3.3.4-12)) #2 SMP Wed Sep 22 21:53:53 PDT 2004
ARCH: SUN4U
Remapping the kernel... done.
Booting Linux...
Ethernet address: 08:00:20:89:ed:b7
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
FHC(board 5): Version[1] PartID[fa0] Manuf[3e]
FHC(board 7): Version[1] PartID[fa0] Manuf[3e]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e]
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8000000ec00
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000000080d01603 TPC: 000000000041d7cc TNPC: 000000000041d7d0 Y: 00000000    Not tainted
TPC: <sched_clock+0xc/0x40>
g0: f880200000000010 g1: 00000000007b1800 g2: 0000000000000000 g3: 0000000000000030
g4: 00000000006e5600 g5: 000000000079c018 g6: 00000000006e1600 g7: 0000000000000000
o0: fffff80001e50ac0 o1: 0000000000100000 o2: fffff80001e50ac0 o3: 0000000000000000
o4: 0000000000000006 o5: 0000000000000000 sp: 00000000006e4af1 ret_pc: 000000000078010c
RPC: <__alloc_bootmem+0x2c/0x80>
l0: 00000000006ef640 l1: 0000000000002018 l2: 0000000000001ff0 l3: 0000000000077e8c
l4: 0000000000001f80 l5: 0000000000000000 l6: 00000000006ef400 l7: 0000000000792000
i0: fffff80001f4a238 i1: 0000000000000000 i2: 0000000000000000 i3: 000000000000000c
i4: fffff80001f4a238 i5: 0000000000000000 i6: 00000000006e4bb1 i7: 000000000077e530
I7: <sched_init+0xf0/0x140>
Caller[000000000077e530]: sched_init+0xf0/0x140
Caller[0000000000778688]: start_kernel+0x48/0x200
Caller[0000000000404674]: tlb_fixup_done+0x58/0x60
Caller[0000000000000000]: 0x0
Instruction DUMP: 9de3bf40  03001ec6  c4586148 <c658a008> 9fc0c000  01000000  03001ec6  c4586160  904a0002
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Press L1-A to return to the boot prom
