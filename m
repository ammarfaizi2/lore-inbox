Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSGUNvH>; Sun, 21 Jul 2002 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSGUNvH>; Sun, 21 Jul 2002 09:51:07 -0400
Received: from dclient217-162-176-181.hispeed.ch ([217.162.176.181]:5892 "EHLO
	alder.intra.bruli.net") by vger.kernel.org with ESMTP
	id <S315805AbSGUNvG>; Sun, 21 Jul 2002 09:51:06 -0400
Date: Sun, 21 Jul 2002 15:54:10 +0200
From: Martin Brulisauer <bruli@uceb.org>
Message-Id: <200207211354.g6LDsADU005586@alder.intra.bruli.net>
To: thunder@ngforever.de
Subject: Re: kbuild 2.5.26 - arch/alpha
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>On Sat, 20 Jul 2002, Martin Brulisauer wrote:
>> Is the kernel arch tree for alphas not maintained anymore? If I download
>> the vanilla 2.5.26 I can't build it at all. Even a make clean fails
>> due to missing directives in arch/alpha/kernel/Makefile.
>
>On Sat, 20 Jul 2002, Thunder from the hill wrote:
>What exactly are you experiencing?
>

make mrproper:	ok.
make defconfig:	ok.
make dep:

make[1]: Entering directory `/usr/src/linux-2.5.27'
make[1]: Nothing to be done for `include/linux/modversions.h'.
make[1]: Leaving directory `/usr/src/linux-2.5.27'

make boot:

make[1]: Entering directory `/usr/src/linux-2.5.27/scripts'
  gcc -Wp,-MD,./.split-include.d -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer   -o split-include split-include.c
In file included from /usr/include/linux/errno.h:4,
                 from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from split-include.c:26:
/usr/include/asm/errno.h:4: asm-generic/errno-base.h: No such file or directory
make[1]: *** [split-include] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.27/scripts'
make: *** [scripts] Error 2


make clean:

make[1]: Entering directory `/usr/src/linux-2.5.27/arch/alpha/kernel'
make[1]: *** No rule to make target `clean'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.5.27/arch/alpha/kernel'
make: *** [archclean] Error 2


Looks to me like noone ever tried to compile this
kernel on this platform. That is why I asked my
silly question.

Regards,
Martin

