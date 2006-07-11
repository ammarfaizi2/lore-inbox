Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWGKOdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWGKOdP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWGKOdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:33:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26056 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750867AbWGKOdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:33:15 -0400
Subject: Re: [patch] let CONFIG_SECCOMP default to n
From: Arjan van de Ven <arjan@infradead.org>
To: andrea@cpushare.com
Cc: Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060711141709.GE7192@opteron.random>
References: <20060629192121.GC19712@stusta.de>
	 <1151628246.22380.58.camel@mindpipe>
	 <20060629180706.64a58f95.akpm@osdl.org> <20060630014050.GI19712@stusta.de>
	 <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu>
	 <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu>
	 <20060711141709.GE7192@opteron.random>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:32:53 +0200
Message-Id: <1152628374.3128.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that I don't think Y or N makes any difference at the end for my
> project. But fedora could set it to N under your advice and that would
> do more damage to my project than whatever default setting we have

as far as I can see Fedora has SECCOMP off for a long time already

> Even if you seem to believe I don't care about the kernel when I talk
> about seccomp, I really think Y is the right setting for the kernel, and
> I'm not speaking for my own personal usages of seccomp, for the reason
> why you also agreed with it in the above email a few months ago.

if there is overhead, and there is no general use for it (which there
isn't really) then it should be off imo.


