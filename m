Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRACMbl>; Wed, 3 Jan 2001 07:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131575AbRACMbb>; Wed, 3 Jan 2001 07:31:31 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3826 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131309AbRACMbV>;
	Wed, 3 Jan 2001 07:31:21 -0500
Date: Wed, 3 Jan 2001 07:00:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Dan Aloni <karrde@callisto.yi.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops in prune_dcache (2.4.0-prerelease)
In-Reply-To: <3A530A93.BCB19B0D@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.GSO.4.21.0101030657120.15658-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2001, Udo A. Steinberg wrote:

> Dan Aloni wrote:
> > 
> > After a bit of few code reviewing, it looks like the only code that
> > assigns stuff to ->d_op in a nonstandard way is in fs/vfat/namei.c.
> > 
> > Udo, are you using vfat?
> 
> Yes.

In principle, it might be that d_find_alias() is broken. I don't see where
it could happen, but then I'm half-asleep right now...  While we are at it,
do you have
	* autofs
	* knfsd
	* ncpfs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
