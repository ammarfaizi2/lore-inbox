Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265993AbSKKJ5i>; Mon, 11 Nov 2002 04:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265994AbSKKJ5i>; Mon, 11 Nov 2002 04:57:38 -0500
Received: from kryton.mki.bz ([195.58.191.168]:12734 "EHLO mx0.mki.bz")
	by vger.kernel.org with ESMTP id <S265993AbSKKJ5g>;
	Mon, 11 Nov 2002 04:57:36 -0500
Date: Mon, 11 Nov 2002 11:04:22 +0100 (CET)
From: Michael Kummer <michael@kummer.cc>
Reply-To: michael@kummer.cc
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Linux 2.5.47 compile error
In-Reply-To: <Pine.LNX.4.44.0211090103270.14371-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0211111103130.246-100000@epo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=drivers/video/riva
  gcc -Wp,-MD,drivers/video/riva/.fbdev.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4 -Iarch/i386/mach-generic -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=fbdev   -c -o
drivers/video/riva/fbdev.o drivers/video/riva/fbdev.c
drivers/video/riva/fbdev.c: In function `riva_set_dispsw':
drivers/video/riva/fbdev.c:665: structure has no member named `type'
drivers/video/riva/fbdev.c:666: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:667: structure has no member named `ypanstep'
drivers/video/riva/fbdev.c:668: structure has no member named `ywrapstep'
drivers/video/riva/fbdev.c:677: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:678: structure has no member named `visual'
drivers/video/riva/fbdev.c:686: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:687: structure has no member named `visual'
drivers/video/riva/fbdev.c:695: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:696: structure has no member named `visual'
drivers/video/riva/fbdev.c: In function `rivafb_get_fix':
drivers/video/riva/fbdev.c:1294: structure has no member named `type'
drivers/video/riva/fbdev.c:1295: structure has no member named `type_aux'
drivers/video/riva/fbdev.c:1296: structure has no member named `visual'
drivers/video/riva/fbdev.c:1302: structure has no member named
`line_length'
drivers/video/riva/fbdev.c: In function `rivafb_pan_display':
drivers/video/riva/fbdev.c:1611: structure has no member named
`line_length'
drivers/video/riva/fbdev.c:1586: warning: `base' might be used
uninitialized in this function
drivers/video/riva/fbdev.c: At top level:
drivers/video/riva/fbdev.c:1748: unknown field `fb_get_fix' specified in
initializer
drivers/video/riva/fbdev.c:1748: warning: initialization from incompatible
pointer type
drivers/video/riva/fbdev.c:1749: unknown field `fb_get_var' specified in
initializer
drivers/video/riva/fbdev.c:1749: warning: initialization from incompatible
pointer type
make[3]: *** [drivers/video/riva/fbdev.o] Error 1
make[2]: *** [drivers/video/riva] Error 2
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2


-- 
best regards


Michael Kummer

--
Michael Kummer - [A]ustrian [E]lite [S]printer
Lieferinger-Hauptstrasse 47 - A 5020 Salzburg
Mobile: +43 664 3333995
EMail: michael@kummer.cc
Web: http://www.sprinter.cc


