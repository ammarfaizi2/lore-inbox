Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVAVQ4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVAVQ4V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVAVQ4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:56:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:63928 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262592AbVAVQ4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:56:13 -0500
Date: Sat, 22 Jan 2005 17:54:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Jack O'Quin" <joq@io.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050122165458.GA14426@elte.hu>
References: <200501201542.j0KFgOwo019109@localhost.localdomain> <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wtu6fho8.fsf@sulphur.joq.us>
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


* Jack O'Quin <joq@io.com> wrote:

> I finally made new kernel builds for the latest patches from both Ingo
> and Con.  I kept the two patch sets separate, as they modify some of
> the same files.
> 
> I ran three sets of tests with three or more 5 minute runs for each
> case.  The results (log files and graphs) are in these directories...
> 
>   1) sched-fifo -- as a baseline
>      http://www.joq.us/jack/benchmarks/sched-fifo
> 
>   2) sched-iso -- Con's scheduler, no privileges
>      http://www.joq.us/jack/benchmarks/sched-iso
> 
>   3) nice-20 -- Ingo's "nice --20" scheduler hack
>      http://www.joq.us/jack/benchmarks/nice-20

thanks for the testing. The important result is that nice--20
performance is roughly the same as SCHED_ISO. This somewhat
reduces the urgency of the introduction of SCHED_ISO.

	Ingo
