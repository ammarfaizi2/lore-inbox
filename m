Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSGXIxI>; Wed, 24 Jul 2002 04:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSGXIxI>; Wed, 24 Jul 2002 04:53:08 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:3288 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313060AbSGXIxH>; Wed, 24 Jul 2002 04:53:07 -0400
Message-Id: <5.1.0.14.2.20020724095418.00b09270@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 24 Jul 2002 09:56:17 +0100
To: "James H. Cloos Jr." <cloos@jhcloos.com>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: bk://linux.bkbits.net/linux-2.[45] pull error
Cc: linux-kernel@vger.kernel.org, bitkeeper-users@bitmover.com
In-Reply-To: <m37kjlmt2k.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this error, too. I then rm -rf the repository and did a fresh clone 
from bkbits which went fine. I was also able to successfully pull from the 
new local repository to another local repository. But trying to push back 
to bkbits gave me an error:

Applying   4 revisions to arch/ppc64/Makefile get: getdiffs temp file early EOF

========================== ERROR ========================
unable to create diffstakapatch: patch left in PENDING/2002-07-24.03
========================== ERROR ========================

I tried three times... All the same error.

So must be something wrong with bkbits...

Best regards,

         Anton

At 09:24 24/07/02, James H. Cloos Jr. wrote:
>I'm getting this all of a sudden:
>
>:; cd linux-2.4
>:; bk parent
>Parent repository is bk://linux.bkbits.net/linux-2.4
>:; bk pull
>---------------------- Receiving the following csets -----------------------
>1.652 1.651 1.650 1.649 1.648
>----------------------------------------------------------------------------
>ChangeSet fnext: No such file or directory
>
>=================================== ERROR ====================================
>takepatch: missing checksum line in patch, aborting.
>==============================================================================
>
>666 bytes uncompressed to 1222, 1.83X expansion
>:; cd ../linux-2.5
>:; bk parent
>Parent repository is bk://linux.bkbits.net/linux-2.5
>:; bk pull
>---------------------- Receiving the following csets -----------------------
>1.684 1.683 1.681.1.1 1.682 1.681 1.680 1.679 1.678 1.677
>1.676 1.675 1.674 1.673 1.672 1.671 1.670 1.669 1.668 1.667
>1.666
>----------------------------------------------------------------------------
>ChangeSet fnext: No such file or directory
>
>=================================== ERROR ====================================
>takepatch: missing checksum line in patch, aborting.
>==============================================================================
>
>344 bytes uncompressed to 710, 2.06X expansion
>
>
>
>Is this a bkbits issue or something wrong on my side?
>
>-JimC
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

