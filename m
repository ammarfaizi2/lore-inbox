Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUJLReZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUJLReZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUJLRGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:06:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24302 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266245AbUJLQ75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:59:57 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T6
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <OFBECDA4CA.06BA3FF5-ON86256F2B.005609F8@raytheon.com>
References: <OFBECDA4CA.06BA3FF5-ON86256F2B.005609F8@raytheon.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097600394.9548.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Oct 2004 09:59:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 09:39, Mark_H_Johnson@raytheon.com wrote:

> Had to cycle power to get the machine back. Rebooting with max_cpus=1
> crashed in a different way. Was able to get past mounting the disks and
> some of the init script items before stopping at the same location with
> a different call trace:
> 
> Call Trace:
>  [<c011cb58>] scheduler_tick+0x148/0x490
>  [<c012bee3>] update_process_times+0x43/0x60
>  [<c0114b60>] mcount+0x14/0x18
>  [<c012beef>] update_process_times_0x4f/0x60
>  [<c0115141>] smp_apic_timer_interrupt+0xe1/0xf0
>  [<c011cb73>] scheduler_tick+0x16e/0x490
>  [<c010854a>] apic_timer_interrupt+0x1a/0x20
>  [<c031007b>] unix_stream_recvmsg+0x5b/0x450
>  [<c011cb7e>] scheduler_tick+0x16e/0x490
>  [<c012bee3>] update_process_times+0x43/0x60
>  [<c0114b60>] mcount+0x14/0x18
>  [<c012beef>] update_process_times+0x4f/0x60
>  [<c0115141>] smp_apic_timer_interrupt+0xe1/0xf0
>  [<c01225d4>] release_console_sem+0x64/0xe0
>  [<c012236d>] printk+0x1d/0x30


Do you have hyper threading turned on? Seems like I've seen this trace a
few times before..


Daniel Walker

