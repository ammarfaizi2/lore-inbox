Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbSJMUL0>; Sun, 13 Oct 2002 16:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSJMUL0>; Sun, 13 Oct 2002 16:11:26 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:26008 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261765AbSJMULZ> convert rfc822-to-8bit; Sun, 13 Oct 2002 16:11:25 -0400
Date: Sun, 13 Oct 2002 13:10:27 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Bob Billson <reb@bhive.dhs.org>
cc: <linux-kernel@vger.kernel.org>, James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5.42 compiler error in video/vga16fb.c
In-Reply-To: <20021012230145.GA3508@etain.bhive.dhs.org>
Message-ID: <Pine.LNX.4.33.0210131309410.5997-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In drivers/video/vga16fb.c gcc (2.95.4 and 3.2) gives:

I have a newer file in fbdev BK but I haven't finished porting it to the
new api yet.

>
> gcc -Wp,-MD,drivers/video/.vga16fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vga16fb   -c -o drivers/video/vga16fb.o drivers/video/vga16fb.c
> drivers/video/vga16fb.c: In function `vga16fb_set_disp':
> drivers/video/vga16fb.c:177: structure has no member named `visual'
> drivers/video/vga16fb.c:178: structure has no member named `type'
> drivers/video/vga16fb.c:179: structure has no member named `type_aux'
> drivers/video/vga16fb.c:180: structure has no member named `ypanstep'
> drivers/video/vga16fb.c:181: structure has no member named `ywrapstep'
> drivers/video/vga16fb.c:182: structure has no member named `line_length'
> drivers/video/vga16fb.c: In function `vga_vesa_blank':
> drivers/video/vga16fb.c:664: warning: implicit declaration of function`cli'
> drivers/video/vga16fb.c:671: warning: implicit declaration of function`sti'
> drivers/video/vga16fb.c: At top level:
> drivers/video/vga16fb.c:814: unknown field `fb_get_fix' specified in initializer
> drivers/video/vga16fb.c:814: warning: initialization from incompatible pointer type
> drivers/video/vga16fb.c:815: unknown field `fb_get_var' specified in initializer
> drivers/video/vga16fb.c:815: warning: initialization from incompatible pointer type
> make[2]: *** [drivers/video/vga16fb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
>
>
>        bob
> --
>  bob billson        email: reb@bhive.dhs.org          ham: kc2wz    /)
>                            reb@elbnet.com             beekeeper  -8|||}
>  "Níl aon tinteán mar do thinteán féin." --Dorothy    Linux geek    \)
>  [ GPG key--> http://bhive.dhs.org/gpgkey.html ]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

