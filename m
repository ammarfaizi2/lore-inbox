Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVADJwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVADJwC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVADJwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:52:02 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8867 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261594AbVADJv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:51:56 -0500
Date: Tue, 4 Jan 2005 10:51:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       kernel@kolivas.org, rncbc@rncbc.org, paul@linuxaudiosystems.com
Subject: Re: Latency results with 2.6.10 - looks good
Message-ID: <20050104095147.GA14787@elte.hu>
References: <1104348820.5218.42.camel@krustophenia.net> <1104549524.3803.28.camel@krustophenia.net> <20050101012252.7b4645b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050101012252.7b4645b7.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Followup: other audio users have confirmed that 2.6.10 is the best
> >  release yet latency-wise.  It works most of the time at 64 frames
> >  (~1.33ms latency).
> > 
> >  Now, the bad news: there are still enough xruns to make it not quite
> >  good enough for, say, a recording studio; as we all know with realtime
> >  constraints the worst case scenario is important.
> 
> The kernel which you should be testing is most-recent -mm.  The -mm
> kernels have had a bunch of latency improvements which are queued for
> 2.6.11.  We need to know how that stuff performs - 2.6.10 is largely
> uninteresting from a development POV.

i think Lee is well aware of that - nevertheless his data point shows
that even the relatively low number of latency fixes that went into
2.6.10 (compared to what is pending in -mm and in -RT) are a step in the
right direction. I'd guess the biggest win was the ACPI related latency
fix, and maybe the softirq fixes.

	Ingo
