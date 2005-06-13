Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFMGQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFMGQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFMGQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:16:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63917 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261371AbVFMGQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:16:22 -0400
Date: Mon, 13 Jun 2005 08:09:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050613060914.GA10613@elte.hu>
References: <20050608112801.GA31084@elte.hu> <200506120940.11698.gene.heskett@verizon.net> <20050612134907.GA17467@elte.hu> <200506122211.04152.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506122211.04152.gene.heskett@verizon.net>
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

> but had to interrupt the boot & go back to 48-13 as I was drowning in 
> a near DOS caused by:
> 
> Jun 12 21:54:16 coyote kernel: BUG: scheduling while atomic: softirq-timer/0/0x10000100/3
> Jun 12 21:54:16 coyote kernel: caller is __cond_resched+0x3d/0x50

ok, fixed this one - does -48-19 work for you? (PREEMPT_DESKTOP was 
broken by the new split-softirqs code)

	Ingo
