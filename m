Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSJMUFL>; Sun, 13 Oct 2002 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbSJMUFK>; Sun, 13 Oct 2002 16:05:10 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:60149 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S261732AbSJMUFJ>; Sun, 13 Oct 2002 16:05:09 -0400
Date: Sun, 13 Oct 2002 13:04:37 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.34: fbdev compile error
In-Reply-To: <20020910180912.75420ff0.Corporal_Pisang@Counter-Strike.com.my>
Message-ID: <Pine.LNX.4.33.0210131304100.5997-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> I get this error with the 2.5.34 kernel
>
> make[3]: Entering directory `/usr/src/linux/drivers/video/riva'
>   gcc -Wp,-MD,./.fbdev.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o fbdev.o fbdev.c
> fbdev.c: In function `riva_set_dispsw':
> fbdev.c:665: structure has no member named `type'
> fbdev.c:666: structure has no member named `type_aux'
> fbdev.c:667: structure has no member named `ypanstep'
> fbdev.c:668: structure has no member named `ywrapstep'

[snip] This si due to fbdev api changes. The next couple of changesets
will fix this.

