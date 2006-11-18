Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756195AbWKRG7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbWKRG7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 01:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756197AbWKRG7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 01:59:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49371 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1756195AbWKRG7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 01:59:37 -0500
Date: Sat, 18 Nov 2006 07:58:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] make kernel/timer.c:__next_timer_interrupt() static
Message-ID: <20061118065838.GB32226@elte.hu>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117235947.GR31879@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117235947.GR31879@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.7 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.2929]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch makes the needlessly global __next_timer_interrupt() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ok.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
