Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWGMUWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWGMUWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWGMUWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:22:08 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9415 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030356AbWGMUWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:22:06 -0400
Date: Thu, 13 Jul 2006 22:16:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [2.6 patch] let the the lockdep options depend on DEBUG_KERNEL
Message-ID: <20060713201632.GA29089@elte.hu>
References: <20060713201838.GD32259@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713201838.GD32259@stusta.de>
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


* Adrian Bunk <bunk@stusta.de> wrote:

> The lockdep options should depend on DEBUG_KERNEL since:
> - they are kernel debugging options and
> - they do otherwise break the DEBUG_KERNEL menu structure
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

yeah.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
