Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbRESPfF>; Sat, 19 May 2001 11:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbRESPez>; Sat, 19 May 2001 11:34:55 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:6352 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261834AbRESPek>; Sat, 19 May 2001 11:34:40 -0400
Message-Id: <5.1.0.14.2.20010519162623.00ab9090@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 19 May 2001 16:34:41 +0100
To: linux-kernel@vger.kernel.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Q: fdatasync on block device?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could someone enlighten me whether fdatasync() system call on Linux, when 
called on the fd of an open()-ed block device, will result in the 
committing of all dirty device buffers to disk?

If not, how do I achieve this? Should I use the BLKFLSBUF ioctl?

Thanks in advance.

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

