Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280845AbRKGSkx>; Wed, 7 Nov 2001 13:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280898AbRKGSkn>; Wed, 7 Nov 2001 13:40:43 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:44275 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280845AbRKGSkd>; Wed, 7 Nov 2001 13:40:33 -0500
Message-Id: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Nov 2001 18:40:21 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ext3 vs resiserfs vs xfs
Cc: roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.30.0111071558090.29292-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:23 07/11/2001, Alan Cox wrote:
> > I just set up a RedHat 7.2 box with ext3, and after a few tests/chrashes,
> > I see no difference at all. After a chrash, it really wants to run fsck
> > anyway. I've tried ReiserFS before, with no fsck after chrashes - is this
>
>Umm RH 7.2 after an unexpected shutdown will give you a 5 second count down
>when you can choose to force an fsck - ext3 doesnt need an fsck but
>sometimes folks might want to force it thats all

Hm, while still on the default RH7.2 kernel using ext3 on all partitions I 
flicked the reset switch accidentally (wrong reset switch it was...) and 
when coming back up it fscked (I didn't touch anything - didn't even notice 
any 5 second thing but I wasn't looking at this screen) and it found two 
lost inodes (I got two entries in lost and found). So it still needs to 
fsck by the looks of it?

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

