Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUHTRE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUHTRE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUHTRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:04:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58770 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267368AbUHTREX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:04:23 -0400
Date: Fri, 20 Aug 2004 19:04:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Thomas Charbonnel <thomas@undata.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
Message-ID: <20040820170443.GB20232@elte.hu>
References: <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <41260CA6.2040306@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41260CA6.2040306@cybsft.com>
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

> Ingo Molnar wrote:
> > i've uploaded the -P5 patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P5
> >
> <snip>
> 
> I have been running the voluntary-preempt patches on one of my slower
> (450) servers at home. The question is would latency traces from such
> a slow system be useful to you in this testing. About the most load
> that gets generated on this system, usually, is compiling the kernel
> or a very large app. that I do development on. What I tend to do to
> load the system is just run the stress-kernel suite and sometimes
> Andrew's amlat program to provide RT scheduling pressure.
> 
> If this would be useful, let me know as I have an interest in seeing
> latencies reduced as much as possible. I am building with the -P5
> patch right now. If it would be more useful to try this on a faster
> system or to stess the system in a different manner, I could do that
> as well.

sure, all traces are interesting! On your system the latencies will be a
bit larger than on others, but that's all - the maximum latency points
should be the same (or similar) critical sections. So it's just as
useful as the other traces.

	Ingo
