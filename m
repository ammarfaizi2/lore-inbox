Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbULITk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbULITk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbULITk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:40:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21992 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261589AbULITkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:40:52 -0500
Date: Thu, 9 Dec 2004 20:40:38 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041209194038.GB18840@elte.hu>
References: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF737A0ECF.4ECB9A35-ON86256F65.006249D6@raytheon.com>
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

> >> Yes, but then I have ALL the IRQ's at the highest priority (plus a
> >> couple other /0 and /1 tasks). [...]
> >
> > that is the fundamental problem i believe: your 'CPU loop' gets 
> > delayed by them.
> 
> They should not get delayed by them any more than in the
> PREEMPT_DESKTOP configuration [...]

just to make sure we are talking about the same thing. Do you mean
PREEMPT_DESKTOP with IRQ threading disabled?

	Ingo
