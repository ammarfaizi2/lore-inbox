Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbVDATWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbVDATWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVDATWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 14:22:40 -0500
Received: from mail4.utc.com ([192.249.46.193]:30156 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262860AbVDATW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 14:22:29 -0500
Message-ID: <424D9F6A.8080407@cybsft.com>
Date: Fri, 01 Apr 2005 13:22:18 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
References: <20050325145908.GA7146@elte.hu> <200504011231.55717.gene.heskett@verizon.net> <424D927F.2020601@cybsft.com> <200504011419.20964.gene.heskett@verizon.net>
In-Reply-To: <200504011419.20964.gene.heskett@verizon.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Friday 01 April 2005 13:27, K.R. Foley wrote:
> 
>>Gene Heskett wrote:
>><snip>
>>
>>>It was up to 43-04 by the time I got there.
>>>
>>>This one didn't go in cleanly Ingo.  From my build-src scripts
>>>output: -------------------
>>>Applying patch realtime-preempt-2.6.12-rc1-V0.7.43-04
>>>[...]
>>>patching file lib/rwsem-spinlock.c
>>>Hunk #5 FAILED at 133.
>>>Hunk #6 FAILED at 160.
>>>Hunk #7 FAILED at 179.
>>>Hunk #8 FAILED at 194.
>>>Hunk #9 FAILED at 204.
>>>Hunk #10 FAILED at 231.
>>>Hunk #11 FAILED at 250.
>>>Hunk #12 FAILED at 265.
>>>Hunk #13 FAILED at 274.
>>>Hunk #14 FAILED at 293.
>>>Hunk #15 FAILED at 314.
>>>11 out of 15 hunks FAILED -- saving rejects to file
>>>lib/rwsem-spinlock.c.rej
>>>-----------
>>>I doubt it would run, so I haven't built it.  Should I?
>>
>>Adding the attached patch on top of the above should resolve the
>>failures, at least in the patching. Still working on building it.
> 
> 
> I assume you mean apply before the 43-04 patch?

No actually I meant to apply it after the 43-04 patch. However, Ingo has 
a new patch that should cover this also.

> 
> I'll give it a go later today, right now I've got dirt to move in the 
> yard.
> 


-- 
    kr
