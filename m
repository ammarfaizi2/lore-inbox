Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTCOVZl>; Sat, 15 Mar 2003 16:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbTCOVZl>; Sat, 15 Mar 2003 16:25:41 -0500
Received: from adsl-64-165-208-253.dsl.snfc21.pacbell.net ([64.165.208.253]:6065
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261525AbTCOVZj>; Sat, 15 Mar 2003 16:25:39 -0500
Subject: Re: BitBucket: GPL-ed KitBeeper clone
From: Robert Anderson <rwa@alumni.princeton.edu>
To: Daniel Phillips <phillips@arcor.de>, lkml <linux-kernel@vger.kernel.org>
Cc: arch <arch-users@lists.fifthvision.net>
In-Reply-To: <20030315212205.CDE923D979@mx01.nexgo.de>
References: <200303151621.h2FGLgaD003246@eeyore.valparaiso.cl> 
	<20030315212205.CDE923D979@mx01.nexgo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Mar 2003 13:53:34 -0800
Message-Id: <1047765218.9619.124.camel@lan1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 13:25, Daniel Phillips wrote:
> On Sat 15 Mar 03 17:21, Horst von Brand wrote:
> > Daniel Phillips <phillips@arcor.de> said:
> > > On Thu 13 Mar 03 01:52, Horst von Brand wrote:
> >
> > [...]
> >
> > > > I don't think so. As the user sees it, a directory is mostly a
> > > > convenient labeled container for files. You think in terms of moving
> > > > files around, not destroying one and magically creating an exact copy
> > > > elsewhere (even if mv(1) does exactly this in some cases). Also, this
> > > > breaks up the operation "mv foo bar/baz" into _two_ changes, and this
> > > > is wrong as the file loses its revision history.
> > >
> > > No, that's a single change to one directory object.
> >
> > mv some/where/foo bar/baz
> >
> > How is that _one_ change to _one_ directory object?
> 
> Oops, sorry, I didn't read your bar/baz correctly.  Yes, it's two directory 
> objects, but it's only one file object, and the history (not including the 
> name changes) is attached to the file object, not the directory object.  This 
> is implemented via an object id for each file object, something like an inode 
> number.
> 
> > > > > ...then this part gets much easier.
> > > >
> > > > ... by screwing it up. This is exactly one of the problems noted for
> > > > CVS.
> > >
> > > CVS doesn't have directory objects.
> >
> > And it doesn't keep history across moves, as the only way it knows to move
> > a file is destroying the original and creating a fresh copy.
> 
> Ah, but it does.  Sorry for not explaining the object id thing earlier.
> 
> > > Does anybody have a convenient mailing list for this design discussion?
> >
> > Good idea to move this off LKML
> 
> Yup, but nobody has offered one yet, so...

I think the arch-users@lists.fifthvision.net list would be happy to host
continuing discussion in this vein.  Considering Larry's repeated
attempts to get people to look at arch as a "better fit," it seems
particularly appropriate.

Of course, you'd have to tolerate "arch community" views on a lot of
these issues, but I suspect that might help focus the discussion.

Bob


