Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319575AbSIMJKV>; Fri, 13 Sep 2002 05:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319576AbSIMJKU>; Fri, 13 Sep 2002 05:10:20 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:44304 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S319575AbSIMJKT>;
	Fri, 13 Sep 2002 05:10:19 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: Linux 2.4.20-pre7 (TIOCM_MODEM_BITS undeclared)
References: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
User-Agent: tin/1.5.14-20020814 ("Chop Suey!") (UNIX) (Linux/2.4.19 (i686))
Message-ID: <411b.3d81ac9e.946d5@gzp1.gzp.hu>
Date: Fri, 13 Sep 2002 09:15:10 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

libc-2.2.5.so
gcc 2.95.4-cvs
GNU ld version 2.12.90.0.4 20020408

make -C irda modules
make[3]: Entering directory `/usr/src/linux-2.4.20-pre7-gzp3/drivers/net/irda'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre7-gzp3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
irtty.c:761: (Each undeclared identifier is reported only once
irtty.c:761: for each function it appears in.)
make[3]: *** [irtty.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20-pre7-gzp3/drivers/net/irda'
make[2]: *** [_modsubdir_irda] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20-pre7-gzp3/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre7-gzp3/drivers'
make: *** [_mod_drivers] Error 2

Same with pre6.

