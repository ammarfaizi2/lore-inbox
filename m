Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVF0UB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVF0UB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVF0T6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:58:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58535 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261429AbVF0T4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:56:43 -0400
Date: Mon, 27 Jun 2005 21:54:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050627195405.GB16804@elte.hu>
References: <Pine.LNX.4.58.0506211228210.16701@echo.lysdexia.org> <200506270143.47690.gene.heskett@verizon.net> <20050627081712.GB15096@elte.hu> <200506271329.14562.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506271329.14562.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gene Heskett <gene.heskett@verizon.net> wrote:

> On Monday 27 June 2005 04:17, Ingo Molnar wrote:
> >* Gene Heskett <gene.heskett@verizon.net> wrote:
> >> In the FWIW category, I booted 50-23 about an hour & a half ago,
> >> same mode 3, no hardirq's, everything seems to be working fine
> >> except for kmails total lack of threading causeing composer hangs
> >> while a mail fetch/spamassassin run is in progress.  But thats not
> >> anything new to this patchset, its an equal opportunity annoyer.
> >
> >does the patch below make the kmail starvation go away?

> I put in the comment and its building now.  I rather doubt its going 
> to make a huge diff though as its probably the single most repeated 
> bitch on the kmail lists, and has been for a long, very long as in 
> years, time.  From hints dropped here and there, it might finally be 
> fixed with kde-3.5.  But we'll give this a shot nontheless.  I'll add 
> more after I reboot to test.

ah, ok - so kmail behaves similarly on vanilla kernels too? I thought 
this might be some -RT-specific degradation.

	Ingo
