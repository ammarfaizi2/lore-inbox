Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbUL3QF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUL3QF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUL3QF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:05:28 -0500
Received: from mail.tmr.com ([216.238.38.203]:10695 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261667AbUL3QFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:05:09 -0500
Message-ID: <41D429C3.8010805@tmr.com>
Date: Thu, 30 Dec 2004 11:16:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, kernel@kolivas.org,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <4d8e3fd304122923127167067c@mail.gmail.com><m3mzw262cu.fsf@rajsekar.pc> <20041229232028.055f8786.akpm@osdl.org>
In-Reply-To: <20041229232028.055f8786.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> 
>>Andrew, 
>> what's your plan for the staircase scheduler ?
> 
> 
> I have none, frankly.  I haven't seen any complaints about the current
> scheduler.
> 
> If someone can identify bad behaviour in the current scheduler which
> staircase improves then please describe a tescase which the scheduler
> developers can use to reproduce the situation.

Of course that may result in just another band-aid on the current 
scheduler rather than a change.
> 
> If, after that, we deem that the problem cannot be feasibly fixed within the
> context of the current scheduler and that the problem is sufficiently
> serious to justify wholesale replacement of the scheduler then sure,
> staircase is an option.

More to the point, was there a problem with plugable schedulers? It 
would be both technically and politically better to let people try, use, 
and write schedulers for special case loads, just as we have for io 
scheduling.

I didn't find staircase to be the solution to any of my problems, but it 
would be nice to let all the people who are improving schedulers have an 
easy way to try new ideas (easier than building a whole new kernel, that 
is).

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
