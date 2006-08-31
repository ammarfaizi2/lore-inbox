Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWHaSK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWHaSK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWHaSK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 14:10:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:41934 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932433AbWHaSK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 14:10:28 -0400
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Thu, 31 Aug 2006 20:10:20 +0200
User-Agent: KMail/1.9.3
Cc: Jan Beulich <jbeulich@novell.com>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>
References: <20060820013121.GA18401@fieldses.org> <200608311716.08786.ak@suse.de> <1157047877.22667.11.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1157047877.22667.11.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608312010.20874.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 20:11, Badari Pulavarty wrote:
> One more case ..
> 
> Thanks,
> Badari
> 
> BUG: soft lockup detected on CPU#2!
> 
> Call Trace:
>  [<ffffffff8020b395>] show_trace+0xb5/0x370
>  [<ffffffff8020b665>] dump_stack+0x15/0x20
>  [<ffffffff802555b9>] softlockup_tick+0xe9/0x110
>  [<ffffffff8023a2c3>] run_local_timers+0x13/0x20
>  [<ffffffff8023a5b7>] update_process_times+0x57/0x90
>  [<ffffffff802164fb>] smp_local_timer_interrupt+0x2b/0x60
>  [<ffffffff80216aa9>] smp_apic_timer_interrupt+0x49/0x60
>  [<ffffffff8020a8ce>] apic_timer_interrupt+0x66/0x6c
>  [<ffffffff804cd64e>] .text.lock.spinlock+0x0/0x92
> DWARF2 unwinder stuck at .text.lock.spinlock+0x0/0x92
> Leftover inexact backtrace:

Should be fixed in .19

-Andi
