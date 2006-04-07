Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWDGHON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWDGHON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWDGHON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:14:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63629 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932320AbWDGHOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:14:12 -0400
Date: Fri, 7 Apr 2006 09:11:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060407071125.GA2563@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407030713.GA9623@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Thu, Apr 06, 2006 at 09:37:53AM +0200, Ingo Molnar wrote:
> > do "global" decisions for what RT tasks to run on which CPU. To put even 
> > less overhead on the mainstream kernel, i plan to introduce a new 
> > SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
> > make much sense to extend SCHED_RR in that direction.]
> 
> You should consider for a moment to allow for the binding of a thread 
> to a CPU to determine the behavior of a SCHED_FIFO class task instead 
> of creating a new run category. [...]

That is already possible and has been possible for years.

	Ingo
