Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280605AbRKJTIT>; Sat, 10 Nov 2001 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280604AbRKJTIJ>; Sat, 10 Nov 2001 14:08:09 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:31448 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280603AbRKJTIA> convert rfc822-to-8bit; Sat, 10 Nov 2001 14:08:00 -0500
Message-Id: <5.1.0.14.2.20011110190718.033ad060@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 10 Nov 2001 19:08:02 +0000
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: ANN: Linux-NTFS 1.4.0 released
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to announce release of Linux-NTFS user space support tools 1.4.0.

Most important changes:

mkntfs now support creation of NTFS floppies and the root directory on 
volumes with cluster sizes > 4kiB are now created correctly.

ntfsfix now supports Windows XP (NTFS 3.1) volumes.

Linux-NTFS packages (your choice of source tar.gz or rpm, binary i386.rpm 
and devel rpm) can be downloaded from the Linux-NTFS home page at:

         http://linux-ntfs.sf.net/

Or if you prefer CVS access, look at the project home page on Sourceforge 
for details how to access the CVS server:

         http://sourceforge.net/cvs/?group_id=13956

ChangeLog:

1.4.0: Major fix in mkntfs, small update to ntfsfix, and other updates.

- Update ntfsfix to support Windows XP NTFS volumes (NTFS 3.1).
- Update layout.h with more information.
- (Re)enable shared libraries.
- Changes to mkntfs:
         - Correct handling of directories on volumes with cluster sizes 
above 4096 bytes.
         - Lower minimum size of NTFS partitions to 1MiB, scaling down the 
logfile size as necessary.
         - Support a wider range of input parameters. Now should have all 
valid combinations covered.
         - Update man page.
         - Implement better determination of device size.
         - Various bug fixes.

1.2.2: Small fix in mkntfs and minor updates.
- Small fix in mkntfs for small volumes with non-standard sector sizes, 
where the default values would result in a sector size smaller than the 
sector size and mkntfs would refuse to run because of this. The man page 
was updated accordingly.
- Minor updates/clarifications to include/layout.h.

1.2.1: Added ntfsfix man page and minor cleanup.
- David Martínez Moreno <david.martinez@rediris.es> donated a man page for 
ntfsfix as well as spelling mistake fixes all over the place.

1.2.0: Important bug fixes to mkntfs.
- Bug fixes for cluster sizes > 4kb involving corrections to mft mirror 
size and contents, mft data attribute position and mft bitmap 
size.     Some of those were nasty so this is a major improvement.

For older changes, see the ChangeLog file in the release or in CVS.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

