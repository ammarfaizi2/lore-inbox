Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbQLUDvo>; Wed, 20 Dec 2000 22:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQLUDve>; Wed, 20 Dec 2000 22:51:34 -0500
Received: from lazy.accessus.net ([209.145.148.14]:18 "EHLO lazy.accessus.net")
	by vger.kernel.org with ESMTP id <S130167AbQLUDv1>;
	Wed, 20 Dec 2000 22:51:27 -0500
Date: Wed, 20 Dec 2000 21:20:39 -0600 (CST)
From: Jay Weber <jay@lazy.accessus.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: nfs@lists.sourceforge.net, nfs-devel@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [NFS] kNFSd maintenance in 2.2.19pre
In-Reply-To: <14913.22373.943123.320678@notabene.cse.unsw.edu.au>
Message-ID: <Pine.OSF.4.21.0012202115060.23835-100000@lazy.accessus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

This sounds good.  Any plans on implementing a backport of the nfs
filesystem layer for handling inodes that you put together for
2.4.  Ie.. the code that reiserfs uses in 2.4 to properly work with knfsd
and inode issues.


On Thu, 21 Dec 2000, Neil Brown wrote:

> 
> Greeting all.
> 
>  Now that 2.2.18 is out with all the nfs (client and server) patches
>  that we were waiting for for so long, it is time to look at on-going
>  maintenance for knfsd.
> 
>  There are already a couple of issues that have come up and it is
>  quite possible that more will arise as the user-base grows.
>  Also, there are quite a few changes that have gone into 2.4 that
>  could usefully go into 2.2.
> 
>  I have discussed the issue of maintenance with Dave Higgen - the
>  maintainer of the knfsd patchset that finally went into 2.2.18, and
>  he is happy to leave knfsd for a while and let me run with it.
> 
>  So, I have started putting some patches together and they can be
>  found at
>     http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/
> 
>  They are mostly back ports of bits from 2.4 with a couple of real bug
>  fixes, one thanks to Chip Salzenberg and one which allows Solaris
>  clients to access /dev/null over NFSv3 properly.
> 
>  I hope to feed these patches to Alan for inclusion in 2.2.19-preX
>  early in the new year after I (and you?) have done a bit of testing.
> 
>  Note: the patches aren't all quite as independant as they should be
>  just at the moment (e.g. I made a patch, started on another and then
>  found a bug in the first, so the fix for the first ended up in the
>  second).  This will get sorted out next time I generate a patch set.
> 
> NeilBrown
> 
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> http://lists.sourceforge.net/mailman/listinfo/nfs
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
