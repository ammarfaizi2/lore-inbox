Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbTCGDLG>; Thu, 6 Mar 2003 22:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbTCGDLG>; Thu, 6 Mar 2003 22:11:06 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:31457 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261218AbTCGDLF>;
	Thu, 6 Mar 2003 22:11:05 -0500
Message-Id: <200303070319.h273JWeI012835@eeyore.valparaiso.cl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3 
In-Reply-To: Your message of "Thu, 06 Mar 2003 09:03:03 -0800."
             <Pine.LNX.4.44.0303060858120.7206-100000@home.transmeta.com> 
Date: Fri, 07 Mar 2003 00:19:32 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> said:
> On Thu, 6 Mar 2003, Ingo Molnar wrote:
> > the whole compilation (gcc tasks) will be rated 'interactive' as well,
> > because an 'interactive' make process and/or shell process is waiting on
> > it.
> 
> No. The make that is waiting for it will be woken up _once_ - when the 
> thing dies. Marking it interactive at that point is absolutely fine.

It is woken up each time one Makefile line has been processed, to call the
next one.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
