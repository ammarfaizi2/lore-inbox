Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265326AbSLBXzC>; Mon, 2 Dec 2002 18:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbSLBXzC>; Mon, 2 Dec 2002 18:55:02 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:26123 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S265228AbSLBXzB>; Mon, 2 Dec 2002 18:55:01 -0500
Content-Type: text/plain;
  charset="us-ascii"
Organization: Universitaet Konstanz/Germany
To: linux-kernel@vger.kernel.org
Subject: Compile error in 2.5.50 (video/bttv-cards.c)
Date: Tue, 3 Dec 2002 01:02:24 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212030101.57134.>
From: partmaps@vortex.physik.uni-konstanz.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I get a compile error in bttv-cards.c
Somehow I cannot find the AUDC_CONFIG_PINNACLE option anywhere in the 
kernel-configuration GUI. Perhaps somebody will know how to improve this. 
Details on request if needed.

Cheers,
Max

  gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   
-DKBUILD_BASENAME=bttv_cards -DKBUILD_MODNAME=bttv   -c -o 
drivers/media/video/bttv-cards.o drivers/media/video/bttv-cards.c
drivers/media/video/bttv-cards.c: In function `miro_pinnacle_gpio':
drivers/media/video/bttv-cards.c:1742: `AUDC_CONFIG_PINNACLE' undeclared 
(first use in this function)
drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is reported 
only once
drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
make[3]: *** [drivers/media/video/bttv-cards.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

