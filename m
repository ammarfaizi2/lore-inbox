Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUKVIo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUKVIo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 03:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUKVIo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 03:44:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:7058 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261991AbUKVIoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 03:44:14 -0500
Date: Mon, 22 Nov 2004 10:46:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Message-ID: <20041122094602.GA6817@elte.hu>
References: <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041122020741.5d69f8bf@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122020741.5d69f8bf@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> On Mon, 22 Nov 2004 01:54:11 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > i have released the -V0.7.30-2 Real-Time Preemption patch, which can be
> > downloaded from the usual place:
> 
> > the biggest change in this release are fixes for priority-inheritance
> > bugs uncovered by Esben Nielsen pi_test suite. These bugs could explain
> > some of the jackd-under-load latencies reported.
> 
> It seems these large load related xruns are gone :) At least i wasn't
> able to trigger any during my uptime of 52 min. Will report if i ever
> see any of those again.

great. I now suspect that some of the xrun problems Rui was observing on
-RT kernel could be (positively) affected by these fixes too.

	Ingo
