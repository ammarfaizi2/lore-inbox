Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSIAIgm>; Sun, 1 Sep 2002 04:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSIAIgm>; Sun, 1 Sep 2002 04:36:42 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:38466 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S316574AbSIAIgm>; Sun, 1 Sep 2002 04:36:42 -0400
Date: Sun, 1 Sep 2002 10:41:08 +0200 (CEST)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.33 oss compilation error
Message-ID: <Pine.LNX.4.44.0209011039340.11629-100000@trider-g7.ext.fabbione.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  gcc -Wp,-MD,./.v_midi.o.d -D__KERNEL__ -I/usr/src/linux-2.5.33/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -nostdinc -iwithprefix include -DMODULE -include
/usr/src/linux-2.5.33/include/linux/modversions.h
-DKBUILD_BASENAME=v_midi   -c -o v_midi.o v_midi.c
v_midi.c: In function `v_midi_open':
v_midi.c:55: structure has no member named `lock'
v_midi.c:58: structure has no member named `lock'
v_midi.c:62: structure has no member named `lock'
v_midi.c: In function `v_midi_close':
v_midi.c:83: structure has no member named `lock'
v_midi.c:87: structure has no member named `lock'
v_midi.c: In function `attach_v_midi':
v_midi.c:223: structure has no member named `lock'
v_midi.c:244: structure has no member named `lock'
make[2]: *** [v_midi.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.33/sound/oss'
make[1]: *** [oss] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.33/sound'
make: *** [sound] Error 2

Regards
Fabio


