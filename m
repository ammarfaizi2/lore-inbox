Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbRGZAeb>; Wed, 25 Jul 2001 20:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbRGZAeV>; Wed, 25 Jul 2001 20:34:21 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:20105 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267452AbRGZAeK>; Wed, 25 Jul 2001 20:34:10 -0400
Message-Id: <5.1.0.14.2.20010726013311.00a94670@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 26 Jul 2001 01:34:17 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: ANN: Linux-NTFS 1.2.0 released.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is to announce release of Linux-NTFS user space support tools 1.2.0.

Most important changes: mkntfs has been updated to version 1.41. Includes 
important bug fixes for cluster sizes > 4kiB. (Detailed ChangeLog below.)

Linux-NTFS packages (your choice of source tar.gz or rpm, binary i386.rpm 
and devel rpm) can be downloaded from the Linux-NTFS home page at:

         http://linux-ntfs.sf.net/

Or if you prefer CVS access, look at the project home page on Sourceforge 
for details how to access the cvs server:

         http://sourceforge.net/cvs/?group_id=13956

Changes since 1.0.2:

- mkntfs bug fixes for cluster sizes > 4kiB involving corrections to mft 
mirror size and contents, mft data attribute position and mft bitmap size. 
Some of those were nasty so this is a major improvement. Hopefully these 
were the last bugs.

Changes since 1.0.1:

- Small cleanup of the distribution. Move mkntfs to sbin (was put in bin 
before).

- Small bug fix to mkntfs man page.

Changes since 1.0.0

- Confirmed that at least gcc-2.96 is needed to compile linux-ntfs.

- Removed ldm.c from linux-ntfs. It will reappear as ldminfo.c in a new 
package, probably linux-ldm.

- Taken out some files from the distribution, but they are still present in 
CVS. This is because they are not really useful except if you are a 
developer wanting to play about.

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

