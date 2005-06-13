Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFMGxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFMGxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFMGxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:53:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22264 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261385AbVFMGw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:52:58 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: andrea@suse.de, karim@opersys.com, mingo@elte.hu, kbenoit@opersys.com,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <20050612175317.1fa416e6.rdunlap@xenotime.net>
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu>
	 <42AB662B.4010104@opersys.com> <20050612222011.GG5796@g5.random>
	 <1118617421.12889.71.camel@sdietrich-xp.vilm.net>
	 <20050612175317.1fa416e6.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sun, 12 Jun 2005 23:51:34 -0700
Message-Id: <1118645494.5729.48.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-12 at 17:53 -0700, randy_dunlap wrote:
> On Sun, 12 Jun 2005 16:03:41 -0700 Sven-Thorsten Dietrich wrote:
> 
> | On Mon, 2005-06-13 at 00:20 +0200, Andrea Arcangeli wrote:
> | > On Sat, Jun 11, 2005 at 06:31:07PM -0400, Karim Yaghmour wrote:
> | > > The logger used two TSC values. One prior to shooting the interrupt to the
> | > > target, and one when receiving the response. Responding to an interrupt
> | > 
> | > Real life RT apps would run the second rdtsc in user space and not
> | > kernel space, right?
> | > 
> | > And thanks for your benchmarking efforts!
> | 
> | Real-life RT apps are not benchmarks!
> | 
> | There is not requirement for them to run in user space or in kernel
> | space.
> | 
> | The choice is left to the application designer.
> 
> Wouldn't the company's attorney/lawyer/counsel be considered too?
> After all, in-kernel would likely have some legal ramifications...


Are you talking about SCO legal, FSM labs legal, GPL legal, IP-
protection counseling, or just plain illegal, as in too far out for the
local law man?

Meeting ANY of these requirements in Linux is a challenge to the
software designer, distracting from the RT issues.

Sorry, I don't want to talk about legal cheese. 

There are plenty of people working on robotics in college that can use
this code, and they will publish and advance the art of the science,
without legal issues.

To name just one possible application, and only if they sign the patent
form the University requires. Business, they are all still learning
about GPL, and the EU is learning about software patents.

I know some lawyer jokes, and my sister is one attorney I'd never want
to have to argue with in front of a judge, but lets leave the legal
issue out of it, we're trying to do scientific research for the sake of
understanding. 

Fear, anxiety, attorneys, patents, lawsuits, and religion all have their
respective venues.  Not on this list.

Thanks,

Sven


