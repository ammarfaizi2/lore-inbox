Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281647AbRKZMlj>; Mon, 26 Nov 2001 07:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281650AbRKZMl3>; Mon, 26 Nov 2001 07:41:29 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:37906 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S281647AbRKZMlU>; Mon, 26 Nov 2001 07:41:20 -0500
Message-Id: <200111261241.fAQCfAH3028926@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1] 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Sun, 25 Nov 2001 19:58:41 -0800." <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com> 
Date: Mon, 26 Nov 2001 09:41:10 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:

[...]

> The _real_ solution is to make fewer fundamental changes between stable
> kernels, and that's a real solution that I expect to become more and more
> realistic as the kernel stabilizes. I already expect 2.5 to have a _lot_
> less fundamental changes than the 2.3.x tree ever had - the SMP
> scaliability efforts and page-cachification between 2.2.x and 2.4.x is
> really quite a big change.

As a (mostly) bystander to kernel development here in lkml I see that there
are largeish areas in the kernel where ancient legacy, old, and new
mechanisms coexist. How about going _just_ for a big spring cleanup (Yep,
it _is_ spring around here ;-) (including kbuild, CML2, cutting everything
over to tasklets, getting rid of legacy timers, go after the results of the
Stanford checker, make the kernel-janitors work overtime, ...), going for
2.6 in a short(ish) time, and leave 2.7 for really new stuff? It should be
easier to do new development on a more uniform base (besides, having to
remember several ways to do things and the ugliness of it all does detract
from the fun of kernel development, which is the central objective AFAIU).
It should also naturally cut down the time between new stable releases.
Just too bad Halloween is now past, the moaning here would have added to
the spirit ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
