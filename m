Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261536AbTCOSLw>; Sat, 15 Mar 2003 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCOSJy>; Sat, 15 Mar 2003 13:09:54 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60082 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261511AbTCOSJK>;
	Sat, 15 Mar 2003 13:09:10 -0500
Message-Id: <200303151417.h2FEHNV9002747@eeyore.valparaiso.cl>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "13 Mar 2003 15:57:10 GMT."
             <1047571030.5373.161.camel@passion.cambridge.redhat.com> 
Date: Sat, 15 Mar 2003 10:17:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:
> On Thu, 2003-03-13 at 01:03, Horst von Brand wrote:

[...]

> > Wrong. Edit a header adding a new type T. Later change an existing file
> > that already includes said header to use T. Change a function, fix most
> > uses. Find a wrong usage later and fix it separately. Change something, fix
> > its Documentation/ later. Note how you can come up with dependent changes
> > that _can't_ be detected automatically.

> True. And this is the main reason I hate BitKeeper. I really don't give
> a rat's arse about the licence -- but I object strongly to the way it
> enforces a false ordering of changesets. 

The dependency among changes is a partial order, the sequence in which they
were applied is one valid topological sort of that, and the only valid one
known to the SCM. Asking the user to provide the complete dependencies is
error prone at very best.

> Assuming no ordering is wrong. But likewise, assuming the order in which
> changes _happened_ to occur is also wrong,

But much less so.

>                                            and _enforcing_ that is more
> wrong. 

What else can you do?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
