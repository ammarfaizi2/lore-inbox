Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129950AbQLNIkC>; Thu, 14 Dec 2000 03:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQLNIjw>; Thu, 14 Dec 2000 03:39:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27556 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129950AbQLNIjl> convert rfc822-to-8bit;
	Thu, 14 Dec 2000 03:39:41 -0500
Date: Thu, 14 Dec 2000 03:09:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: josef höök <josef.hook@arrowhead.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <3A387F06.3F82F188@arrowhead.se>
Message-ID: <Pine.GSO.4.21.0012140307590.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, josef [iso-8859-1] höök wrote:

> Chip Salzenberg wrote:
> 
> > According to Alexander Viro:
> > > 9P is quite simple and unlike CORBA it had been designed for taking
> > > kernel stuff to userland.  Besides, authors definitely understand
> > > UNIX...
> >
> > As nice as 9P is, it'll need some tweaks to work with Linux.
> > For example, it limits filenames to 30 characters; that's not OK.
> > --
> > Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
> >    "Give me immortality, or give me death!"  // Firesign Theatre
> >
> 
> Another thing in mind that if we would want to use 9P we would also need to
> port IL .

It can live atop of TCP, it can live atop of AF_UNIX. IL would be nice for
more than one reason, though...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
