Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVABA0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVABA0R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 19:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVABA0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 19:26:17 -0500
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:63883 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S261200AbVABA0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 19:26:14 -0500
Message-ID: <41D73FA2.4000705@bigpond.net.au>
Date: Sun, 02 Jan 2005 11:26:10 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Andrew Morton <akpm@osdl.org>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, kernel@kolivas.org,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <4d8e3fd304122923127167067c@mail.gmail.com> <m3mzw262cu.fsf@rajsekar.pc> <20041229232028.055f8786.akpm@osdl.org> <41D429C3.8010805@tmr.com>
In-Reply-To: <41D429C3.8010805@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Andrew Morton wrote:
> 
>> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>>
>>> Andrew, what's your plan for the staircase scheduler ?
>>
>>
>>
>> I have none, frankly.  I haven't seen any complaints about the current
>> scheduler.
>>
>> If someone can identify bad behaviour in the current scheduler which
>> staircase improves then please describe a tescase which the scheduler
>> developers can use to reproduce the situation.
> 
> 
> Of course that may result in just another band-aid on the current 
> scheduler rather than a change.
> 
>>
>> If, after that, we deem that the problem cannot be feasibly fixed 
>> within the
>> context of the current scheduler and that the problem is sufficiently
>> serious to justify wholesale replacement of the scheduler then sure,
>> staircase is an option.
> 
> 
> More to the point, was there a problem with plugable schedulers? It 
> would be both technically and politically better to let people try, use, 
> and write schedulers for special case loads, just as we have for io 
> scheduling.
> 
> I didn't find staircase to be the solution to any of my problems, but it 
> would be nice to let all the people who are improving schedulers have an 
> easy way to try new ideas (easier than building a whole new kernel, that 
> is).
> 

At Con's request I've taken over responsibility for plugsched but I've 
been away visiting relatives for the last week or so and, therefore, I'm 
a little behind.  I hope to release a plugsched patch for 2.6.10 in the 
next few days with a (work in progress) modification to share a lot more 
code between schedulers so that the amount of work required to implement 
new schedulers is reduced.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
