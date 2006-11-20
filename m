Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966473AbWKTTYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966473AbWKTTYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966471AbWKTTYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:24:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5351 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966473AbWKTTYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:24:32 -0500
Date: Mon, 20 Nov 2006 20:23:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi type IRQ handlers
Message-ID: <20061120192335.GA3372@elte.hu>
References: <4561C9EC.3020506@ru.mvista.com> <20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com> <20061120172642.GA8683@elte.hu> <20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com> <20061120191013.GA30828@elte.hu> <20061120191149.GA32537@elte.hu> <4561FF9D.9040903@ru.mvista.com> <45620108.6020705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45620108.6020705@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> >>	if (redirect_hardirq(desc)) {
> >>-		mask_ack_irq(desc, irq);
> >>-		goto out_unlock;
> 
>    That label would generate a warning though. Should be gotten rid of now.

yep, gone in my tree.

	Ingo
