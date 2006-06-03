Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWFCHtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWFCHtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFCHtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:49:00 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23241 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964887AbWFCHs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:48:59 -0400
Date: Sat, 3 Jun 2006 09:49:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, "'Con Kolivas'" <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix smt nice lock contention and optimization
Message-ID: <20060603074920.GB20229@elte.hu>
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> ---
> 
>  sched.c |  168 ++++++++++++++++++----------------------------------------------
>  1 files changed, 48 insertions(+), 120 deletions(-)

looks really good now to me.

 Signed-off-by: Ingo Molnar <mingo@elte.hu>

lets try it in -mm?

	Ingo
