Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268814AbTBZQxQ>; Wed, 26 Feb 2003 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268817AbTBZQxQ>; Wed, 26 Feb 2003 11:53:16 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46466 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S268814AbTBZQxP>;
	Wed, 26 Feb 2003 11:53:15 -0500
Message-Id: <200302261702.h1QH2WL2004926@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-Reply-To: Your message of "Wed, 26 Feb 2003 15:13:09 +1100."
             <20030226041359.C54792C04C@lists.samba.org> 
Date: Wed, 26 Feb 2003 18:02:31 +0100
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message
> <Pine.LNX.4.44.0302251930280.13501-100000@chaos.physics.uiowa.edu> you
> write:

[...]

> > Also, I don't really see any use for __optional at this point, so why add 
> > it at all?

> >From ip_conntrack_core.c:

> #ifdef CONFIG_SYSCTL
> [snipped largeish data structure]
> #endif /*CONFIG_SYSCTL*/
> 
> I'd love to frop the #ifdef and just mark them __optional: before that
> would just mean bloat, but when gcc 3.3 rolls in, they should vanish
> nicely.

If gcc will just discard it, why bother marking it specially? Unless it
gives ugly warnings, that is.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
