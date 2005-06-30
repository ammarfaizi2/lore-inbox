Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVF3PBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVF3PBh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVF3PBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:01:37 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27141 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262740AbVF3PBe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:01:34 -0400
Message-ID: <42C408ED.5030306@tmr.com>
Date: Thu, 30 Jun 2005 10:59:57 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630015041.GA24234@nietzsche.lynx.com>
In-Reply-To: <20050630015041.GA24234@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Wed, Jun 29, 2005 at 04:54:22PM -0700, Paul E. McKenney wrote:
> 
>>If you were suggesting this to be run on an SMP system, I would agree
>>with you.  I, too, would very much like to see these results run on a
>>2-CPU or 4-CPU system, although I am most certainly -not- asking Kristian
>>and Karim to do this work -- it is very much someone else's turn in the
>>barrel, I would say!
> 
> 
> No, I'm suggesting that you and other folks understand the basic ideas
> behind this patch and stop asking unbelievably stupid questions. This has
> been covered over and over again, and I shouldn't have to repeat these
> positions constantly because folks have both a language comprehension
> problem and inability to bug off appropriately.

The reasons you have to repeat yourself are (a) you lack communications 
skills and expect people to read past your insults, (b) you're just 
technically wrong in some cases, such as saying that the results would 
be different if the kernel were compiled in an unrealistic way.
> 
> 
>>However, on a UP system, I have to agree with Kristian's choice of
>>configuration.  An embedded system developer running on a UP system would
>>naturally use a UP Linux kernel build, so it makes sense to benchmark
>>a UP kernel on a UP system.
> 
> 
> Dual cores are going to be standard in the next few years so RTOSs should
> anticipate these things coming down the pipeline.

s/standard/common/

I doubt that single core CPUs are going to vanish, there are too many 
power critical (heat critical) embedded applications. In many the 
response time is important but the total CPU capability isn't an issue 
while battery life or fanless operation is.

Your point that SMP operation is important is true, but I see no reason 
to think Ingo has missed that.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
