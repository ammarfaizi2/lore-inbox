Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUKPUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUKPUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKPUWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:22:41 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49335 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261783AbUKPUWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:22:24 -0500
Date: Tue, 16 Nov 2004 22:24:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Mark_H_Johnson@raytheon.com, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Stefan Schweizer <sschweizer@gmail.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Message-ID: <20041116212401.GA16845@elte.hu>
References: <OFE5FC77BB.DA8F1FAE-ON86256F4E.0058C5CF-86256F4E.0058C604@raytheon.com> <20041116184315.GA5492@elte.hu> <419A5A53.6050100@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A5A53.6050100@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> >i've uploaded -5 with a fix in profile_tick() - does it boot fine for
> >you now?
> >
> 
> I now have both of my SMP systems booted on -V0.7.27-6 now without any
> problems.

great. The current release is meanwhile at -V0.7.27-10, which includes
other minor updates:

 - two fixes to the wakeup timing code - this should resolve some of the
   weird traces reported by Mark H. Johnson.

 - two minor tweaks to the wakeup/reschedule path which should improve
   wakeup latencies.

	Ingo
