Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280966AbRKGU2C>; Wed, 7 Nov 2001 15:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRKGU1v>; Wed, 7 Nov 2001 15:27:51 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:36484 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280966AbRKGU1d>; Wed, 7 Nov 2001 15:27:33 -0500
Message-Id: <5.1.0.14.2.20011107202452.02b2a300@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Nov 2001 20:27:24 +0000
To: Andreas Dilger <adilger@turbolabs.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ext3 vs resiserfs vs xfs
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20011107132125.I5922@lynx.no>
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
 <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>
 <E161UYR-0004S5-00@the-village.bc.nu>
 <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:21 07/11/2001, Andreas Dilger wrote:
>On Nov 07, 2001  18:40 +0000, Anton Altaparmakov wrote:
> > Hm, while still on the default RH7.2 kernel using ext3 on all partitions I
> > flicked the reset switch accidentally (wrong reset switch it was...) and
> > when coming back up it fscked (I didn't touch anything - didn't even 
> notice
> > any 5 second thing but I wasn't looking at this screen) and it found two
> > lost inodes (I got two entries in lost and found). So it still needs to
> > fsck by the looks of it?
>
>Well, e2fsck will always run if the filesystem has an error marked in it.
>When was the last time you ran e2fsck on the fs before you converted to
>ext3?  It is possible that these lost inodes were in the fs before you
>converted?

It was a blank HD (well I had just installed Windows on it first so it 
wasn't quite blank any more) and then installed RH7.2 and told the 
installer to use ext3 for all the partitions. So it should be impossible 
that something is left over from before. There was nothing there... (-:

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

