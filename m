Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129804AbQJ0SDO>; Fri, 27 Oct 2000 14:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbQJ0SDF>; Fri, 27 Oct 2000 14:03:05 -0400
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:40697 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129804AbQJ0SCs>; Fri, 27 Oct 2000 14:02:48 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200010271802.e9RI2ih04408@webber.adilger.net>
Subject: Re: Big file support in Linux 2.2
In-Reply-To: <85256985.00556CD3.00@SMTPNotes1.ma.lycos.com> "from jpranevich@lycos-inc.com
 at Oct 27, 2000 11:30:32 am"
To: jpranevich@lycos-inc.com
Date: Fri, 27 Oct 2000 12:02:44 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe writes:
> For one of our projects here, we've crashed head first into the 2 gig file
> size limitation in Linux 2.2 kernels. While I know that this has been solved
> in 2.3/2.4, has there been any work to backport this feature into a Linux 2.2
> kernel? I'm looking for a temporary solution until we can move to Linux 2.4
> directly, but obviously not until after it's been "really" released. :)

You can get a 2.2 LFS patch from:
http://www.scyld.com/software/lfs.html

There may be other sources.  You also need to have a newer glibc (or recompile
your own) to really support LFS.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
