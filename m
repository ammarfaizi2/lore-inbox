Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVDATT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVDATT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVDATT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:19:29 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:40623 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S262858AbVDATTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:19:22 -0500
Date: Fri, 01 Apr 2005 14:19:20 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-reply-to: <424D927F.2020601@cybsft.com>
To: linux-kernel@vger.kernel.org
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200504011419.20964.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050325145908.GA7146@elte.hu>
 <200504011231.55717.gene.heskett@verizon.net> <424D927F.2020601@cybsft.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 April 2005 13:27, K.R. Foley wrote:
>Gene Heskett wrote:
><snip>
>
>> It was up to 43-04 by the time I got there.
>>
>> This one didn't go in cleanly Ingo.  From my build-src scripts
>> output: -------------------
>> Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04
>> [...]
>> patching file lib/rwsem-spinlock.c
>> Hunk #5 FAILED at 133.
>> Hunk #6 FAILED at 160.
>> Hunk #7 FAILED at 179.
>> Hunk #8 FAILED at 194.
>> Hunk #9 FAILED at 204.
>> Hunk #10 FAILED at 231.
>> Hunk #11 FAILED at 250.
>> Hunk #12 FAILED at 265.
>> Hunk #13 FAILED at 274.
>> Hunk #14 FAILED at 293.
>> Hunk #15 FAILED at 314.
>> 11 out of 15 hunks FAILED -- saving rejects to file
>> lib/rwsem-spinlock.c.rej
>> -----------
>> I doubt it would run, so I haven't built it.  Should I?
>
>Adding the attached patch on top of the above should resolve the
>failures, at least in the patching. Still working on building it.

I assume you mean apply before the 43-04 patch?

I'll give it a go later today, right now I've got dirt to move in the 
yard.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
