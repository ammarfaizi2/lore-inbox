Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287948AbSAHGaB>; Tue, 8 Jan 2002 01:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287947AbSAHG3w>; Tue, 8 Jan 2002 01:29:52 -0500
Received: from dsl-213-023-038-159.arcor-ip.net ([213.23.38.159]:34564 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287945AbSAHG3s>;
	Tue, 8 Jan 2002 01:29:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
Date: Tue, 8 Jan 2002 07:32:25 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <5.1.0.14.2.20020107134718.025e4d90@pop.cus.cam.ac.uk> <E16NbmV-0001R0-00@starship.berlin> <3C3A12A5.196C81B7@mandrakesoft.com>
In-Reply-To: <3C3A12A5.196C81B7@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NpoB-00006w-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2002 10:27 pm, Jeff Garzik wrote:
> Daniel Phillips wrote:
> > On January 7, 2002 03:13 pm, Anton Altaparmakov wrote:
> > > Of course fs which are not adapted would still just work with the fs_i()
> > > and fs_sb() macros and/or using two separate pointers.
> > 
> > Yes, the fs_* macros are the really critical part of all this.  I'd like to
> > get them in early, while we hash out the rest of it.  I think Jeff supports
> > me in this, possibly Al as well.
> 
> agreed, from my side

OK, are we agreed that:

  - We're waiting for Al to merge ext/*alloc.c changes

  - When that's done we will apply what would be my unbork patches (2: ext2_i) and
    (3: ext2_sb) to both 2.4.current and 2.5.current?  Subject to getting these two
    patches into the form everybody likes, of course.

  - We have some time in the interim to figure out how best to unbork fs.h, but we
    all agree it needs to be done soon.

--
Daniel
