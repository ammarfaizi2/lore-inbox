Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSGCPIh>; Wed, 3 Jul 2002 11:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSGCPIg>; Wed, 3 Jul 2002 11:08:36 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:44163 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317024AbSGCPIf>; Wed, 3 Jul 2002 11:08:35 -0400
Date: Wed, 3 Jul 2002 17:10:52 +0200
From: Ulrich Wiederhold <U.Wiederhold@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 and devfs
Message-ID: <20020703151052.GA10269@sky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux 3.0 (Kernel 2.4.17-rc2)
Organization: Using Linux Only
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I tryed to compile with devfs included and get this error during "make
bzImage":
[...]
base.c:2293: redefinition of `devfs_unregister_blkdev'
/usr/src/linux/include/linux/devfs_fs_kernel.h:259:
`devfs_unregister_blkdev' previously defined here
base.c: In function `devfsd_ioctl':
base.c:3420: warning: unused variable `lock'
base.c: At top level:
base.c:3535: redefinition of `mount_devfs_fs'
/usr/src/linux/include/linux/devfs_fs_kernel.h:311: `mount_devfs_fs'
previously defined here
make[3]: *** [base.o] Fehler 1
make[3]: Leaving directory `/usr/src/linux/fs/devfs'
make[2]: *** [first_rule] Fehler 2
make[2]: Leaving directory `/usr/src/linux/fs/devfs'
make[1]: *** [_subdir_devfs] Fehler 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [_dir_fs] Fehler 2

Any hints?

Uli

-- 
'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
