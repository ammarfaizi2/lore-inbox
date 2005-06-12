Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVFLNkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVFLNkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbVFLNkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:40:32 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:37291 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S262570AbVFLNkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:40:24 -0400
Date: Sun, 12 Jun 2005 09:40:11 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050612103513.GA10808@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506120940.11698.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <200506120502.01752.gene.heskett@verizon.net> <20050612103513.GA10808@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 06:35, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> Glitch reports as they develop of course.
>>
>> Q: Whats the diff between turning on hardirq's in mode 3, and mode
>> 4?
>
>well, "mode 3" is PREEMPT_DESKTOP - normal CONFIG_PREEMPT on the
>mainstream kernel. If you turn on hardirq/softirq threading then you
> can e.g. chprio your sound IRQ to have better audio latencies. It
> will cause runtime overhead though. On "mode 4" (PREEMPT_RT)
> hardirq/softirq threading is mandatory (due to the processing
> model).
>
> Ingo

I think I see.  Do you have a swag as to how much runtime overhead 
using softirq's only might cause?  My normal seti production is about 
7 per day, and it seems to have dropped to about 6 while running the 
RT versions.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
