Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUIWNid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUIWNid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUIWNid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:38:33 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:33767 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268458AbUIWNiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:38:20 -0400
Date: Thu, 23 Sep 2004 15:40:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
Message-ID: <20040923134000.GA15455@elte.hu>
References: <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> Ingo Molnar wrote:
> >
> > i've released the -S4 VP patch:
> >
> 
> Just tried to configure for 2.6.9-rc2-mm2-VP-S4 on my laptop. Strange
> enough I don't get the PREEMPT_VOLUNTARY, PREEMPT_SOFTIRQS and
> PREEMPT_HARDIRQS symbols available for Kconfig.
> 
> Not surprisingly, make stops on these messages:
> 
>  [...]
>  CC      arch/i386/kernel/irq.o
> arch/i386/kernel/irq.c: In function `do_IRQ':

yeah, please re-download the -S4 patch, i fixed this meanwhile.

	Ingo
