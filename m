Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbULOAS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbULOAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULOASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:18:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27079 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261701AbULNWbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:31:39 -0500
Date: Tue, 14 Dec 2004 23:31:18 +0100
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
Message-ID: <20041214223118.GD22043@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103052853.3582.46.camel@localhost.localdomain> <1103054908.14699.20.camel@krustophenia.net> <1103057144.3582.51.camel@localhost.localdomain> <20041214211828.GA17216@elte.hu> <1103062423.14699.48.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103062423.14699.48.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
> > the two projects are obviously complementary and i have no intention to
> > reinvent the wheel in any way. Best would be to bring hires timers up to
> > upstream-mergable state (independently of the -RT patch) and ask Andrew
> > to include it in -mm, then i'd port -RT to it automatically.
> 
> Among other things I think Paul Davis mentioned that George's high res
> timer patch would make it possible for JACK to send MIDI clock.  This
> would be a huge improvement.

<clueless question> roughly what latency/accuracy requirements does the
MIDI clock have, and why is it an advantage if Linux generates it? What
generates it otherwise - external MIDI hardware? Or was the problem
mainly not latency/accuracy but that Linux couldnt generate a
finegrained enough clock?

	Ingo
