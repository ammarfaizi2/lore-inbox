Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbRFANWi>; Fri, 1 Jun 2001 09:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263504AbRFANW2>; Fri, 1 Jun 2001 09:22:28 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:4094 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S263501AbRFANWS>; Fri, 1 Jun 2001 09:22:18 -0400
Message-Id: <5.1.0.14.2.20010601141547.00acb090@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 01 Jun 2001 14:22:21 +0100
To: Liu Wen <ragent@gnuchina.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Is it possible to read NTFS5 in the future?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010601201308.E597.RAGENT@gnuchina.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13:17 01/06/01, Liu Wen wrote:
>NTFS5 is really an efficient filesystem under Windows 2000. I have a 12G
>data partition kept as FAT32 just in order to use it under Linux. But I
>am thinking of converting it to NTFS,which would be very inconvinient
>to use Linux. How about the kernel developing project to work on NTFS?

Using the at least kernel 2.4.4-ac18 (note you have to use -ac kernels at 
the moment) you should be fine accessing Win2k NTFS volumes from Linux 
READ-ONLY. Only the advanced Win2k NTFS features like reparse points, 
quota, etc. will not work under linux as of now.

As of the moment write support for NTFS is still EXTREMELY DANGEROUS, 
especially under Win2k, so you better not do it unless you are 
participating in NTFS development on Linux and have backups...

So basically NTFS is under development. There is no need for yet another 
NTFS project. Just join ours if you are interested:
         http://sf.net/projects/linux-ntfs

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

