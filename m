Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbULNV61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbULNV61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbULNV60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:58:26 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28086 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261684AbULNV5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:57:35 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20041214215153.GA18737@elte.hu>
References: <20041124101626.GA31788@elte.hu>
	 <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu>
	 <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu>
	 <1103052853.3582.46.camel@localhost.localdomain>
	 <1103054908.14699.20.camel@krustophenia.net>
	 <1103057144.3582.51.camel@localhost.localdomain>
	 <20041214211828.GA17216@elte.hu>
	 <1103060878.14699.35.camel@krustophenia.net>
	 <20041214215153.GA18737@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 16:57:34 -0500
Message-Id: <1103061454.14699.37.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 22:51 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
> > > i've been thinking about it on and off. If you would/could try it that
> > > would certainly help. RT for Linux is a dance of many small steps.
> > > 
> > > the two projects are obviously complementary and i have no intention to
> > > reinvent the wheel in any way. Best would be to bring hires timers up to
> > > upstream-mergable state (independently of the -RT patch) and ask Andrew
> > > to include it in -mm, then i'd port -RT to it automatically.
> > 
> > OK, I'll give this a shot.  It would certainly help on my underpowered
> > EPIA system, where my tests show 2.1% residency for the timer ISR with
> > HZ=1000.  On a system like this I would expect the difference to be
> > perceptible with a regular desktop workload.
> 
> a warning: it's probably quite complex merging work - while the two
> projects work on different conceptual issues, they touch the same code.
> 

Yeah, I expected this, I'll wait for George to update it.  I am testing
with 2.6.9 vanilla for the time being.  

Lee

