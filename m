Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJLRZ2>; Sat, 12 Oct 2002 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSJLRZ2>; Sat, 12 Oct 2002 13:25:28 -0400
Received: from [212.104.37.2] ([212.104.37.2]:270 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261306AbSJLRZ0>; Sat, 12 Oct 2002 13:25:26 -0400
Date: Sat, 12 Oct 2002 19:30:58 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.42] sound/core/sound.o doesn't build
Message-ID: <20021012173058.GA5854@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kronos@dreamland:/usr/src/linux-2.5$ make sound/core/sound.o
make -f scripts/Makefile
make -f sound/core/Makefile sound/core/sound.o
  gcc -Wp,-MD,sound/core/.sound.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=athlon  -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=sound -DEXPORT_SYMTAB  -c -o sound/core/sound.o
sound/core/sound.c
sound/core/sound.c:458:27: warning: pasting "__ver_" and "(" does not
give a valid preprocessing token
sound/core/sound.c:458:27: warning: pasting ")" and "_R" does not give a
valid preprocessing token
sound/core/sound.c:458:27: warning: pasting "__kstrtab_" and "(" does
not give a valid preprocessing token
sound/core/sound.c:458: parse error before '(' token
sound/core/sound.c:458:27: warning: pasting "__ksymtab_" and "(" does
not give a valid preprocessing token
sound/core/sound.c:458: parse error before '(' token
sound/core/sound.c:458:27: warning: pasting "__kstrtab_" and "(" does
not give a valid preprocessing token
make[1]: *** [sound/core/sound.o] Error 1
make: *** [sound/core/sound.o] Error 2

kronos:/usr/src/linux-2.5$ grep SND .config | grep -v \#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VIA82XX=y


ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Il coraggio non mi manca.
E` la paura che mi frega...
