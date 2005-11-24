Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVKXOqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVKXOqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKXOqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:46:07 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:45484 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751143AbVKXOqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:46:06 -0500
Date: Thu, 24 Nov 2005 15:46:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Akira Tsukamoto <akira-t@s9.dion.ne.jp>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix to clock running too fast
Message-ID: <20051124144613.GC1060@elte.hu>
References: <20051123035256.684C.AKIRA-T@s9.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123035256.684C.AKIRA-T@s9.dion.ne.jp>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Akira Tsukamoto <akira-t@s9.dion.ne.jp> wrote:

> This one line patch adds upper bound testing inside timer_irq_works() 
> when evaluating whether irq timer works or not on boot up.
> 
> It fix the machines having problem with clock running too fast.
> 
> What this patch do is, if  timer interrupts running too fast through 
> IO-APIC IRQ then false back to i8259A IRQ.

thanks - looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
