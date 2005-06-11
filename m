Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFKFdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFKFdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 01:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFKFdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 01:33:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4307 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261289AbVFKFdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 01:33:07 -0400
Date: Sat, 11 Jun 2005 07:23:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611052319.GB16500@elte.hu>
References: <20050608022646.GA3158@us.ibm.com> <42A8D1F3.8070408@am.sony.com> <20050609235026.GE1297@us.ibm.com> <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610225231.GF6564@g5.random>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> On Fri, Jun 10, 2005 at 03:37:24PM -0700, Bill Huey wrote:
> > Some of the comments from various folks are just intolerably paranoid
> 
> Just tell me how can you go to a customer and tell him that your 
> linux-RTOS has a guaranteed worst case latency of 50usec. [...]

Andrea, please just stop these scare tactics, it's getting boring. First 
you came with incorrect statements about locks, then you came with the 
patent boogeyman, then you came with the driver bogosity, and now you 
come with "but ... [sputter] ... but ... where's the _guarantee_?".

Andrea, _please_ lean back and read back some of your earlier arguments.
To make it easier for you and to refresh your recollection, let me give
you a selection, just so that you can see why your sentiment creates
flames and personal responses:

  '[...] how can preempt-RT ever become hard-RT when a simple lock hangs 
   it.' (Andrea Arcangeli, May 31, 2005)

  'Exactly, they're simply not remotely comparable, a VM improvement may
   break preempt-RT anytime, it's just too easy to screw things up and
   invalidate all "measurements".' (Andrea Arcangeli, Jun 1, 2005)

  'Indeed, that's why I believe hard-RT with preempt-RT is just a 
   joke.' (Andrea Arcangeli, May 31, 2005)

  'Then I'm afraid preempt-RT infringe on the patent that they take 
   after years of doing that in linux. I'm not a lawyer but you may want 
   to check before investing too much on this for the next 15 years.' 
   (Andrea Arcangeli, Jun 1, 2005)

  'Why do you take risks when you can go with much more relaible 
   solutions like RTAI and rtlinux?' (Andrea Arcangeli, Jun 11, 2005)

I have to say, based on these statements you could soon become a fine 
replacement for Blake Stowell or the Iraqi Information Minister :-)

just to make it plain and obvious: there are two things that are true 
about the above snippets: 1) as far as they were technical comments they 
are all dead wrong, and 2) you never apologized for them. Wouldnt you 
yourself become a bit ... touchy if this happened to you on such a 
widespread basis? Please give me an answer, how much unjust accusations 
do i have to take before i have the _right_ to flame you, hm? :-)

thinking about the root causes of your behavior, it seems to me that you 
have a real inner trouble admitting mistakes (and that's not only true 
for this incident) - even though mistakes are human and i do at least a 
dozen mistakes every day and sometimes i screw up really bad. Like 3 
months ago when i criticised SECCOMP [your project] in an uninformed and 
thus unjust way. Perhaps we are getting this from you because you are 
still hurting from that SECCOMP incident? If it's about SECCOMP then i'd 
like to apologize again: i was wrong about SECCOMP and it's a fine and 
promising project. Okay?

if you review the PREEMPT_RT technology (with a cool mind) i do think 
you'll eventually come to the conclusion that it is actually a pretty 
nifty idea and implementation, with some pretty good potential :-) It's 
not trying to be the holy grail, it wont (nor does it want to) replace 
nanokernels, but it actually has some thinking behind it and is 
definitely useful to alot of people. And that is what matters. Your 
feelings about it or me dont really count.

	Ingo
