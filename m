Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRCNE3c>; Tue, 13 Mar 2001 23:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRCNE3X>; Tue, 13 Mar 2001 23:29:23 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:7675 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131292AbRCNE3J>; Tue, 13 Mar 2001 23:29:09 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103140427.f2E4R9C06455@webber.adilger.int>
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <Pine.GSO.4.21.0103132130220.2506-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 13, 2001 09:32:38 pm"
To: Alexander Viro <viro@math.psu.edu>
Date: Tue, 13 Mar 2001 21:27:09 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>, LA Walsh <law@sgi.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> > What about if I want to know the mountpoint (inside the filesystem)
> > when it is mounted?
> 
> Which mountpoint? There can be a lot of them (quite possibly - some
> of them out of the chroot jail you are in, so "any" is unlikely to
> do you any good).

How about the first one?  The one that calls the "read_super" method.
AFAICT, only the first mount calls down to the FS anyways (the rest
is VFS internal).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
