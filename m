Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319095AbSIJJ40>; Tue, 10 Sep 2002 05:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319096AbSIJJ40>; Tue, 10 Sep 2002 05:56:26 -0400
Received: from [210.19.28.11] ([210.19.28.11]:48004 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S319095AbSIJJ4Z>; Tue, 10 Sep 2002 05:56:25 -0400
Date: Tue, 10 Sep 2002 18:09:12 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org
Subject: 2.5.34: fbdev compile error
Message-Id: <20020910180912.75420ff0.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.8.2claws (GTK+ 1.2.10; )
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this error with the 2.5.34 kernel

make[3]: Entering directory `/usr/src/linux/drivers/video/riva'
  gcc -Wp,-MD,./.fbdev.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o fbdev.o fbdev.c
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


Regards.

Thanks.

-Ubaida-
