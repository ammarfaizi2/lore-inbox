Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVF3WPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVF3WPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 18:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVF3WPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 18:15:53 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:56448 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261254AbVF3WPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 18:15:45 -0400
Date: Thu, 30 Jun 2005 18:15:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-37
In-reply-to: <20050630195258.GB20310@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Message-id: <200506301815.43315.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <Pine.LNX.4.58.0506301238450.20655@echo.lysdexia.org>
 <20050630195258.GB20310@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 June 2005 15:52, Ingo Molnar wrote:
>* William Weston <weston@sysex.net> wrote:
>> Hi Ingo,
>>
>> -50-37 wouldn't compile out of the box on my debug config.
>> Here's a couple minor cleanups:
>
>thanks, applied. except these:
>> - struct thread_info *ti = current_thread_info();
>> + //struct thread_info *ti = current_thread_info();
>>
>> - struct thread_info *ti = current_thread_info();
>> + //struct thread_info *ti = current_thread_info();
>
>they are needed in the nondebug build - i'll fix this up.
>
> Ingo
>-
Humm, I can't get the -37 to apply, something about the wrong -p0/-p1 
option to patch, but neither one finds the file to patch.  PEBKAC? or 
what Ingo?

>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
