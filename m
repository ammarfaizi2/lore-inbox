Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263542AbTCUHLE>; Fri, 21 Mar 2003 02:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263543AbTCUHLE>; Fri, 21 Mar 2003 02:11:04 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:27160
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263542AbTCUHLA>; Fri, 21 Mar 2003 02:11:00 -0500
Date: Fri, 21 Mar 2003 02:18:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2 (fwd)
In-Reply-To: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303210218150.2133-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rebooted and got another one;

Bringing up interface eth0:  Unable to handle kernel NULL pointer dereference at virtual address 00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c02ea2d9>]    Not tainted
EFLAGS: 00010046 VLI
EIP is at ahc_handle_scsiint+0xcc9/0x1130
eax: 00000001   ebx: 00000001   ecx: 00000001   edx: 0000000d
esi: 000000a0   edi: cbe31290   ebp: 00000000   esp: c1509e5c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c1508000 task=c150a660)
Stack: 000000ff 41508b68 00000007 00000000 00000000 c1508000 00000001 41410000 
       00000000 00000007 00000000 c0580001 00000000 00000000 c0509041 00000001 
       00000007 00000064 cbe31290 c1509f20 00000005 c0305d14 cbe31290 00000064 
Call Trace:
 [<c0305d14>] ahc_linux_isr+0x2e4/0x3a0
 [<c010bb0d>] handle_IRQ_event+0x2d/0x50
 [<c010be49>] do_IRQ+0x109/0x210
 [<c010a398>] common_interrupt+0x18/0x20
 [<c01264f6>] do_softirq+0x56/0xc0
 [<c01168a5>] smp_apic_timer_interrupt+0xf5/0x160
 [<c0106ea0>] default_idle+0x0/0x40
 [<c010a41a>] apic_timer_interrupt+0x1a/0x20
 [<c0106ea0>] default_idle+0x0/0x40
 [<c0106ece>] default_idle+0x2e/0x40
 [<c0106f5a>] cpu_idle+0x3a/0x50
 [<c01226fd>] release_console_sem+0xbd/0x170
 [<c012256b>] printk+0x1eb/0x270

Code: ce 80 e3 ff 6a 02 6a 01 8b 44 24 1c 50 8b 44 24 30 50 0f be 44 24 2b 
50 8b 44 24 34 50 57 e8 6f af 00 00 83 c4 30  
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


-- 
function.linuxpower.ca
