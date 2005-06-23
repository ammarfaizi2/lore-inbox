Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVFWBrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVFWBrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVFWBrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:47:07 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:39853 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261970AbVFWBm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:42:57 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 22 Jun 2005 18:42:06 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
In-Reply-To: <42BA0ED4.80207@opersys.com>
Message-ID: <Pine.LNX.4.62.0506221821240.16773@qynat.qvtvafvgr.pbz>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com>
 <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com>
 <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com>
 <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
 <20050623000607.GB11486@elte.hu> <42BA069D.20208@opersys.com>
 <Pine.LNX.4.62.0506221753010.16773@qynat.qvtvafvgr.pbz> <42BA0ED4.80207@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, Karim Yaghmour wrote:

> Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
> 
>
> David Lang wrote:
>> I know that I have a large number of slow (<200MHz) pentiums that are just
>> sitting around at home and could be used for this, but I don't know if
>> they would be considered fast enough for any portions of this test (I have
>> a much smaller number of faster machines that could possibly be used)
>
> I don't think that there should be any limitation on the type of
> hardware being tested. In fact, I would think that having as
> diverse a test hardware as possible would be a good thing.
> Many of the embedded platforms are in fact not that far different
> from those slow pentiums you have lying around.

Ok, I'll dig them out and see about getting them setup.

what pinout do I need to connect the printer ports

I'm thinking that the best approach for this would be to setup a static 
logger and host and then one (or more) target machines, then we can setup 
a small website on the host that will allow Ingo (and others) to submit 
kernels for testing, queue those kernels and then run the tests on each 
one in turn (and if it runs out of kernels to test it re-tests the last 
one with a longer run)

how much needs to change in userspace between the various tests? I would 
assume that between the plain, preempt, and RT kernels no userspace 
changes are needed, what about the other options?

given the slow speed of these systems it would seem to make more sense to 
have a full kernel downloaded to them rather then having the local box 
compile it.

does this sound reasonable?

David Lang

>
> My 0.02$,
>
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
