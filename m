Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270590AbRHIVAo>; Thu, 9 Aug 2001 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRHIVAe>; Thu, 9 Aug 2001 17:00:34 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:43513 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270596AbRHIVAW>; Thu, 9 Aug 2001 17:00:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108092058.f79KwIKn024532@webber.adilger.int>
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
In-Reply-To: <440850000.997389251@tiny> "from Chris Mason at Aug 9, 2001 04:34:11
 pm"
To: Chris Mason <mason@suse.com>
Date: Thu, 9 Aug 2001 14:58:18 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu, lvm-devel@sistina.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris, you write:
> Andreas Dilger <adilger@turbolinux.com> wrote:
> > On an "add this patch to the kernel, please" note, support for the
> > write_super_lockfs() VFS method is already in ext3, so it is a good
> > thing, with the above caveats.
> 
> Ok, recoding with these suggestions.  I'll need an ext3 tester, please
> drop me a line if you are willing ;-)

Consider it tested.  I already have my code changed like I suggested, but
never heard back the last time I mentioned it.  In the end I don't think
the changes can have a behaviour impact other than a small CPU savings,
and a few lines of comments removed.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

