Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUIWNFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUIWNFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUIWNFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:05:47 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:38053 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268435AbUIWNFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:05:45 -0400
Date: Thu, 23 Sep 2004 15:07:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
Message-ID: <20040923130729.GA12984@elte.hu>
References: <20040907115722.GA10373@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <200409230957.29318.norberto+linux-kernel@bensa.ath.cx> <20040923130134.GA12392@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923130134.GA12392@elte.hu>
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


oops - Kconfig chunks are missing. fixing.

	Ingo

* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
> 
> > Hello,
> > 
> > Ingo Molnar wrote:
> > > i've released the -S4 VP patch:
> > >
> > >   
> > > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm2-
> > >S4
> > 
> >   CC      arch/i386/kernel/irq.o
> > arch/i386/kernel/irq.c: In function `do_IRQ':
> > arch/i386/kernel/irq.c:287: warning: implicit declaration of function 
> > `redirect_hardirq'
> > arch/i386/kernel/irq.c:344: error: `noirqdebug' undeclared (first use in this 
> 
> 
> did you do a 'make oldconfig'? Make sure there's
> CONFIG_GENERIC_HARDIRQ=y in your .config.
> 
> 	Ingo
