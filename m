Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSLCADX>; Mon, 2 Dec 2002 19:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSLCADX>; Mon, 2 Dec 2002 19:03:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265806AbSLCADV>;
	Mon, 2 Dec 2002 19:03:21 -0500
Date: Mon, 2 Dec 2002 16:07:42 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <partmaps@vortex.physik.uni-konstanz.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compile error in 2.5.50 (video/bttv-cards.c)
In-Reply-To: <200212030101.57134.>
Message-ID: <Pine.LNX.4.33L2.0212021606300.27194-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2002 partmaps@vortex.physik.uni-konstanz.de wrote:

| I get a compile error in bttv-cards.c
| Somehow I cannot find the AUDC_CONFIG_PINNACLE option anywhere in the
| kernel-configuration GUI. Perhaps somebody will know how to improve this.
| Details on request if needed.
|
|   gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall
| -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
| -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
| -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE
| -DKBUILD_BASENAME=bttv_cards -DKBUILD_MODNAME=bttv   -c -o
| drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
| drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
| drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared
| (first use in this function)
| drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported
| only once
| drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
| make[3]: *** [drivers/media/video/bttv-cards.o] Error 1
| make[2]: *** [drivers/media/video] Error 2
| make[1]: *** [drivers/media] Error 2
| make: *** [drivers] Error 2
| -

Yes, patches for this are available at
  http://bytesex.org/patches/2.5/

The patches just aren't being merged (accepted) yet.  :(

-- 
~Randy

