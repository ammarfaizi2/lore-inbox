Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbUKUMag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbUKUMag (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 07:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUKUMaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 07:30:35 -0500
Received: from mx1.elte.hu ([157.181.1.137]:32477 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261944AbUKUMaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 07:30:30 -0500
Date: Sun, 21 Nov 2004 14:32:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121133228.GA16928@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net> <20041120191403.GA16262@elte.hu> <1100977765.6879.53.camel@krustophenia.net> <20041121124720.GB7972@elte.hu> <20041121132732.GA16170@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121132732.GA16170@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Lee Revell <rlrevell@joe-job.com> wrote:
> > 
> > > > i only tried the !PREEMPT version though - does that one work for you? 
> > > > Also, please send me the .config that produces the failing kernel.
> > > 
> > > OK it allows me to set PREEMPT_NONE, PREEMPT_SOFTIRQS, and
> > > PREEMPT_HARDIRQS.  This should be an illegal combination, right?
> > 
> > in theory it should work just fine.
> 
> hm, in practice it doesnt work - this is that causes the boot-time
> hang you saw during PREEMPT_VOLUNTARY. I'll make irq threading depend
> on PREEMPT, for the time being.

this change is in the -5 kernel i just uploaded.

	Ingo
