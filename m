Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280479AbRKFUOd>; Tue, 6 Nov 2001 15:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280517AbRKFUOY>; Tue, 6 Nov 2001 15:14:24 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57021 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280479AbRKFUOR>; Tue, 6 Nov 2001 15:14:17 -0500
Date: Tue, 6 Nov 2001 13:14:07 -0700
Message-Id: <200111062014.fA6KE7q29956@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0111060215560.27713-100000@weyl.math.psu.edu>
In-Reply-To: <200111060714.fA67EfX20893@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111060215560.27713-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Tue, 6 Nov 2001, Richard Gooch wrote:
> 
> > > BTW, new code still has both aforementioned races - detaching
>                                  ^^^^^^^^^^^^^^
> > > entries from the tree doesn't help with that.
> > 
> > Which "both"? You sent quite a few messages, listing more than two
> > races. I'm still wading through the list.
> 
> Sorry - trimmed more than I should have.  Ones mentioned in the
> message you were replying to - unregister() on parent vs. mknod() or
> unlink().

Ah, those. Next patch (just released) cleans that up a bit more. This
stuff is still a work in progress.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
