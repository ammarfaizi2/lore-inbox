Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSJUO4c>; Mon, 21 Oct 2002 10:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSJUO4c>; Mon, 21 Oct 2002 10:56:32 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35764 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261530AbSJUO4a>; Mon, 21 Oct 2002 10:56:30 -0400
Subject: Re: 2.5.43 - media/video/zr36120.h:29:27: linux/i2c-old.h: No such
	file or directory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miles Lane <miles.lane@attbi.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1034759764.3983.11.camel@turbulence.megapathdsl.net>
References: <1034759764.3983.11.camel@turbulence.megapathdsl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 16:18:21 +0100
Message-Id: <1035213501.27309.158.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 10:16, Miles Lane wrote:
>   gcc -Wp,-MD,drivers/media/video/.zr36120.o.d -D__KERNEL__ -Iinclude
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DMODULE   -DKBUILD_BASENAME=zr36120   -c -o
> drivers/media/video/zr36120.o drivers/media/video/zr36120.c
> In file included from drivers/media/video/zr36120.c:43:
> drivers/media/video/zr36120.h:29:27: linux/i2c-old.h: No such file or
> directory

This driver needs porting to the new i2c layer. There are some examples
of the newer i2c - eg saa5249 which are not too hard to follow.

