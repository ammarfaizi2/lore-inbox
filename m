Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVCCQpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVCCQpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCCQpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:45:03 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38565 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261776AbVCCQo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:44:56 -0500
Message-Id: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering 
In-Reply-To: Message from Linus Torvalds <torvalds@osdl.org> 
   of "Wed, 02 Mar 2005 19:37:44 -0800." <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 03 Mar 2005 13:44:00 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 03 Mar 2005 13:44:02 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> > If we want a calming period, we need to do development like 2.4.x is 
> > done today.  It's sane, understandable and it works.

> No. It's insane, and the only reason it works is that 2.4.x is a totally
> different animal. Namely it doesn't have the kind of active development AT
> ALL any more. It _only_ has the "even" number kind of things, and quite 
> frankly, even those are a lot less than 2.6.x has.
> 
> > 2.6.x-pre: bugfixes and features
> > 2.6.x-rc: bugfixes only
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.
> 
> That's the whole point here, at least to me. I want to have people test 
> things out, but it doesn't matter how many -rc kernels I'd do, it just 
> won't happen. It's not a "real release".
> 
> In contrast, making it a real release, and making it clear that it's a 
> release in its own right, might actually get people to use it. 
> 
> Might. Maybe.

Then do away with -preX -rcY -bkZ altogether... just release 2.6.W. Faster
release cycle, much higher chance that "the next release" fixes brokenness
fast. The whole (or most of it) odd/even thinking went out the window with
the new development model.

[I'm pulling bk daily, and have it mixed with the ipw tree too, so I'm just
 the kind of tester you are looking for... haven't seen any of the
 showstopper bugs everybody is talking about, or I'd have screamed.]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
