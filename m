Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311803AbSCTQce>; Wed, 20 Mar 2002 11:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311802AbSCTQcZ>; Wed, 20 Mar 2002 11:32:25 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:7103 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311801AbSCTQcO>; Wed, 20 Mar 2002 11:32:14 -0500
Date: Wed, 20 Mar 2002 16:32:14 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: eddantes@wanadoo.fr
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.7] undefined reference to `sys_nfsservctl'
In-Reply-To: <3C98B853.1060906@wanadoo.fr>
Message-ID: <Pine.SOL.3.96.1020320162809.19016A-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro has a patch for this on his ftp site but you can get over the
compile problemy by simply enabling both nfs and nfs server in the kernel
configuration, no patch needed in that case... I.e. you want to set these:

> # CONFIG_NFS_FS is not set
> # CONFIG_NFS_V3 is not set
> # CONFIG_NFSD is not set
> # CONFIG_NFSD_V3 is not set

And perhaps this one, not sure:

> # CONFIG_ROOT_NFS is not set

Best regards,

Anton

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

