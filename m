Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTCOSIX>; Sat, 15 Mar 2003 13:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbTCOSIX>; Sat, 15 Mar 2003 13:08:23 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7601 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S261482AbTCOSIW>;
	Sat, 15 Mar 2003 13:08:22 -0500
Message-Id: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Thu, 13 Mar 2003 18:00:48 +0100."
             <20030313165652.7CF10109CC9@mx12.arcor-online.net> 
Date: Sat, 15 Mar 2003 12:21:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:
> On Thu 13 Mar 03 01:52, Horst von Brand wrote:

[...]

> > I don't think so. As the user sees it, a directory is mostly a convenient
> > labeled container for files. You think in terms of moving files around, not
> > destroying one and magically creating an exact copy elsewhere (even if
> > mv(1) does exactly this in some cases). Also, this breaks up the operation
> > "mv foo bar/baz" into _two_ changes, and this is wrong as the file loses
> > its revision history.

> No, that's a single change to one directory object.

mv some/where/foo bar/baz

How is that _one_ change to _one_ directory object?

> > > ...then this part gets much easier.
> >
> > ... by screwing it up. This is exactly one of the problems noted for CVS.
> 
> CVS doesn't have directory objects.

And it doesn't keep history across moves, as the only way it knows to move
a file is destroying the original and creating a fresh copy.

> Does anybody have a convenient mailing list for this design discussion?

Good idea to move this off LKML
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
