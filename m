Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbULFP2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbULFP2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULFP2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:28:40 -0500
Received: from mx2.elte.hu ([157.181.151.9]:53219 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261539AbULFP1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:27:35 -0500
Date: Mon, 6 Dec 2004 16:27:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Message-ID: <20041206152704.GA23729@elte.hu>
References: <20041206131458.GA20247@elte.hu> <Pine.OSF.4.05.10412061520060.6546-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10412061520060.6546-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> So my point was: Low RT-load might not be the common case on specific
> systems. [...]

i did not suggest it was. The reason why i mentioned it was to point out
that _non-RT usage_ does not see any overhead, i.e. ordinary Linux
boxes. (which nevertheless do run RT tasks occasionally.)

of course in the RT-specific it can be common - Mark's test is one such
workload. If it werent widespread i'd not try to solve the problem...

	Ingo
