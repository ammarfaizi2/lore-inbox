Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbUKNPXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbUKNPXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 10:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbUKNPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 10:23:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5786 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261227AbUKNPXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 10:23:46 -0500
Date: Sun, 14 Nov 2004 15:15:51 +0100
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
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
Message-ID: <20041114141551.GA17043@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041114135656.7aa3b95b@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114135656.7aa3b95b@mango.fruits.de>
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

> i just build and booted into 26-3 (w/o debugging stuff) and put a
> little load on the system (find /'s plus kernel compile plus
> rtc_wakeup -f 8192). Got this on the console:
> 
> `IRQ 8` [14] is being piggy. need_resched=0, cpu=0
> 
> and the machine locked. will build with debugging and try to
> reproduce.

hm, i tried and couldnt reproduce this, so i'm curious what your
debugging build yields.

	Ingo
