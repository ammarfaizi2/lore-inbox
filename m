Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSA3Anx>; Tue, 29 Jan 2002 19:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287508AbSA3Ano>; Tue, 29 Jan 2002 19:43:44 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:2572 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287493AbSA3An1>; Tue, 29 Jan 2002 19:43:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: Your message of "Tue, 29 Jan 2002 18:20:44 MDT."
             <Pine.LNX.4.44.0201291813110.25443-100000@waste.org> 
Date: Wed, 30 Jan 2002 11:44:02 +1100
Message-Id: <E16Vir4-0005rs-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0201291813110.25443-100000@waste.org> you write:
> Yes, obviously.

Um... if it was so "obvious" why did you suggest it in the first
place? 8)

> Nearly as good would be replacing the current logic for figuring out the
> current processor id through current with logic to access the per-cpu
> data. The primary use of that id is indexing that data anyway.

And if you'd been reading this thread, you would have already seen
this idea, and if you'd read the x86 code, you'd have realised that
the tradeoff is arch-specific.

But thanks anyway: what this list really needs is more armchair kernel
hackers discussing code they haven't really thought about.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
