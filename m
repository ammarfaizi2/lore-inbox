Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbULNWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbULNWdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbULNWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:33:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:36247 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261668AbULNW2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:28:16 -0500
Date: Tue, 14 Dec 2004 23:28:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Lee Revell <rlrevell@joe-job.com>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Message-ID: <20041214222804.GC22043@elte.hu>
References: <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <1103052853.3582.46.camel@localhost.localdomain> <1103054908.14699.20.camel@krustophenia.net> <1103057144.3582.51.camel@localhost.localdomain> <20041214211828.GA17216@elte.hu> <41BF60A1.1080606@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BF60A1.1080606@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> >the two projects are obviously complementary and i have no intention to
> >reinvent the wheel in any way. Best would be to bring hires timers up to
> >upstream-mergable state (independently of the -RT patch) and ask Andrew
> >to include it in -mm, then i'd port -RT to it automatically.
> 
> Well, I guess I am just backward :) I plan to port it to the current
> RT today or tomorrow (if all goes well).  I will then work on the
> changes needed to get it into -mm.  Guess I will be supporting two
> versions for a bit...

very good - i can carry it along in -RT, and your VST bits are certainly
an immediate bonus feature for the non-hard-RT (=laptop, desktop, audio)
folks too.

	Ingo
