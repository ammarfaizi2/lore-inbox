Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291171AbSAaRdG>; Thu, 31 Jan 2002 12:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291174AbSAaRcw>; Thu, 31 Jan 2002 12:32:52 -0500
Received: from mail.little-ft.com ([63.215.255.3]:63242 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S291171AbSAaRch>; Thu, 31 Jan 2002 12:32:37 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B1256FA@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'Andreas Dilger'" <adilger@turbolabs.com>
Cc: "'Alexander Viro'" <viro@math.psu.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: ext2/mount - multiple mounts corrupts inodes
Date: Thu, 31 Jan 2002 09:28:09 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andreas Dilger [mailto:adilger@turbolabs.com]
> Sent: Wednesday, January 30, 2002 8:46 PM
>
> > + find /mnt/hd -ls
> >      2    1 drwxr-xr-x   3 root     root         1024 Dec 
> 31 15:17 /mnt/hd
> >     11   12 drwxr-xr-x   2 root     root        12288 Dec 31 15:17
> > /mnt/hd/lost+found
> > find: /mnt/hd/tar: Input/output error
> > find: /mnt/hd/zcat: Input/output error
> 
> Any interesting output in 'dmesg' when this happens?
> 

Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
ide0(3,3)
Dec 31 23:42:41 jumptec kernel: VFS: Disk change detected on device
ide0(3,3)
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: invalidate: busy buffer
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: invalidate: busy buffer
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: invalidate: busy buffer
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: invalidate: busy buffer
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: invalidate: dirty buffer
Dec 31 23:42:41 jumptec kernel: VFS: busy inodes on changed media.
