Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312253AbSCYC1H>; Sun, 24 Mar 2002 21:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSCYC07>; Sun, 24 Mar 2002 21:26:59 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:3215 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312254AbSCYC0j>; Sun, 24 Mar 2002 21:26:39 -0500
Message-Id: <5.1.0.14.2.20020325013452.03e53630@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 25 Mar 2002 02:26:41 +0000
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: ANN: New NTFS driver (2.0.0/TNG) now finished.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is to announce that the new NTFS Linux kernel driver 2.0.0 (formerly 
NTFS TNG) is now finished (read-only). It is for kernel 2.5.7 only and will 
be submitted to Linus for inclusion in the 2.5 kernel series when Linus 
returns from his holiday.

The driver has been tested extensively and has survived all tests so far.

It is fully compatible with kernel preemption and SMP. And it should work 
on both little endian and big endian architectures, and both on 32 and 64 
bit architectures. Note, only ia32 has actually been tested and there may 
be problems with architectures not supporting unaligned accesses. Any 
volunteers for non-ia32 architectures?

The new driver is significantly faster than the old driver (~20% in my 
tests), uses less CPU time and generally is superior to the old driver. (-:

The driver can be compiled both with gcc-2.95 and gcc-2.96. gcc-3.x has not 
been tested. (If anyone experiences compilation problems especially with 
gcc-2.95 please let me know and they will be fixed ASAP!)

To try the driver either use BitKeeper to obtain a clone from the repository:

         bk clone -q http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Or if you already have a clone derived from an official kernel repository 
you only need to pull in the changes:

         bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

And then checkout all the files using bk -r co -q from within the 
repository directory.

For people not using BitKeeper patches for the standard 2.5.7 kernel are 
available here:

http://www-stu.christs.cam.ac.uk/~aia21/linux/linux-2.5.7-ntfs-2.0.0.patch.bz2 
(151kiB)

http://www-stu.christs.cam.ac.uk/~aia21/linux/linux-2.5.7-ntfs-2.0.0.patch.gz 
(199kiB)

http://www-stu.christs.cam.ac.uk/~aia21/linux/linux-2.5.7-ntfs-2.0.0.patch 
(796kiB)

Finally, for people wanting to browse the source code on-line, point your 
web browser at:

         http://linux-ntfs.bkbits.net:8080/ntfs-tng-2.5

Please everyone courageous enough to use a bleeding edge kernel and who is 
also an NTFS user give this a try and let me know if you encounter any 
problems! - Thanks!

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

