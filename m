Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289698AbSBERyp>; Tue, 5 Feb 2002 12:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289692AbSBERyg>; Tue, 5 Feb 2002 12:54:36 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30222 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289699AbSBERyY>; Tue, 5 Feb 2002 12:54:24 -0500
Date: Tue, 5 Feb 2002 14:44:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre8: missing file
In-Reply-To: <3C5F0689.CAD1A09F@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.21.0202051443500.14994-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Feb 2002, Eyal Lebedinsky wrote:

> Marcelo Tosatti wrote:
> > 
> > Hi,
> > 
> > No more big patches for 2.4.18, please... We are getting close to the -rc
> > stage.
> > 
> > pre8:
> > - VXFS update                                   (Christoph Hellwig)
> 
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
> -DKBUILD_BASENAME=vxfs_bmap  -c -o vxfs_bmap.o vxfs_bmap.c
> In file included from vxfs_bmap.c:38:
> vxfs.h:42: vxfs_kcompat.h: No such file or directory
> make[2]: *** [vxfs_bmap.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/fs/freevxfs'

Damn, I forgot to "cvs add". Fixed.

Thanks

