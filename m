Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCaSSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCaSSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVCaSSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:18:08 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:33759 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261615AbVCaSR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:17:57 -0500
Date: Thu, 31 Mar 2005 13:17:54 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-reply-to: <20050331174927.GA11483@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>
Message-id: <200503311317.55230.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
 <1112290916.12543.19.camel@localhost.localdomain>
 <20050331174927.GA11483@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 March 2005 12:49, Ingo Molnar wrote:
>* Steven Rostedt <rostedt@goodmis.org> wrote:
>> Oh, and did your really want to assign debug = .1?
>>
>> - .debug = .1, .file = __FILE__, .line = __LINE__
>> + .debug = 1, .file = __FILE__, .line = __LINE__
>
>doh - indeed. This means rwlocks were nondebug all along? Ouch. I've
>uploaded -42-08 with the fix.
>
> Ingo

It wasn't there when I looked yet, so I just built 42-05, Ingo.  
Almost everything works except I can't get any video out of tvtime, 
and the audio quality is still intermittently tinny,  sometimes cured 
by an internal tvtime restart with earlier versions but not this 
version.  Tinny sound seem to be forever now.

Also, lots of logging from tvtime, as if it was getting the video but 
missing a frame occasionally, and spit this out when I quit it.

Mar 31 13:05:00 coyote kernel: rtc latency histogram of {tvtime/5251, 
1303 samples}:
Mar 31 13:05:00 coyote kernel: 4 1
Mar 31 13:05:00 coyote kernel: 5 190
Mar 31 13:05:00 coyote kernel: 6 455
Mar 31 13:05:00 coyote kernel: 7 264
Mar 31 13:05:00 coyote kernel: 8 84
Mar 31 13:05:00 coyote kernel: 9 42
Mar 31 13:05:00 coyote kernel: 10 22
Mar 31 13:05:00 coyote kernel: 11 34
Mar 31 13:05:00 coyote kernel: 12 15
Mar 31 13:05:00 coyote kernel: 13 21
Mar 31 13:05:00 coyote kernel: 14 19
Mar 31 13:05:00 coyote kernel: 15 18
Mar 31 13:05:00 coyote kernel: 16 10
Mar 31 13:05:00 coyote kernel: 17 6
Mar 31 13:05:00 coyote kernel: 18 8
Mar 31 13:05:00 coyote kernel: 19 6
Mar 31 13:05:00 coyote kernel: 20 8
Mar 31 13:05:00 coyote kernel: 21 1
Mar 31 13:05:00 coyote kernel: 22 2
Mar 31 13:05:00 coyote kernel: 23 2
Mar 31 13:05:00 coyote kernel: 25 1
Mar 31 13:05:00 coyote kernel: 26 2
Mar 31 13:05:00 coyote kernel: 29 1
Mar 31 13:05:00 coyote kernel: 30 2
Mar 31 13:05:00 coyote kernel: 47 1
Mar 31 13:05:00 coyote kernel: 9999 88


I have -08 now, so I'll go build that one next.  Other than these, 
this one 'feels' good.

>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
