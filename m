Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUIWM5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUIWM5j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 08:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUIWM5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 08:57:39 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:47336 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268425AbUIWM5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 08:57:37 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
Date: Thu, 23 Sep 2004 09:57:29 -0300
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>
References: <20040907115722.GA10373@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
In-Reply-To: <20040923122838.GA9252@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230957.29318.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ingo Molnar wrote:
> i've released the -S4 VP patch:
>
>   
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm2-
>S4

  CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:287: warning: implicit declaration of function 
`redirect_hardirq'
arch/i386/kernel/irq.c:344: error: `noirqdebug' undeclared (first use in this 
function)
arch/i386/kernel/irq.c:344: error: (Each undeclared identifier is reported 
only once
arch/i386/kernel/irq.c:344: error: for each function it appears in.)
arch/i386/kernel/irq.c:345: warning: implicit declaration of function 
`note_interrupt'
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2


Regards,
Norberto
