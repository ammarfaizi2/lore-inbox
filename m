Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935701AbWK1Imm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935701AbWK1Imm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935705AbWK1Imm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44219 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935701AbWK1Imi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:38 -0500
Date: Tue, 28 Nov 2006 08:03:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] cleanup arch/i386/kernel/smpboot.c:smp_tune_scheduling()
Message-ID: <20061128070330.GA27150@elte.hu>
References: <20061128012839.GU15364@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128012839.GU15364@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0145]
	0.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> This patch contains the following cleanups:
> - remove the write-only local variable "bandwidth"
> - don't set "max_cache_size" in the (cachesize < 0) case:
>   that's already handled in kernel/sched.c:measure_migration_cost()
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
