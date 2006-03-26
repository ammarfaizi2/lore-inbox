Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWCZQrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWCZQrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCZQrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:47:00 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20688 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751424AbWCZQq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:46:59 -0500
Date: Sun, 26 Mar 2006 18:44:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPIN_LOCK_UNLOCKED
Message-ID: <20060326164424.GB23873@elte.hu>
References: <ff1cadb20603241356j7257f826n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1cadb20603241356j7257f826n@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4978]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> I noticed your 2.6.16-rt6 patch includes two calls to
> SPIN_LOCK_UNLOCKED(lockname) macro, the first one in
> arch/powerpc/kernel/rtas.c and the last one in
> include/asm-powerpc/rwsem.h.
> Is this the right behaviour?

you are right - i removed these leftovers from my tree.

	Ingo
