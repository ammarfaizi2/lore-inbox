Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbUJ0PRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbUJ0PRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUJ0PRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:17:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:39855 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262482AbUJ0PQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:16:18 -0400
Date: Wed, 27 Oct 2004 17:17:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027151701.GA11736@elte.hu>
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com> <20041027150548.GA11233@elte.hu> <1098889994.1448.14.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098889994.1448.14.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > ah, ok - nice. So rtc-debug+amlat is the only known-reliable way to
> > produce latency histograms?
> > 
> 
> Yes, I think it is the most reliable way because the measurement is
> done in the kernel.  At least, this is what AM's notes say.  There are
> any number of ways to generate these with userspace programs (jackd,
> realfeel, etc).
> 
> Here is a more up to date version of the rtc-debug patch:
> 
> http://lkml.org/lkml/2004/9/9/307
> 
> There is still a bit of 2.4 cruft in there but it works well.  Maybe
> this could be included in future patches.

the most natural point of inclusion would be Andrew's -mm tree i think
:-)

	Ingo
