Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUKWUP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUKWUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUKWUNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:13:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:27777 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261563AbUKWUMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:12:55 -0500
Date: Tue, 23 Nov 2004 22:15:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
Message-ID: <20041123211515.GA31421@elte.hu>
References: <OF333BD8AC.9A839B3C-ON86256F55.00637844-86256F55.00637868@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF333BD8AC.9A839B3C-ON86256F55.00637844-86256F55.00637868@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> I do have a repeatable problem with -7 however (not yet checked in
> -9). This was with PREEMPT_DESKTOP and unthreaded IRQ's (hard and
> soft). [...]

> The system dies early in the boot process. Locks up and completely not
> responsive and no error messages prior to failure. Serial console
> output follows at the end of this email.

> The PREEMPT_RT kernel I built (same source, only difference was
> previously described .config changes) comes up OK.

i can reproduce the PREEMPT_DESKTOP boot-time hang too, it is a recent
breakage.

	Ingo
