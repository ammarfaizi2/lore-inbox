Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWCHAoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWCHAoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWCHAoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:44:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10222 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964866AbWCHAoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:44:15 -0500
Date: Wed, 8 Mar 2006 01:43:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [patch] i386 spinlocks: disable interrupts only if we enabled them
Message-ID: <20060308004308.GA16069@elte.hu>
References: <200603071837_MC3-1-BA13-E5FB@compuserve.com> <20060307161550.27941df5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307161550.27941df5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3999]
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> And it's increasing text size.  Which wouldn't be a big problem if the 
> spinning code was still in an out-of-line section, but it isn't any 
> more.
> 
> (I forget why we undid that optimisation.  What was wrong with it?)

we dont inline that code anymore. So i think the optimization is fine.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
