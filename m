Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264257AbSIWEUx>; Mon, 23 Sep 2002 00:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264507AbSIWEUx>; Mon, 23 Sep 2002 00:20:53 -0400
Received: from [210.19.28.13] ([210.19.28.13]:25495 "HELO gateway.vault-id.com")
	by vger.kernel.org with SMTP id <S264257AbSIWEUw>;
	Mon, 23 Sep 2002 00:20:52 -0400
Message-ID: <32815.10.2.16.178.1032755237.squirrel@mail.Vault-ID.com>
Date: Mon, 23 Sep 2002 12:27:17 +0800 (MYT)
Subject: 2.5.3[7,8] riva fbdev compile error
From: "Corporal Pisang" <Corporal_Pisang@Counter-Strike.com.my>
To: <linux-kernel@vger.kernel.org>
X-XheaderVersion: 1.1
X-UserAgent: Mozilla/5.0 Galeon/1.2.6 (X11; Linux i686; U;) Gecko/20020827
X-Priority: 3
Importance: Normal
Reply-To: Corporal_Pisang@Counter-Strike.com.my
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

fbdev compile error still not fixed.
I'm compiling with gcc 3.2


gcc -Wp,-MD,./.fbdev.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -I/usr/src/linux/arch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o fbdev.o fbdev.c
fbdev.c: In function `riva_set_dispsw':
fbdev.c:665: structure has no member named `type'
fbdev.c:666: structure has no member named `type_aux'
fbdev.c:667: structure has no member named `ypanstep'
fbdev.c:668: structure has no member named `ywrapstep'
fbdev.c:657: warning: unused variable `accel'
fbdev.c: In function `rivafb_setcolreg':
fbdev.c:1202: warning: unused variable `chip'
fbdev.c: In function `rivafb_get_fix':
fbdev.c:1294: structure has no member named `type'
fbdev.c:1295: structure has no member named `type_aux'
fbdev.c:1296: structure has no member named `visual'
fbdev.c:1302: structure has no member named `line_length'
fbdev.c: In function `rivafb_pan_display':
fbdev.c:1611: structure has no member named `line_length'
fbdev.c: At top level:
fbdev.c:1748: unknown field `fb_get_fix' specified in initializer
fbdev.c:1748: warning: initialization from incompatible pointer type
fbdev.c:1749: unknown field `fb_get_var' specified in initializer
fbdev.c:1749: warning: initialization from incompatible pointer type
fbdev.c:732: warning: `riva_wclut' defined but not used
make[3]: *** [fbdev.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/video/riva'
make[2]: *** [riva] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/video'
make[1]: *** [video] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [drivers] Error 2

Regards

-Ubaida-


