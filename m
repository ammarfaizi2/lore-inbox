Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUKPJoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUKPJoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUKPJmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:42:18 -0500
Received: from mx2.elte.hu ([157.181.151.9]:61657 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261392AbUKPJkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:40:40 -0500
Date: Tue, 16 Nov 2004 11:41:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       alsa-devel@lists.sourceforge.net
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041116104143.GA31090@elte.hu>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <61930.195.245.190.94.1100529227.squirrel@195.245.190.94> <20041115161159.GA32580@elte.hu> <33583.195.245.190.93.1100537554.squirrel@195.245.190.93> <32825.192.168.1.5.1100558154.squirrel@192.168.1.5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32825.192.168.1.5.1100558154.squirrel@192.168.1.5>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Already testing with RT-0.7.26-5 now. No good. Same lockup behavior on
> alsa shutdown, altought not always, but very frequently. Nothing comes
> out via serial console. Not even SysRq is of any help, pretty hard
> these lockups are.

i'm rebasing to -rc2-mm1 currently, it should be completed today and
we'll see whether those ALSA problems are upstream related.

is it stable if you dont unload the ALSA modules?

	Ingo
