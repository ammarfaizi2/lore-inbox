Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310426AbSCPQYN>; Sat, 16 Mar 2002 11:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310425AbSCPQYD>; Sat, 16 Mar 2002 11:24:03 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:17367 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S310424AbSCPQXu>; Sat, 16 Mar 2002 11:23:50 -0500
Date: Sat, 16 Mar 2002 16:23:49 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.5.7-pre2 link error in kernel.o with nfs but !nfsd configured
Message-ID: <Pine.SOL.3.96.1020316162023.5310D-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.7-pre2 (am using bitkeeper version from linux.bkbits.net/linux-2.5)
fails to link at the final stage of make bzImage.

The error is that sys_nfsservctl is referenced from kernel.o but it can't 
find it.

This error only occurs when NFS client side is configured and NFS server
side is not configured.

When both are configured make bzImage completes fine.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

