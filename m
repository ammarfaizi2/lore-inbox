Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312889AbSCZAjb>; Mon, 25 Mar 2002 19:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312894AbSCZAjV>; Mon, 25 Mar 2002 19:39:21 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18437 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S312889AbSCZAjN>; Mon, 25 Mar 2002 19:39:13 -0500
Date: Mon, 25 Mar 2002 20:33:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bk repository compile bug (zoran)
In-Reply-To: <3C9D799C.3070300@candelatech.com>
Message-ID: <Pine.LNX.4.21.0203252033340.3456-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Mar 2002, Ben Greear wrote:

> Just in case this has not been caught yet, from repository:
>   bk://linux.bkbits.net/linux-2.4
> 
> 
> gcc -D__KERNEL__ -I/home/greear/kernel/2.4/bk/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/bk/linux-2.4/include/linux/modversions.h  -DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
> zr36067.c: In function `zoran_open':
> zr36067.c:3268: structure has no member named `busy'
> zr36067.c: At top level:
> zr36067.c:4405: warning: initialization makes integer from pointer without a cast
> zr36067.c:4406: warning: initialization makes integer from pointer without a cast
> zr36067.c:4407: warning: initialization from incompatible pointer type
> zr36067.c:4408: warning: initialization from incompatible pointer type
> zr36067.c:4410: warning: initialization from incompatible pointer type
> zr36067.c:4411: warning: initialization from incompatible pointer type
> zr36067.c:4412: warning: initialization from incompatible pointer type
> make[3]: *** [zr36067.o] Error 1
> make[3]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/media/video'

Already fixed by Gerd patches... Thanks.

