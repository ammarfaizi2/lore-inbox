Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbULNWBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbULNWBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULNWBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:01:34 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:20910 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261690AbULNWAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:00:11 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
From: Steven Rostedt <rostedt@goodmis.org>
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <41BF60A1.1080606@mvista.com>
References: <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu>
	 <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu>
	 <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
	 <20041214132834.GA32390@elte.hu>
	 <1103052853.3582.46.camel@localhost.localdomain>
	 <1103054908.14699.20.camel@krustophenia.net>
	 <1103057144.3582.51.camel@localhost.localdomain>
	 <20041214211828.GA17216@elte.hu>  <41BF60A1.1080606@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Tue, 14 Dec 2004 16:59:53 -0500
Message-Id: <1103061593.3582.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 13:52 -0800, George Anzinger wrote:
> Ingo Molnar wrote:

...

> >>Now, since High Res-timers and RT seem to go together, what are the
> >>plans for merging these?  If this is indeed what I need, then I'll be
> >>doing it to myself, [...]
> > 
> > 
> > i've been thinking about it on and off. If you would/could try it that
> > would certainly help. RT for Linux is a dance of many small steps.
> > 
> > the two projects are obviously complementary and i have no intention to
> > reinvent the wheel in any way. Best would be to bring hires timers up to
> > upstream-mergable state (independently of the -RT patch) and ask Andrew
> > to include it in -mm, then i'd port -RT to it automatically.
> 
> Well, I guess I am just backward :)  I plan to port it to the current RT today 
> or tomorrow (if all goes well).  I will then work on the changes needed to get 
> it into -mm.  Guess I will be supporting two versions for a bit...
> 

I need what you've been working on, so I'm available to help get the two
together. Since you two (Ingo and George) are the creators of these,
I'll let you fight it out at how to go about this. If it ends up being
two patches for you George, then I would be glad to help maintain the
RT/HigRes one.

-- Steve

