Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262984AbSJBGz0>; Wed, 2 Oct 2002 02:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262985AbSJBGz0>; Wed, 2 Oct 2002 02:55:26 -0400
Received: from smtp02.web.de ([217.72.192.151]:32796 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S262984AbSJBGzY>;
	Wed, 2 Oct 2002 02:55:24 -0400
Message-ID: <3D9A9994.3090400@web.de>
Date: Wed, 02 Oct 2002 09:00:36 +0200
From: Roy <roy_me@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.1) Gecko/20020826
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 (2.5.39 too) Problems compiling radionfb ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I the only one who got problems with radeonfb?

   gcc -Wp,-MD,./.radeonfb.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=radeonfb   -c -o radeonfb.o radeonfb.c
drivers/video/radeonfb.c:605: unknown field `fb_get_fix' specified in 
initializer
drivers/video/radeonfb.c:605: warning: initialization from incompatible 
pointer type
drivers/video/radeonfb.c:606: unknown field `fb_get_var' specified in 
initializer
drivers/video/radeonfb.c:606: warning: initialization from incompatible 
pointer type
drivers/video/radeonfb.c: In function `radeon_set_dispsw':
drivers/video/radeonfb.c:1385: structure has no member named `type'
drivers/video/radeonfb.c:1386: structure has no member named `type_aux'
drivers/video/radeonfb.c:1387: structure has no member named `ypanstep'
drivers/video/radeonfb.c:1388: structure has no member named `ywrapstep'
drivers/video/radeonfb.c:1397: structure has no member named `visual'
drivers/video/radeonfb.c:1398: structure has no member named `line_length'
drivers/video/radeonfb.c:1405: structure has no member named `visual'
drivers/video/radeonfb.c:1406: structure has no member named `line_length'
drivers/video/radeonfb.c:1413: structure has no member named `visual'
drivers/video/radeonfb.c:1414: structure has no member named `line_length'
drivers/video/radeonfb.c:1421: structure has no member named `visual'
drivers/video/radeonfb.c:1422: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_get_fix':
drivers/video/radeonfb.c:1514: structure has no member named `type'
drivers/video/radeonfb.c:1515: structure has no member named `type_aux'
drivers/video/radeonfb.c:1516: structure has no member named `visual'
drivers/video/radeonfb.c:1522: structure has no member named `line_length'
drivers/video/radeonfb.c: In function `radeonfb_set_var':
drivers/video/radeonfb.c:1578: structure has no member named `line_length'
drivers/video/radeonfb.c:1579: structure has no member named `visual'
drivers/video/radeonfb.c:1590: structure has no member named `line_length'
drivers/video/radeonfb.c:1591: structure has no member named `visual'
drivers/video/radeonfb.c:1606: structure has no member named `line_length'
drivers/video/radeonfb.c:1607: structure has no member named `visual'
drivers/video/radeonfb.c:1619: structure has no member named `line_length'
drivers/video/radeonfb.c:1620: structure has no member named `visual'
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2487: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:598: warning: `radeon_read_OF' declared 
`static' but never defined
drivers/video/radeonfb.c:1710: warning: `radeonfb_set_cmap' defined but 
not used
   gcc -Wp,-MD,./.fbcon-cfb8.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=fbcon_cfb8 -DEXPORT_SYMTAB  -c -o 
fbcon-cfb8.o fbcon-cfb8.c
   gcc -Wp,-MD,./.fbcon-cfb16.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=fbcon_cfb16 -DEXPORT_SYMTAB  -c -o 
fbcon-cfb16.o fbcon-cfb16.c
   gcc -Wp,-MD,./.fbcon-cfb24.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=fbcon_cfb24 -DEXPORT_SYMTAB  -c -o 
fbcon-cfb24.o fbcon-cfb24.c
   gcc -Wp,-MD,./.fbcon-cfb32.o.d -D__KERNEL__ 
-I/usr/src/linux-2.5.40/include -Wall -Wstrict-prototypes -Wno-trigraphs 
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 
-I/usr/src/linux-2.5.40/arch/i386/mach-generic -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=fbcon_cfb32 -DEXPORT_SYMTAB  -c -o 
fbcon-cfb32.o fbcon-cfb32.c
    ld -m elf_i386  -r -o built-in.o dummycon.o vgacon.o font_8x8.o 
font_8x16.o fbmem.o fbcmap.o modedb.o fbcon.o fonts.o fbgen.o radeonfb.o 
fbcon-cfb8.o fbcon-cfb16.o fbcon-cfb24.o fbcon-cfb32.o
ld: cannot open radeonfb.o: No such file or directory
make[2]: *** [built-in.o] Fehler 1
make[2]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.40/drivers/video«
make[1]: *** [video] Fehler 2
make[1]: Verlassen des Verzeichnisses Verzeichnis 
»/usr/src/linux-2.5.40/drivers«
make: *** [drivers] Fehler 2

