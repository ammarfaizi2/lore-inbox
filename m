Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWGKMSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWGKMSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 08:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGKMSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 08:18:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:28880 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751241AbWGKMSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 08:18:09 -0400
Date: Tue, 11 Jul 2006 14:12:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: commit '[PATCH] kernel/softirq.c: EXPORT_UNUSED_SYMBOL'
Message-ID: <20060711121226.GA12679@elte.hu>
References: <20060711120159.GA20601@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711120159.GA20601@lst.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@lst.de> wrote:

> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=80d6679a62fe45f440d042099d997a42e4e8c59d
> 
> open_softirq just enables a softirq.  The softirq array is statically 
> allocated so to add a new one you would have to patch the kernel.  So 
> there's no point to keep this export at all as any user would have to 
> patch the enum in include/linux/interrupt.h anyway.  Adrian, care to 
> submit a patch to kill this senseless export entirely?

good point.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
