Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUIVTrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUIVTrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUIVTrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:47:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38119 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266838AbUIVTnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:43:18 -0400
Date: Wed, 22 Sep 2004 21:45:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S3
Message-ID: <20040922194505.GB30043@elte.hu>
References: <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <41519539.4010407@cybsft.com> <1095873391.498.41.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095873391.498.41.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Wed, 2004-09-22 at 11:07, K.R. Foley wrote:
> > Ingo Molnar wrote:
> > > i've released the -S3 VP patch:
> > > 
> > >    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm1-S3
> > > 
> > 
> > In order to get this to build I had to add
> > 
> > #include <asm/delay.h>
> > 
> > to linux/kernel/time.c
> > 
> 
> Builds fine for me, this must specific to your config, or Ingo fixed
> the patch.

yeah, this was reported very early so i just fixed up the patch.

	Ingo
