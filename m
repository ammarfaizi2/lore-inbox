Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281869AbRKWCyM>; Thu, 22 Nov 2001 21:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281870AbRKWCyC>; Thu, 22 Nov 2001 21:54:02 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:47062 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281869AbRKWCxr>; Thu, 22 Nov 2001 21:53:47 -0500
Message-Id: <5.1.0.14.2.20011123024713.00ae31c0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 02:49:23 +0000
To: Jeff Chua <jchua@fedex.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Filesize limit on SMBFS
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        Tyler BIRD <birdty@uvsc.edu>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex
 .com>
In-Reply-To: <20011122125759.K1308@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:35 23/11/01, Jeff Chua wrote:
>On Thu, 22 Nov 2001, Andreas Dilger wrote:
>
> > VFAT does have a 2GB limit, AFAIK, but I could be wrong.
>
>Use "mkdosfs -F32" or use msdos fdisk,format to get >2GB.
>
>I'm using 3GB for VFAT partition.

You mean you have 1) a single file with size 3GiB on a large VFAT partition 
or 2) the VFAT partition is 3GiB in itself?

1) is what we are talking about being limited to 2GiB.

2) Should indeed work fine under Linux and I don't think anyone is saying 
that this doesn't work.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

