Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280945AbRKGTk5>; Wed, 7 Nov 2001 14:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKGTkr>; Wed, 7 Nov 2001 14:40:47 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:63229 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280941AbRKGTkj>; Wed, 7 Nov 2001 14:40:39 -0500
Message-Id: <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 07 Nov 2001 19:40:27 +0000
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ext3 vs resiserfs vs xfs
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roy@karlsbakk.net (Roy Sigurd Karlsbakk), linux-kernel@vger.kernel.org
In-Reply-To: <E161Y87-00052r-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:12 07/11/2001, Alan Cox wrote:
> > when coming back up it fscked (I didn't touch anything - didn't even 
> notice
> > any 5 second thing but I wasn't looking at this screen) and it found two
> > lost inodes (I got two entries in lost and found). So it still needs to
> > fsck by the looks of it?
>
>That sounds like you used your own kernel with it and had ext2 mounting
>the root fs (remember its back compatible)

Yes, that makes a lot of sense. After the reset I went into my own kernel 
with both ext2 and ext3 compiled into it. However, before the reboot, I was 
still in the RH kernel (99% sure it was so, but my memory might be 
deceiving me).

Is there any Right Way(TM) to fix this situation considering I want to have 
both ext2 and ext3 in my kernels (apart from the obvious of changing the 
order fs are called during root mount in the kernel)?

Thanks,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

