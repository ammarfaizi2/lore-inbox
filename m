Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSFJRmW>; Mon, 10 Jun 2002 13:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSFJRmW>; Mon, 10 Jun 2002 13:42:22 -0400
Received: from mail.pixelwings.com ([194.152.163.212]:11525 "EHLO
	pixelwings.com") by vger.kernel.org with ESMTP id <S315606AbSFJRmU> convert rfc822-to-8bit;
	Mon, 10 Jun 2002 13:42:20 -0400
Date: Mon, 10 Jun 2002 19:42:16 +0200 (CEST)
From: Clemens Schwaighofer <cs@pixelwings.com>
X-X-Sender: gullevek@lynx.piwi.intern
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.20-dj4 oss broken.
Message-ID: <Pine.LNX.4.44.0206101940280.13641-100000@lynx.piwi.intern>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a running 2.5.20-dj3 and used the same config vor dj4 patch, but it 
fails to compile. Seems as some patches where lost from 2.5.20-dj3 to dj4 
?

rh 7.3 with gcc 3.1 and glibc 2.2.5

make[2]: Entering directory 
`/usr/src/kernel/2.5.20-dj4/linux-2.5.20/sound/oss'
gcc -D__KERNEL__ -I/usr/src/kernel/2.5.20-dj4/linux-2.5.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-DMODULE -include 
/usr/src/kernel/2.5.20-dj4/linux-2.5.20/include/linux/modversions.h   
-DKBUILD_BASENAME=ac97_codec
-DEXPORT_SYMTAB -c -o ac97_codec.o ac97_codec.c
ac97_codec.c:116: label ad1886_ops referenced outside of any function
make[2]: *** [ac97_codec.o] Error 1
make[2]: Leaving directory 
`/usr/src/kernel/2.5.20-dj4/linux-2.5.20/sound/oss'
make[1]: *** [_modsubdir_oss] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.20-dj4/linux-2.5.20/sound'
make: *** [_mod_sound] Error 2

-- 
"Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren"
- Paul Valéry (1871-1945)
mfg, Clemens Schwaighofer                       PIXELWINGS Medien GMBH
Kandlgasse 15/5, A-1070 Wien                      T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN       -->      http://www.pixelwings.com

