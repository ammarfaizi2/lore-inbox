Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317844AbSGVSQk>; Mon, 22 Jul 2002 14:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSGVSQj>; Mon, 22 Jul 2002 14:16:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51078 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317844AbSGVSQj>;
	Mon, 22 Jul 2002 14:16:39 -0400
Date: Mon, 22 Jul 2002 14:19:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: martin@dalecki.de
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 devfs
In-Reply-To: <3D3C48D5.6080500@evision.ag>
Message-ID: <Pine.GSO.4.21.0207221412240.7619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jul 2002, Marcin Dalecki wrote:

> Richard Gooch wrote:
> > Marcin Dalecki writes:
> > 
> >>Kill two inlines which are notwhere used and which don't make sense
> >>in the case someone is not compiling devfs at all.
> > 
> > 
> > Rejected. Linus, please don't apply this bogus patch. External patches
> > and drivers rely on the inline stubs so that #ifdef CONFIG_DEVFS_FS
> > isn't needed.
> 
> Dare to actually *name* one of them?

[snip]

OK, that's enough.  Martin, kindly stay the fsck away from that pile of
garbage for a couple of weeks.

_All_ partition-related code is getting rewritten and the last thing
we need right now is additional clutter in the neighborhood.  And
devfs_fs_kernel.h, shite as it is, qualifies.

