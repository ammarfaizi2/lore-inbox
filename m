Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRKFHPH>; Tue, 6 Nov 2001 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278566AbRKFHO5>; Tue, 6 Nov 2001 02:14:57 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:39100 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S278364AbRKFHOq>; Tue, 6 Nov 2001 02:14:46 -0500
Date: Tue, 6 Nov 2001 00:14:41 -0700
Message-Id: <200111060714.fA67EfX20893@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0111060204161.27713-100000@weyl.math.psu.edu>
In-Reply-To: <200111060635.fA66ZIH20196@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111060204161.27713-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 5 Nov 2001, Richard Gooch wrote:
> 
> > Yep, as I've long ago admitted, there are races in the old devfs
> > code, which couldn't be fixed without proper locking. And that's why
> > I've been wanting to add said locking for ages, and have been
> > frustrated at interruptions which delayed that work. And I'm very
> > happy to get the first cut of the new code released.
> 
> BTW, new code still has both aforementioned races - detaching
> entries from the tree doesn't help with that.

Which "both"? You sent quite a few messages, listing more than two
races. I'm still wading through the list.

> > That said, try to understand (before getting emotional and launching
> > off a tirade such as the one last week) that different people have
> > different priorities, and mine was to provide functionality first, and
> > worry about hostile attacks/exploits later. This is not unreasonable
> > if you consider that the initial target machines for devfs were:
> > - my personal boxes (which are not public machines)
> > - big-iron machines sitting behind a firewall
> > - small university group sitting behind a firewall (and I know where
> >   all the users live:-)
> 
> That's nice, but that had stopped being the case as soon as you've
> proposed devfs for inclusion into the tree...

Marked CONFIG_EXPERIMENTAL...

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
