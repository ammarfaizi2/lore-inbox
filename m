Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULNVym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULNVym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbULNVyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:54:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:33938 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261678AbULNVxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:53:49 -0500
Date: Tue, 14 Dec 2004 22:51:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041214215153.GA18737@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103052853.3582.46.camel@localhost.localdomain> <1103054908.14699.20.camel@krustophenia.net> <1103057144.3582.51.camel@localhost.localdomain> <20041214211828.GA17216@elte.hu> <1103060878.14699.35.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103060878.14699.35.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
> > i've been thinking about it on and off. If you would/could try it that
> > would certainly help. RT for Linux is a dance of many small steps.
> > 
> > the two projects are obviously complementary and i have no intention to
> > reinvent the wheel in any way. Best would be to bring hires timers up to
> > upstream-mergable state (independently of the -RT patch) and ask Andrew
> > to include it in -mm, then i'd port -RT to it automatically.
> 
> OK, I'll give this a shot.  It would certainly help on my underpowered
> EPIA system, where my tests show 2.1% residency for the timer ISR with
> HZ=1000.  On a system like this I would expect the difference to be
> perceptible with a regular desktop workload.

a warning: it's probably quite complex merging work - while the two
projects work on different conceptual issues, they touch the same code.

	Ingo
