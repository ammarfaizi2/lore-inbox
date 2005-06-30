Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVF3CWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVF3CWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 22:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVF3CU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 22:20:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:916 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262737AbVF3CS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 22:18:59 -0400
Date: Wed, 29 Jun 2005 19:19:29 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
Message-ID: <20050630021929.GJ1299@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <42C320C4.9000302@opersys.com> <20050629225734.GA23793@nietzsche.lynx.com> <20050629235422.GI1299@us.ibm.com> <20050630015041.GA24234@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630015041.GA24234@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 06:50:41PM -0700, Bill Huey wrote:
> On Wed, Jun 29, 2005 at 04:54:22PM -0700, Paul E. McKenney wrote:
> > If you were suggesting this to be run on an SMP system, I would agree
> > with you.  I, too, would very much like to see these results run on a
> > 2-CPU or 4-CPU system, although I am most certainly -not- asking Kristian
> > and Karim to do this work -- it is very much someone else's turn in the
> > barrel, I would say!
> 
> No, I'm suggesting that you and other folks understand the basic ideas
> behind this patch and stop asking unbelievably stupid questions. This has
> been covered over and over again, and I shouldn't have to repeat these
> positions constantly because folks have both a language comprehension
> problem and inability to bug off appropriately.

Sorry to disappoint you, but I stand by my statements (I see no questions
in my earlier email that you quoted).

To repeat, comparing a UP kernels on UP systems seems eminently fair
and evenhanded to me.  Similarly, comparing SMP kernels running on SMP
systems seems quite fair and evenhanded to me.  Running SMP kernels on
UP systems can provide some useful information, but why would such a
benchmark be of interest to someone writing realtime applications that
will run on a UP system?

Keep in mind that performance is only one aspect to consider when
comparing the different approaches.

And why should Kristian and Karim be asked to run an SMP-kernel test?
They have released their framework, so others can do this if they wish.
Besides, didn't someone recently offer to do some testing?

I sympathize with the language-comprehension problem -- I would no
doubt be completely helpless in your native language.  I do appreciate
the effort you make to deal with English.

> > However, on a UP system, I have to agree with Kristian's choice of
> > configuration.  An embedded system developer running on a UP system would
> > naturally use a UP Linux kernel build, so it makes sense to benchmark
> > a UP kernel on a UP system.
> 
> Dual cores are going to be standard in the next few years so RTOSs should
> anticipate these things coming down the pipeline.

Agreed, though single-core CPUs aren't going to disappear any time soon.
People still use 8-bit Z80s, after all, and have been for over 25 years.

But if dual-core CPUs are going to be standard, why did you object to
comparing the two patches on an SMP system?

							Thanx, Paul
