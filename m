Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbUJ0PEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUJ0PEp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUJ0PEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:04:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9961 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262479AbUJ0PEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:04:38 -0400
Date: Wed, 27 Oct 2004 17:05:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027150548.GA11233@elte.hu>
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FB7F0.4070300@cybsft.com>
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

> I use the rtc-debug and amlat to generate histograms of latencies
> which is what I was trying to do when I found the rtc problem the
> first time.  I believe that rtc-debug/amlat is much more accurate for
> generating histograms of latencies than realfeel is because the
> instrumentation is in the kernel rather than a userspace program.

ah, ok - nice. So rtc-debug+amlat is the only known-reliable way to
produce latency histograms?

Btw., rtc-debug's latency results could now be cross-validated with
-V0.4's wakeup tracer (and vice versa), because the two are totally
independent mechanisms.

	Ingo
