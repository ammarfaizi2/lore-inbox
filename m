Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311893AbSCTRwZ>; Wed, 20 Mar 2002 12:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311888AbSCTRwG>; Wed, 20 Mar 2002 12:52:06 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:15615 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S311893AbSCTRvw>; Wed, 20 Mar 2002 12:51:52 -0500
Message-Id: <5.1.0.14.2.20020320175220.04d67410@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 20 Mar 2002 17:52:45 +0000
To: eddantes@wanadoo.fr
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [2.5.7] undefined reference to `sys_nfsservctl'
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C98CCFB.1080601@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17:55 20/03/02, eddantes@wanadoo.fr wrote:
>Trond Myklebust wrote:
>>>>>>>" " == Anton Altaparmakov <aia21@cus.cam.ac.uk> writes:
>>      > Al Viro has a patch for this on his ftp site but you can get
>>      > over the compile problemy by simply enabling both nfs and nfs
>>      > server in the kernel configuration, no patch needed in that
>>      > case... I.e. you want to set these:
>>     >> # CONFIG_NFS_FS is not set CONFIG_NFS_V3 is not set CONFIG_NFSD
>>     >> # is not set CONFIG_NFSD_V3 is not set
>>No point in compile in the NFS client unless you really need it.
>>sys_nfsservctl is a knfsd-only thing, so you shouldn't need either
>>CONFIG_NFS_FS or CONFIG_NFS_V3 if you only want get around the bug.
>
>Yes, I'd prefer not to compile in stuff I don't need. And I definitely 
>don't need NFS.
>
>OTOH, I went on Al Viro's ftp to try to find the patch. Which file is it? :)

0-aliases-c-C7-pre2

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

