Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUJ0AYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUJ0AYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbUJ0AYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:24:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24488 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261581AbUJ0AXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:23:47 -0400
Date: Wed, 27 Oct 2004 02:24:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027002455.GC31852@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417E2CB7.4090608@cybsft.com>
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

> Several things in regard to V0.2:
> 
> 1) Interactive responsiveness seems to be noticably sluggish at times on
> all three of the systems I have tested this on.
> 2) My 450MHz UP system is definitely the worst by far. Scrolling through
> the syslog in a telnet session produces pauses every few seconds for
> about a second, that is while it's still responding. These problems seem
> to be network related, but there are no indications of what the problem
> is. This system also at times will just stop responding to network requests.
> 3) Both of the SMP systems are lacking the snappy responsiveness in X
> that I have become accustomed to with previous patches, but the 2.6GHz
> Xeon (w/HT) is worse than the 933MHz Xeon. Again no indications of
> problems in the logs.
> 4) Using amlat to run the RTC at 1kHz will kill any of these systems
> very quickly.

could you try this with -V0.3 too? I believe most of these problems
should be solved.

	Ingo
