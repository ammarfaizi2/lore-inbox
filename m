Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFMIh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFMIh4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 04:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVFMIh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 04:37:56 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:49608 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261377AbVFMIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 04:37:49 -0400
Date: Mon, 13 Jun 2005 04:37:39 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050613060914.GA10613@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506130437.39480.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506122211.04152.gene.heskett@verizon.net> <20050613060914.GA10613@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 02:09, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> but had to interrupt the boot & go back to 48-13 as I was drowning
>> in a near DOS caused by:
>>
>> Jun 12 21:54:16 coyote kernel: BUG: scheduling while atomic:
>> softirq-timer/0/0x10000100/3 Jun 12 21:54:16 coyote kernel: caller
>> is __cond_resched+0x3d/0x50
>
>ok, fixed this one - does -48-19 work for you? (PREEMPT_DESKTOP was
>broken by the new split-softirqs code)
>
> Ingo

Its running apparently ok Ingo, but it fussed during the boot because 
CONFIG_LATENCY_TRACE was still on, so my ./makeit script is running 
again after turning that off.  I'd turned its parent in the xconfig 
display off mistakenly figureing that got the child.  kconfig 
miss-cue?

Rebooted to it, no warnings.  Glitch reports as they are found. :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
