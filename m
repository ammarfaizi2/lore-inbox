Return-Path: <linux-kernel-owner+w=401wt.eu-S1762683AbWLKJbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762683AbWLKJbJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762689AbWLKJbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:31:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46714 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762683AbWLKJbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:31:07 -0500
Date: Mon, 11 Dec 2006 10:29:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] drop some kruft
Message-ID: <20061211092913.GC23041@elte.hu>
References: <20061210161159.321405000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210161159.321405000@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.0597]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> -#ifdef CONFIG_PREEMPT_RT
> -		if (irqs_disabled()) {
> -			msg = "disabled hard interrupts";
> -			local_irq_enable();
> -		}
> -#endif

thanks, applied.

	Ingo
