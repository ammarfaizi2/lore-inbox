Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbUKTSLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUKTSLq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 13:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbUKTSLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 13:11:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5794 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263138AbUKTSLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 13:11:45 -0500
Date: Sat, 20 Nov 2004 20:14:03 +0100
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
Message-ID: <20041120191403.GA16262@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100971141.6879.18.camel@krustophenia.net>
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

> > > > 	http://redhat.com/~mingo/realtime-preempt/
> > > 
> > > I tried this with CONFIG_PREEMPT_VOLUNTARY (which should theoretically
> > > work like the earlier VP patches, right?) to test for regressions. 
> > > The boot process hung after initializing my IDE controller.
> > 
> > which patch did you try? I fixed the 'lower' preemption levels in
> > -V0.7.29-4, earlier kernels are broken.
> > 
> 
> This was the version I tried.  I will try to provide some more info.

i only tried the !PREEMPT version though - does that one work for you? 
Also, please send me the .config that produces the failing kernel.

	Ingo
