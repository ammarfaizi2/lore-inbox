Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUKJO2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUKJO2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbUKJO0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:26:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4575 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261975AbUKJOXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:23:07 -0500
Date: Wed, 10 Nov 2004 16:25:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Message-ID: <20041110152509.GA9875@elte.hu>
References: <OF5FEE4152.258EB1B2-ON86256F48.004DA741-86256F48.004DA76D@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5FEE4152.258EB1B2-ON86256F48.004DA741-86256F48.004DA76D@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >- everything else should be SCHED_OTHER. Do latencies get any better if
> >you do this?

> I can, but that is not necessarily an "apples to apples" comparison.

the goal now would be to simplify the test and work down the issues in
isolation, instead of looking at a complex setup of mixed workloads and
just seeing 'it sucks' without knowing which component causes what. 
That's why e.g. rtc_wakeup is so useful - it's simple and dependable and
still it showed a good deal of problems and helped debug/fix them.

	Ingo
