Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVFKO0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVFKO0c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVFKO0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:26:32 -0400
Received: from fsmlabs.com ([168.103.115.128]:30126 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261708AbVFKO03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:26:29 -0400
Date: Sat, 11 Jun 2005 08:28:27 -0600 (MDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Kristian Benoit <kbenoit@opersys.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, paulmck@us.ibm.com,
       bhuey@lnxw.com, Andrea Arcangeli <andrea@suse.de>, tglx@linutronix.de,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, ak@muc.de,
       sdietrich@mvista.com, dwalker@mvista.com,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
In-Reply-To: <42AA812D.2060701@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0506110825120.22613@montezuma.fsmlabs.com>
References: <42AA6A6B.5040907@opersys.com> <42AA812D.2060701@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jun 2005, Nick Piggin wrote:

> Kristian Benoit wrote:
> > For the past few weeks, we've been conducting comparison tests between
> > PREEMPT_RT and the Adeos nanokernel. As was clear from previous discussion,
> > we've been open to be proven wrong regarding endorsement of either method.
> > Hence, this comparison was done in order to better understand the impact
> > of each method vis-a-vis vanilla Linux.
> > 
> 
> This is wonderful data, thanks very much for putting in the work.
> I hope this thread and future threads on this topic can be steered
> more towards technical facts and numbers, as that is the only way
> to make sane choices.

I think it'd also be interesting to see results with a heavy scheduling 
load (say make -jN). Not only would this clobber caches, it'd also show 
possible issues regarding contention or long preemption disabled points.

	Zwane
