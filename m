Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUKUOQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUKUOQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 09:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUKUOQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 09:16:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45996 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261192AbUKUOQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 09:16:08 -0500
Date: Sun, 21 Nov 2004 16:18:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041121151845.GA25720@elte.hu>
References: <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100920963.1424.1.camel@krustophenia.net> <20041120125536.GC8091@elte.hu> <1100971141.6879.18.camel@krustophenia.net> <20041120191403.GA16262@elte.hu> <1100975745.6879.35.camel@krustophenia.net> <20041120201155.6dc43c39@mango.fruits.de> <20041121151225.GA24760@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121151225.GA24760@elte.hu>
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

> i am too seeing constant, periodic xruns coming every 100 millisecs or
> so. Simply running current Jack CVS via 'jackd -R -p1024 -d alsa'
> gives tons of periodic xruns. Are you seeing the same?

but i'm seeing the same with !PREEMPT too - perhaps something broke in
ALSA?

	Ingo
