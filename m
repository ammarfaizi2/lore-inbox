Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVFWAJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVFWAJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 20:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVFWAHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 20:07:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47762 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261846AbVFWAGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 20:06:24 -0400
Date: Thu, 23 Jun 2005 02:06:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: Bill Huey <bhuey@lnxw.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050623000607.GB11486@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050620183115.GA27028@nietzsche.lynx.com> <42B98B20.7020304@opersys.com> <20050622192927.GA13817@nietzsche.lynx.com> <20050622200554.GA16119@elte.hu> <42B9CC98.1040402@opersys.com> <20050622220428.GA28906@elte.hu> <42B9F673.4040100@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9F673.4040100@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karim Yaghmour <karim@opersys.com> wrote:

> Ingo Molnar wrote:
> > please retest using recent (i.e. today's) -RT kernels. There were a
> > whole bunch of fixes that could affect these numbers.
> 
> At this point, we're bound to rerun some of the tests. But there's 
> only so many times that one can claim that such and such test isn't 
> good enough because it doesn't have all the latest bells and whistles.  
> Surely there's more to this overhead than just rudimentary bugfixes.

well, it was your choice to benchmark ADEOS against PREEMPT_RT, right?  
You posted numbers that showed your project in a favorable light while 
the PREEMPT_RT numbers were more than 100% off. Your second batch of 
numbers showed a tie, but we still dont know the true correct PREEMPT_RT
irq latency values on your hardware, because your testing still had
bugs. So a minimum requirement would be to post accurate numbers - you 
have started this after all.

this thread showcases one of the many reasons why 'vendor sponsored 
benchmarking' is such a bad idea. I wont post benchmark numbers 
comparing PREEMPT_RT to 'other' realtime projects. I'm obviously biased, 
everyone else sees me as biased, so what's the point? Should i pretend 
i'm not biased towards the stuff i wrote? That would be hypocritical 
beyond recognition. I dont benchmark PREEMPT_RT against other projects 
because i know it perfectly well that it is the best thing since sliced 
bread ;)

	Ingo
