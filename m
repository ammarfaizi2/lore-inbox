Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132614AbQK3Cwk>; Wed, 29 Nov 2000 21:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132573AbQK3CwC>; Wed, 29 Nov 2000 21:52:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25107 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S130372AbQK3Cvx>;
        Wed, 29 Nov 2000 21:51:53 -0500
Date: Wed, 29 Nov 2000 20:15:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: usbdevfs mount 2x, umount 1x
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDA5@orsmsx31.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0011292014090.17068-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Dunlap, Randy wrote:

> > From: Alexander Viro [mailto:viro@math.psu.edu]
> > 
> > On Wed, 29 Nov 2000, Randy Dunlap wrote:
> > 
> > > [I reported this a couple of months back.  Got no
> > > feedback on it.  If it's just a DDT (don't do that)
> > > or a user error, please say so.]
> > > 
> > > Summary:  After I mount usbdevfs 2 times, and umount it
> > > 1 time, the usbcore module use count prevents it from
> > > being rmmod-ed.
> > 
> > So umount it twice.
> I don't see a way to umount it twice or I would have done that.
> Is there a way?

Erm... Say umount one more time? If _that_ doesn't work - we've got a
bug, either in umount(2) or in umount(8). Strace would be welcome.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
