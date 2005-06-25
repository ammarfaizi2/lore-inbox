Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVFYOlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVFYOlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVFYOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 10:41:41 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:53698 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S263376AbVFYOjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 10:39:24 -0400
Date: Sat, 25 Jun 2005 10:39:14 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <200506250919.52640.gene.heskett@verizon.net>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Message-id: <200506251039.14746.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 09:19, Gene Heskett wrote:
>On Saturday 25 June 2005 05:12, Ingo Molnar wrote:
>>* Gene Heskett <gene.heskett@verizon.net> wrote:
>>> It seems the transmitter only needed a goodnight kiss, so I came
>>> back & built it.  So far running good, 5 minute uptime, looks
>>> good.  More reports if I find any gotcha's :) Seemed to boot
>>> marginally faster too, but no stopwatch timeings were done.
>>
>>great. To make sure, these earlier boot failures are gone:
>>> I just tried to build & boot 50-17 in mode=3, no hardirq's and
>>> got the same boot failure as mode 4 for 50-06 gave:
>>
>>right?
>>
>> Ingo
>
>Yes.  Same mode 3, no hardirq's config.  I have not tried mode=4.
>Here thats been a lockup every time for recent versions.  I just
>checked the log, pretty quiet, nothing out of line.

Now I've tried -22 in mode=4 and its the same hard lockup after this 
line is printed to the screen:

"Checking to see if this processor honours the WP bit even in the 
supervisor mode...  OK"

reset button to recover. -22 in mode=3, no hardirq's now building 
while running -19.

-22, mode=3 no hardirq's is running, but it took kmail a couple of 
minutes to fully init its screen, with a spamd child eating 99% of 
the cpu.  The logs are silent after "loading the r200 code" from 
startx.  But, it seems to be ok now.  More data when available.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
