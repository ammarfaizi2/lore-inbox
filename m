Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318520AbSGaWya>; Wed, 31 Jul 2002 18:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSGaWya>; Wed, 31 Jul 2002 18:54:30 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:7388 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318520AbSGaWy3>; Wed, 31 Jul 2002 18:54:29 -0400
Message-Id: <5.1.0.14.2.20020731235235.00b14ab0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 31 Jul 2002 23:58:15 +0100
To: Matt_Domsch@Dell.com
From: Anton Altaparmakov <aia21@cantab.net>
Subject: RE: 2.5.28 and partitions
Cc: peter@chubb.wattle.id.au, pavel@ucw.cz, viro@math.psu.edu,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <F44891A593A6DE4B99FDCB7CC537BBBBB839AC@AUSXMPS308.aus.amer
 .dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:47 31/07/02, Matt_Domsch@Dell.com wrote:
> > Maybe we need to roll our own?
>
>What's wrong with EFI GUID scheme (GPT) (other than it wasn't invented by
>Linux folks)?
[snip]
>Unless there's something that GPT doesn't do well, I'd prefer not to make
>yet another partitioning scheme.  If there is something else it needs, it
>can be extended.

And if there is something GPT doesn't do then there is Veritas LDM (also 
used in simplified form by Windows LDM) and the kernel understands it 
today. Admittedly none of the Linux partitioning tools support it yet but 
that is subject to change. (-; LDM is journalled, supports large numbers of 
disks, huge disks, all sorts of RAID, etc... I don't think you will find 
anything missing in that one...

So I fully agree that inventing yet another partitioning scheme is silly in 
view of the multitude of existing ones which do the job just fine. Feel 
free to prove me I am wrong by showing me something that GPT/LDM can't do...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

