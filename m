Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbTCMMoR>; Thu, 13 Mar 2003 07:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbTCMMoQ>; Thu, 13 Mar 2003 07:44:16 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43939 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262276AbTCMMnt>;
	Thu, 13 Mar 2003 07:43:49 -0500
Message-Id: <200303130052.h2D0qFFT001062@eeyore.valparaiso.cl>
To: Daniel Phillips <phillips@arcor.de>
cc: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Wed, 12 Mar 2003 14:22:22 +0100."
             <20030312131822.B2F184085B@mx01.nexgo.de> 
Date: Wed, 12 Mar 2003 20:52:15 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> said:
> On Wed 12 Mar 03 04:47, Horst von Brand wrote:
> > ...You need to focus on changes to files,
> > not files. I.e., file appeared/dissapeared/changed name/was edited by
> > altering lines so and so.

> It's useful to make the distinction that "file appeared/dissapeared/changed 
> name" are changes to a directory object, while "was edited by altering lines 
> so and so" is a change to a file object...

I don't think so. As the user sees it, a directory is mostly a convenient
labeled container for files. You think in terms of moving files around, not
destroying one and magically creating an exact copy elsewhere (even if
mv(1) does exactly this in some cases). Also, this breaks up the operation
"mv foo bar/baz" into _two_ changes, and this is wrong as the file loses
its revision history.

> [...]
> 
> > > This consists of allowing developers to rename files and directories, and
> > > have all repository operations properly recognize and handle this.
> >
> > And create and destroy. Note "rename" must include moving directories
> > around, and moving stuff from one directory to another, etc.
> 
> ...then this part gets much easier.

... by screwing it up. This is exactly one of the problems noted for CVS.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
