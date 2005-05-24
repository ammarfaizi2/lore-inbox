Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVEXJDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVEXJDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVEXJDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:03:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28364 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261418AbVEXJDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:03:13 -0400
Date: Tue, 24 May 2005 11:02:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
Message-ID: <20050524090240.GA13129@elte.hu>
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4292E559.3080302@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Oh OK, I didn't realise it is aiming for hard RT. Cool! but
> that wasn't so much the main point I was trying to make...
> 
> >so it's well worth the effort, but there's no hurry and all the changes 
> >are incremental anyway. I can understand Daniel's desire for more action 
> >(he's got a product to worry about), but upstream isnt ready for this 
> >yet.
> >
> 
> Basically the same questions I think will still be up for debate. Not 
> that I want to start now, nor do I really have any feelings on the 
> matter yet (other than I'm glad you're not in a hurry :)).

i expect it to be pretty much like voluntary-preempt: there was much 
flaming 9 months ago and by today 99% of the voluntary-preempt patches 
are already in the upstream kernel and the remaining 1% (which just adds 
the config option and touches one include file) i didnt submit yet.

so i dont think there's much need to worry or even to decide anything 
upfront: the merge is already happening. The two biggest preconditions 
of PREEMPT_RT, the irq subsystem rewrite, and the spinlock-init API 
cleanups are already upstream. The rest is just details or out-of-line 
code. The discussions need to happen in small isolated steps, as the 
component technologies are merged and discussed. The components are all 
useful even without the final PREEMPT_RT step (which further proves the 
usefulness of PREEMPT_RT - but you dont have to agree with that global 
assertion).

So i'm afraid nothing radical will happen anywhere. Maybe we can have 
one final flamewar-party in the end when the .config options are about 
to be added, just for nostalgia, ok? =B-)

	Ingo
