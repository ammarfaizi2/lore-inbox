Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129605AbQLNFR5>; Thu, 14 Dec 2000 00:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbQLNFRr>; Thu, 14 Dec 2000 00:17:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34026 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129605AbQLNFRa>;
	Thu, 14 Dec 2000 00:17:30 -0500
Date: Wed, 13 Dec 2000 23:47:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chip Salzenberg <chip@valinux.com>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <20001213204239.L864@valinux.com>
Message-ID: <Pine.GSO.4.21.0012132346060.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chip Salzenberg wrote:

> According to Alexander Viro:
> > On Wed, 13 Dec 2000, Chip Salzenberg wrote:
> > > According to Alexander Viro:
> > > > 9P is quite simple and unlike CORBA it had been designed for taking
> > > > kernel stuff to userland.  Besides, authors definitely understand
> > > > UNIX...
> > > 
> > > As nice as 9P is, it'll need some tweaks to work with Linux.
> > > For example, it limits filenames to 30 characters; that's not OK.
> > 
> > For RPC-style uses? Why?
> 
> For the same reason C compilers recognize more than eight significant
> characters in externals, even though ANSI doesn't require them to.

s/30/255/ and you've got a big problem with ext2...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
