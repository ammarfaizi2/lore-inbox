Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133112AbRDRNAG>; Wed, 18 Apr 2001 09:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133114AbRDRM75>; Wed, 18 Apr 2001 08:59:57 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:51342 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S133112AbRDRM7u>; Wed, 18 Apr 2001 08:59:50 -0400
Message-Id: <5.0.2.1.2.20010418135757.00ad5680@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 18 Apr 2001 14:01:59 +0100
To: James Lewis Nance <jlnance@intrex.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH][CFT] ext2 directories in pagecache
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010418084420.A857@bessie.dyndns.org>
In-Reply-To: <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>
 <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:44 18/04/2001, James Lewis Nance wrote:
>On Thu, Apr 12, 2001 at 12:33:42PM -0400, Alexander Viro wrote:
> >       Folks, IMO ext2-dir-patch got to the stable stage. Currently
> > it's against 2.4.4-pre2, but it should apply to anything starting with
> > 2.4.2 or so.
>
>Have you had any feedback about this patch?  I applied it last night to
>2.4.3.  It seemed to work.  When I booted my computer this morning fsck
>complained about problems with the directory on one of my ext2 file systems.
>Since fsck does not run on every boot I dont really have a way of knowing if
>this has anything to do with your patch or not.  I'm running the patched
>kernel again right now.  Ill shutdown and force an fsck later today to see
>if anything shows up.

Well, here is some feedback. I have been using this patch for quite a while 
now without any problems what so ever. Including "make -j bzImage" on a 
dual cpu machine and normal use of a productions system. - Frequent crashes 
during ntfs development (and hence frequent reboots + fsck) have not shown 
up any problems in ext2 + this patch, either. - It seems to be stable all 
right on two different PCs (one SMP, celeron and one UP, pentium 133s).

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

