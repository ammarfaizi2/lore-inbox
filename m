Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270045AbUJTM7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270045AbUJTM7p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269817AbUJTM6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:58:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:54429 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S270315AbUJTMyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:54:53 -0400
Date: Wed, 20 Oct 2004 14:56:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020125607.GB8693@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <200410201452.01317.l_allegrucci@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410201452.01317.l_allegrucci@yahoo.it>
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


* Lorenzo Allegrucci <l_allegrucci@yahoo.it> wrote:

> Process kIrDAd (pid: 1295, threadinfo=de848000 task=df3d6110)

> Call Trace:
>  [<e09119bb>] run_irda_queue+0x5b/0xd0 [sir_dev] (4)
>  [<c0111590>] mcount+0x14/0x18 (8)
>  [<e09119bb>] run_irda_queue+0x5b/0xd0 [sir_dev] (28)
>  [<e0911ae2>] irda_thread+0xb2/0xf0 [sir_dev] (24)

ok - IRDA too needs fixing. Disable CONFIG_IRDA for the time being.

	Ingo
