Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWFHUDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWFHUDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWFHUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:03:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53206 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964958AbWFHUDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:03:42 -0400
Date: Thu, 8 Jun 2006 22:02:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: warning at kernel/lockdep.c:2427/check_flags()
Message-ID: <20060608200256.GA12171@elte.hu>
References: <20060608213809.101161b0@localhost> <20060608215935.37c52bff@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060608215935.37c52bff@localhost>
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


* Paolo Ornati <ornati@fastwebnet.it> wrote:

> > I don't know if/how it is reproducible.
> 
> Wow, now I can reproduce it easly :)
> 
> Just run under "gdb" a program that segfaults:
> 
> void main(void)
> {
>         *(int*)(0) = 1;
> }
> 
> and it will trigger.

thanks alot, that's very helpful! I'll have a look.

	Ingo
