Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315343AbSEAIF7>; Wed, 1 May 2002 04:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315344AbSEAIF6>; Wed, 1 May 2002 04:05:58 -0400
Received: from brussels-smtp.planetinternet.be ([195.95.34.12]:42756 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S315343AbSEAIF5> convert rfc822-to-8bit; Wed, 1 May 2002 04:05:57 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Treeve Jelbert <treeve01@pi.be>
Organization: Knowhow sc
To: linux-kernel@vger.kernel.org
Subject: Bug - building kernel 2.5.12 - fbcon-cfb8.c
Date: Wed, 1 May 2002 10:09:17 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205011009.17652.treeve01@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.5.12/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon    
-DKBUILD_BASENAME=fbcon_cfb8  -DEXPORT_SYMTAB -c fbcon-cfb8.c
fbcon-cfb8.c: In function `fbcon_cfb8_bmove':
fbcon-cfb8.c:55: structure has no member named `screen_base'
fbcon-cfb8.c:56: structure has no member named `screen_base'
fbcon-cfb8.c:66: structure has no member named `screen_base'
fbcon-cfb8.c:67: structure has no member named `screen_base'
fbcon-cfb8.c:74: structure has no member named `screen_base'
fbcon-cfb8.c:75: structure has no member named `screen_base'
fbcon-cfb8.c:52: warning: `src' might be used uninitialized in this function
fbcon-cfb8.c:52: warning: `dst' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_clear':
fbcon-cfb8.c:100: structure has no member named `screen_base'
fbcon-cfb8.c:96: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_putc':
fbcon-cfb8.c:118: structure has no member named `screen_base'
fbcon-cfb8.c:114: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_putcs':
fbcon-cfb8.c:165: structure has no member named `screen_base'
fbcon-cfb8.c:160: warning: `dest0' might be used uninitialized in this 
function
fbcon-cfb8.c: In function `fbcon_cfb8_revc':
fbcon-cfb8.c:222: structure has no member named `screen_base'
fbcon-cfb8.c:219: warning: `dest' might be used uninitialized in this function
fbcon-cfb8.c: In function `fbcon_cfb8_clear_margins':
fbcon-cfb8.c:247: structure has no member named `screen_base'
fbcon-cfb8.c:250: structure has no member named `screen_base'
make[3]: *** [fbcon-cfb8.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.12/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.12/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.12/drivers'
make: *** [_dir_drivers] Error 2

-- 
Regards,  Treeve
