Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSGHVHE>; Mon, 8 Jul 2002 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317165AbSGHVHE>; Mon, 8 Jul 2002 17:07:04 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:20096 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317152AbSGHVHD>; Mon, 8 Jul 2002 17:07:03 -0400
Message-Id: <5.1.0.14.2.20020708220117.02855ad0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Jul 2002 22:10:39 +0100
To: Axel Siebenwirth <axel@hh59.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: NTFS write support [was: NTFS: 2.0.15]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020708205206.GA2866@neon.hh59.org>
References: <5.1.0.14.2.20020708192448.028f5ec0@pop.cus.cam.ac.uk>
 <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
 <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
 <5.1.0.14.2.20020708192448.028f5ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:52 08/07/02, Axel Siebenwirth wrote:
>On Mon, 08 Jul 2002, Anton Altaparmakov wrote:
> > No, we have a pretty good idea of ntfs now. But it is a complicated fs and
>
>That is one thing I'd really be interested in kernel development since I
>have some own interest in it. Is there some resource on the internet where
>can get the necessary information to have a look into understanding NTFS
>write support and maybe help with it.

In the kernel source fs/ntfs/layout.h is a header file describing the full 
on disk layout of NTFS (except journalling and encryption).

We have html documentation about ntfs on our linux-ntfs website (note if 
you see conflicting information between the documentation and layout.h 
always take layout.h to be correct, there still some discrepancies which we 
need to iron out...). You can go directly to the documentation by going to 
this url:

         http://linux-ntfs.sf.net/ntfs/

Our user space library and tools can also be helpful, especially I have 
written some documents and placed them in the linux-ntfs/doc directory. You 
can just download linux-ntfs 1.6.0 and read the documentation there. But 
the code in 1.6.0 is very out of date. The library has been pretty much 
completely rewritten, massively cleaned up, and the functionality has been 
extended. You can get all the goodies from cvs. For instructions see here:

         http://sf.net/cvs/?group_id=13956


Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

