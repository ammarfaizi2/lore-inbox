Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSEFU64>; Mon, 6 May 2002 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSEFU6z>; Mon, 6 May 2002 16:58:55 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:4105 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315179AbSEFU6y>; Mon, 6 May 2002 16:58:54 -0400
Message-Id: <5.1.0.14.2.20020506215725.01ffa120@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 06 May 2002 21:58:51 +0100
To: "Scott A. Sibert" <kernel@hollins.edu>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: 2.5.14 ntfs.o module unresolved symbols
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CD6CCF5.8090903@hollins.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you need to apply Andrew Morton's compile fix which he sent earlier or use 
the -dj kernel that Dave Jones just released.

Alternatively if you use bitkeeper you can pull the ntfs tree:

bk://linux-ntfs.bkbits.net/ntfs-tng-2.5

Best regards,

         Anton

At 19:35 06/05/02, Scott A. Sibert wrote:
>At make modules_install:
>
>depmod: *** Unresolved symbols in /lib/modules/2.5.14-01/kernel/fs/ntfs/ntfs.o
>depmod:     buffer_async
>depmod:     set_buffer_async
>depmod:     clear_buffer_async
>make: *** [_modinst_post] Error 1
>
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

