Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbRFYGSf>; Mon, 25 Jun 2001 02:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265340AbRFYGSZ>; Mon, 25 Jun 2001 02:18:25 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:19078 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S265097AbRFYGSL>; Mon, 25 Jun 2001 02:18:11 -0400
Date: Mon, 25 Jun 2001 00:18:04 -0600
Message-Id: <200106250618.f5P6I4t10073@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
In-Reply-To: <Pine.GSO.4.21.0106242226150.11019-100000@weyl.math.psu.edu>
In-Reply-To: <200106250212.WAA05336@soyata.home>
	<Pine.GSO.4.21.0106242226150.11019-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 24 Jun 2001, Marty Leisner wrote:
> 
> > I just installed redhat 7.1 on a system.
> > 
> > Cleaning up, a made a fs for home...(mounted on /mnt
> > to write the stuff to it)
> > 
> > Then I accidently mounted it on /home.
> > 
> > So it was mounted on /home and /mnt at the same time.
> > (I didn't bother going in to see what was there).
> 
> Same tree, obviously.
> 
> > Shouldn't this NOT happen?
> 
> Sigh... Guys, who maintains l-k FAQ?

You mean the LK mailing list FAQ? That would be me.

> Q: I've mounted filesystem in two different places and it worked. Why?
> A: Because you've asked to do that. Yes, it works. No, it's not a bug.
> 
> Q: what should I do to unmount it?
> A: umount <mountpoint>
> 
> Q: but that took care only of one of them. How can I deal with another?
> A: umount <another_mountpoint>

Patches to the LKML FAQ accepted :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
