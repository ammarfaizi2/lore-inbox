Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSIHUB5>; Sun, 8 Sep 2002 16:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSIHUB5>; Sun, 8 Sep 2002 16:01:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56549 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314396AbSIHUB4>; Sun, 8 Sep 2002 16:01:56 -0400
Date: Sun, 8 Sep 2002 22:06:32 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ludwig <ludwig@superdeluxe.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Compile error drm/tdfx
In-Reply-To: <20020908133941.785563e3.ludwig@superdeluxe.com>
Message-ID: <Pine.NEB.4.44.0209082159330.24649-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Ludwig wrote:

> [1.] One line summary of the problem:
>
> Compile error
>
> [2.] Full description of the problem/report:
>
> make[4]: Entering directory `/usr/src/drivers/char/drm'
> gcc -D__KERNEL__ -I/usr/src/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -nostdinc -iwithprefix include -DKBUILD_BASENAME=tdfx_drv  -c -o tdfx_drv.o tdfx_drv.c
> In file included from tdfx_drv.c:108:
>...
> In file included from tdfx_drv.c:110:
> drm_vm.h: In function `tdfx_mmap':
> drm_vm.h:382: structure has no member named `agp'
> drm_vm.h:383: structure has no member named `agp'
> drm_vm.h:424: structure has no member named `agp'
> drm_vm.h:426: structure has no member named `agp'
> make[4]: *** [tdfx_drv.o] Error 1
> make[4]: Leaving directory `/usr/src/drivers/char/drm'
> make[3]: *** [first_rule] Error 2
> make[3]: Leaving directory `/usr/src/drivers/char/drm'
> make[2]: *** [_subdir_drm] Error 2
> make[2]: Leaving directory `/usr/src/drivers/char'
> make[1]: *** [_subdir_char] Error 2
> make[1]: Leaving directory `/usr/src/drivers'
> make: *** [_dir_drivers] Error 2
>
>...
> [4.] Kernel version (from /proc/version):
>
> Linux version 2.4.19-ben0 (root@suspectdevice) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 Mon Aug 19 06:56:20 EDT 2002
>...

In the case of a compile error the more interesting information is the
version of the kernel you are trying to compile.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



