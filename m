Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292841AbSCALmv>; Fri, 1 Mar 2002 06:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292966AbSCALml>; Fri, 1 Mar 2002 06:42:41 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:37643 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292841AbSCALmc>; Fri, 1 Mar 2002 06:42:32 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 1 Mar 2002 11:42:38 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre2: ufs problems
Message-ID: <20020301114238.A28655@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

2.4.19-pre2 fails to mount my FreeBSD filesystems:

bogomips root ~# grep bsd /etc/fstab
/dev/hda10              /bsd            ufs     ro,ufstype=44bsd 0 0
/dev/hda12              /bsd/var        ufs     ro,ufstype=44bsd 0 0
/dev/hda13              /bsd/usr        ufs     ro,ufstype=44bsd 0 0
bogomips root ~# mount -a
UFS: failed to set blocksize
mount: wrong fs type, bad option, bad superblock on /dev/hda10,
       or too many mounted file systems
mount: mount point /bsd/var does not exist
mount: mount point /bsd/usr does not exist

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
