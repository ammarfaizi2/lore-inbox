Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbSKRUSG>; Mon, 18 Nov 2002 15:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264785AbSKRUSG>; Mon, 18 Nov 2002 15:18:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60361 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264748AbSKRUSF>; Mon, 18 Nov 2002 15:18:05 -0500
Date: Mon, 18 Nov 2002 21:25:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: sound/isa/sb/sb16.c doesn't compile in 2.5.48
Message-ID: <20021118202500.GM11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  gcc -Wp,-MD,sound/isa/sb/.sb16.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=sb16 -DKBUILD_MODNAME=snd_sb16   -c -o
sound/isa/sb/sb16.o sound/isa/sb/sb16.c
sound/isa/sb/sb16.c: In function `alsa_card_sb16_setup':
sound/isa/sb/sb16.c:684: subscripted value is neither array nor pointer
sound/isa/sb/sb16.c:698: subscripted value is neither array nor pointer
make[3]: *** [sound/isa/sb/sb16.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

