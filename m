Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUIVTrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUIVTrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUIVTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:47:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41187 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266833AbUIVTmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:42:40 -0400
Date: Wed, 22 Sep 2004 21:43:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: Oops in __posix_lock_file was:Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S2
Message-ID: <20040922194351.GA30043@elte.hu>
References: <20040907115722.GA10373@elte.hu> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <4151B6B8.6000201@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4151B6B8.6000201@cybsft.com>
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
> >i've released the -S2 VP patch:
> >
> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S2
> >
> 
> I don't know if this one has been fixed in S3 or not but I also saw
> this in S1 I think. This just happened when I booted back into S2 so I
> thought I would report it.

> 
> kr
> 
> 
> Sep 22 12:00:44 porky kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000

> Sep 22 12:00:45 porky kernel:  [<c0107175>] error_code+0x2d/0x38
> Sep 22 12:00:45 porky kernel:  [<c01776dd>] __posix_lock_file+0x6d/0x5a0

yeah, this is one of the bugs that should be fixed in -S3.

	Ingo
