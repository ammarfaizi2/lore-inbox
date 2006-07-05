Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWGELv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWGELv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWGELv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:51:58 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:4247 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964826AbWGELv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:51:57 -0400
Date: Wed, 5 Jul 2006 13:47:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386: early pagefault handler
Message-ID: <20060705114714.GA3275@elte.hu>
References: <200607050745_MC3-1-C42B-9937@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607050745_MC3-1-C42B-9937@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5049]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Page faults during kernel initialization can be hard to diagnose.
> 
> Add a handler that prints the fault address, EIP and top of stack when 
> an early page fault happens.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

nice!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
