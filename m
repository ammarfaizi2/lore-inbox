Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbUKXVZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUKXVZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbUKXVWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:22:16 -0500
Received: from fallback.mail.elte.hu ([157.181.151.13]:19693 "EHLO
	fallback.mail.elte.hu") by vger.kernel.org with ESMTP
	id S261295AbUKXVVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:21:32 -0500
Date: Wed, 24 Nov 2004 23:17:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
Message-ID: <20041124221754.GA31512@elte.hu>
References: <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <1101324238.29045.62.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101324238.29045.62.camel@cmn37.stanford.edu>
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


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Using PREEMPT_DESKTOP I see a irq related problem with my network
> interface:

> IRQ#11 thread RT prio: 38.
> irq 16: nobody cared!
>  [<c0104173>] dump_stack+0x23/0x30 (20)
>  [<c0147970>] __report_bad_irq+0x30/0xa0 (24)
>  [<c0147a80>] note_interrupt+0x70/0xb0 (32)
>  [<c01477dc>] do_hardirq+0x13c/0x150 (40)
>  [<c0147889>] do_irqd+0x99/0xd0 (32)
>  [<c0139fda>] kthread+0xaa/0xb0 (48)
>  [<c0101335>] kernel_thread_helper+0x5/0x10 (153083924)

does it otherwise get detected and does it work fine afterwards?

	Ingo
