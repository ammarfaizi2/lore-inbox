Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSJMKoP>; Sun, 13 Oct 2002 06:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261494AbSJMKoO>; Sun, 13 Oct 2002 06:44:14 -0400
Received: from uranus.lan-ks.de ([194.45.71.1]:14355 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S261490AbSJMKoN>;
	Sun, 13 Oct 2002 06:44:13 -0400
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.42] compile error in sound/isa/opl3sa2.c
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sun, 13 Oct 2002 11:41:34 +0200
Message-ID: <87vg46llpt.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  gcc -Wp,-MD,sound/isa/.opl3sa2.o.d -D__KERNEL__ -Iinclude -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
  -DMODULE   -DKBUILD_BASENAME=opl3sa2   -c -o sound/isa/opl3sa2.o
  sound/isa/opl3sa2.c
sound/isa/opl3sa2.c: In function `snd_opl3sa2_isapnp':
sound/isa/opl3sa2.c:643: warning: passing arg 1 of `isapnp_find_dev'
  from incompatible pointer type
sound/isa/opl3sa2.c:643: warning: assignment from incompatible pointer
  type
sound/isa/opl3sa2.c:644: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:650: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:653: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:655: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:657: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:659: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:661: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:663: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:665: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:667: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:668: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:672: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:673: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:674: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:675: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:676: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:677: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:678: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:679: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c: In function `snd_opl3sa2_deactivate':
sound/isa/opl3sa2.c:690: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c: In function `alsa_card_opl3sa2_init':
sound/isa/opl3sa2.c:893: warning: passing arg 2 of
  `isapnp_probe_cards' from incompatible pointer type
make[3]: *** [sound/isa/opl3sa2.o] Fehler 1
make[2]: *** [sound/isa] Fehler 2
make[1]: *** [sound] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.5.42'
make: *** [stamp-build] Fehler 2
/usr/bin/make -f sound/isa/Makefile
  gcc -Wp,-MD,sound/isa/.opl3sa2.o.d -D__KERNEL__ -Iinclude -Wall
  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
  -DMODULE   -DKBUILD_BASENAME=opl3sa2   -c -o sound/isa/opl3sa2.o
  sound/isa/opl3sa2.c
sound/isa/opl3sa2.c: In function `snd_opl3sa2_isapnp':
sound/isa/opl3sa2.c:643: warning: passing arg 1 of `isapnp_find_dev'
  from incompatible pointer type
sound/isa/opl3sa2.c:643: warning: assignment from incompatible pointer
  type
sound/isa/opl3sa2.c:644: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:650: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:653: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:655: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:657: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:659: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:661: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:663: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:665: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:667: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:668: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:672: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:673: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:674: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:675: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:676: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:677: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:678: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c:679: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c: In function `snd_opl3sa2_deactivate':
sound/isa/opl3sa2.c:690: dereferencing pointer to incomplete type
sound/isa/opl3sa2.c: In function `alsa_card_opl3sa2_init':
sound/isa/opl3sa2.c:893: warning: passing arg 2 of
  `isapnp_probe_cards' from incompatible pointer type
make[3]: *** [sound/isa/opl3sa2.o] Fehler 1
make[2]: *** [sound/isa] Fehler 2
make[1]: *** [sound] Fehler 2
make[1]: Leaving directory `/usr/src/linux-2.5.42'
make: *** [stamp-build] Fehler 2


