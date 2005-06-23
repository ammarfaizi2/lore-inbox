Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVFWAhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVFWAhZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVFWAhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:37:24 -0400
Received: from opersys.com ([64.40.108.71]:62481 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261932AbVFWAgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:36:38 -0400
Message-ID: <42BA069D.20208@opersys.com>
Date: Wed, 22 Jun 2005 20:47:25 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com> <20050623000607.GB11486@elte.hu>
In-Reply-To: <20050623000607.GB11486@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> well, it was your choice to benchmark ADEOS against PREEMPT_RT, right?  
> You posted numbers that showed your project in a favorable light while 
> the PREEMPT_RT numbers were more than 100% off. Your second batch of 
> numbers showed a tie, but we still dont know the true correct PREEMPT_RT
> irq latency values on your hardware, because your testing still had
> bugs. So a minimum requirement would be to post accurate numbers - you 
> have started this after all.
> 
> this thread showcases one of the many reasons why 'vendor sponsored 
> benchmarking' is such a bad idea. I wont post benchmark numbers 
> comparing PREEMPT_RT to 'other' realtime projects. I'm obviously biased, 
> everyone else sees me as biased, so what's the point? Should i pretend 
> i'm not biased towards the stuff i wrote? That would be hypocritical 
> beyond recognition. I dont benchmark PREEMPT_RT against other projects 
> because i know it perfectly well that it is the best thing since sliced 
> bread ;)

This is an unwarranted personal attack.

Should I simply refrain from conducting tests because 4+ years ago
I made a suggestion on how to obtain rt performance in Linux?
Heck, I didn't even write a single line of code of it, someone
else did.

If I wanted to show "my" project in such a good light, would I have
gone back and redone tests, and then published them even if those
numbers now showed that the "other" project was as good as "mine"?
Would I have even listened to any of your suggestions and gone
back and had the tests changed to fit your requirements? Would I
still be telling that we're going to further fix the tests based
on your feedback?

If I benchmarked adeos and preempt_rt it's simply because these
are the two patches on top of vanilla Linux that are actively
developed and claim to provide true rt on Linux. Let me ask you
a simple question: would a benchmark of adeos against nothing
but itself been any relevant?

As for the accuracy of the numbers, they are correct in as far
as I'm concerned. They aren't to your liking, that's different.
You complained about the way we measured irq latency and we
promised to repeat with your suggestions. But in this part of
the thread, I was simply asking about the over the top impact
as seen in the LMbench results. Do we need to fix LMbench too?

I repeat, the software we used is available for you to download.
If we've made a mistake, we'll more than gladly acknowledge it.

As for any hint that we're somehow fixing or showing these results
to better "sell" anything, then the scripts, drivers and configs
we used are all out there, you're more than welcome to show how
evil we are.

FWIW, Opersys has no engineering cycles to spare. This current
testset and all related human and hardware costs are actually
coming straight out of my personal pocket. I have no client paying
for this. And, FWIW, I had absolutely no idea what we were going
to find when I started this. Certainly I didn't expect that
preempt_rt would be able to do as good as the ipipe in terms of
interrupt latency, and that's to your credit.

And if you still disagree, then please go ahead and publish your
own test results or have others do so and show how wrong we are.
We've given you everything we used on our side. If there's
anything else you need, let us know.

After all, showing how much of a fraud we are shouldn't be that
difficult, you're a very competent developer. And because of
that last reason, I have a hard time holding this ad-hominem
attack against you. I am dissapointed though.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
