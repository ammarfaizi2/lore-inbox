Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288540AbSANBIT>; Sun, 13 Jan 2002 20:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288541AbSANBIK>; Sun, 13 Jan 2002 20:08:10 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:53450 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288540AbSANBHz>; Sun, 13 Jan 2002 20:07:55 -0500
Message-Id: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 01:07:53 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan's -ac series is back! To celebrate this I added in the IDE patches and 
an NTFS update which dramatically reduces the number of vmalloc()s and have 
posted the resulting (tested) patch (to be applied on top of 
2.4.18pre3-ac1) at below URL.

http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.bz2
http://www-stu.christs.cam.ac.uk/~aia21/linux/patch-2.4.18-pre3-ac1-aia1.gz


Linux 2.4.18pre3-ac1-aia1

o       IDE patch (taskfile, lba-48, ata133, etc)       Andre Hendrick
o       Configure help entries for above                Andre Hendrick, Rob 
Radez
o       Small IDE cleanups (code beauty only)           Pavel Machek, me
o       Reduce NTFS vmalloc() use (NTFS 1.1.22)         me

Enjoy,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

