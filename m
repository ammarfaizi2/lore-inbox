Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSGCPaW>; Wed, 3 Jul 2002 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSGCPaV>; Wed, 3 Jul 2002 11:30:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:9707 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317030AbSGCPaT>; Wed, 3 Jul 2002 11:30:19 -0400
Date: Wed, 3 Jul 2002 17:32:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ulrich Wiederhold <U.Wiederhold@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 and devfs
In-Reply-To: <20020703151052.GA10269@sky.net>
Message-ID: <Pine.NEB.4.44.0207031731360.4374-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Ulrich Wiederhold wrote:

> Hello,

Hi Ulrich,

> I tryed to compile with devfs included and get this error during "make
> bzImage":
> [...]
> base.c:2293: redefinition of `devfs_unregister_blkdev'
> /usr/src/linux/include/linux/devfs_fs_kernel.h:259:
> `devfs_unregister_blkdev' previously defined here
> base.c: In function `devfsd_ioctl':
> base.c:3420: warning: unused variable `lock'
> base.c: At top level:
> base.c:3535: redefinition of `mount_devfs_fs'
> /usr/src/linux/include/linux/devfs_fs_kernel.h:311: `mount_devfs_fs'
> previously defined here
> make[3]: *** [base.o] Fehler 1
> make[3]: Leaving directory `/usr/src/linux/fs/devfs'
> make[2]: *** [first_rule] Fehler 2
> make[2]: Leaving directory `/usr/src/linux/fs/devfs'
> make[1]: *** [_subdir_devfs] Fehler 2
> make[1]: Leaving directory `/usr/src/linux/fs'
> make: *** [_dir_fs] Fehler 2
>
> Any hints?

Could you please send:
1. The complete error message (starting with the gcc call that failed).
2. Your .config

> Uli

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

