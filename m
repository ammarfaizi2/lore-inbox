Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288596AbSANBob>; Sun, 13 Jan 2002 20:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288597AbSANBoV>; Sun, 13 Jan 2002 20:44:21 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:7372 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288596AbSANBoF>; Sun, 13 Jan 2002 20:44:05 -0500
Message-Id: <5.1.0.14.2.20020114013246.04c1d330@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 01:44:02 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: IDE Patches bring amazing performance gain!!!
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a heads up, Andre Hedrick's (Andre sorry for the misspelling 
previously!) IDE patch improved the performance of my 7200rpm ATA100 IBM 
IDE hd from 28Mb/s to 38Mb/s as measured by hdparm -t /dev/hda, which is 
quite an improvement by anyones standards! Also hitting the disk with a lot 
of io maintains low latency and my mp3s aren't dropping out and my X 
session maintains interactivity. (-:

Considering I have seen many good reports and ZERO bad reports about the 
IDE patches it is really astonishing that the patches are not being applied 
to the 2.4.x kernel series... (especially as they were in the -ac series 
previously already)

Best regards,

Anton

At 01:07 14/01/02, Anton Altaparmakov wrote:
>Alan's -ac series is back! To celebrate this I added in the IDE patches 
>and an NTFS update which dramatically reduces the number of vmalloc()s and 
>have posted the resulting (tested) patch (to be applied on top of 
>2.4.18pre3-ac1) at below URL.
>
>http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.bz2
>http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.gz
>
>
>Linux 2.4.18pre3-ac1-aia1
>
>o       IDE patch (taskfile, lba-48, ata133, etc)       Andre Hedrick
>o       Configure help entries for above                Andre Hedrick, Rob 
>Radez
>o       Small IDE cleanups (code beauty only)           Pavel Machek, me
>o       Reduce NTFS vmalloc() use (NTFS 1.1.22)         me
>
>Enjoy,
>
>Anton

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

