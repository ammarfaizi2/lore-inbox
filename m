Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279903AbRKRRMA>; Sun, 18 Nov 2001 12:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279904AbRKRRLu>; Sun, 18 Nov 2001 12:11:50 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:46341 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S279903AbRKRRLm>;
	Sun, 18 Nov 2001 12:11:42 -0500
Message-Id: <200111181710.fAIHAlCF011794@sleipnir.valparaiso.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, ehrhardt@mathematik.uni-ulm.de,
        linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1 
In-Reply-To: Your message of "Sat, 17 Nov 2001 22:24:44 -0800."
             <Pine.LNX.4.33.0111172220300.1290-100000@penguin.transmeta.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 18 Nov 2001 14:10:47 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:

[...]

> And nope, not really. It does use plain stores to page->flags, and I agree
> that it is ugly, but if the page was locked before calling it, all the
> stores will be with the PG_lock bit set - and even plain stores _are_
> documented to be atomic on x86 (and on all other reasonable architectures
> too).

Even unaligned stores?
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
