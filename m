Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSLJLjN>; Tue, 10 Dec 2002 06:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266767AbSLJLjN>; Tue, 10 Dec 2002 06:39:13 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1540 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266763AbSLJLjM>;
	Tue, 10 Dec 2002 06:39:12 -0500
Date: Tue, 10 Dec 2002 11:58:28 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200212101158.gBABwSnr003646@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 breaks ALSA AWE32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make -f scripts/Makefile.build obj=sound/synth/emux
   ld -m elf_i386  -r -o sound/synth/built-in.o sound/synth/emux/built-in.o
ld: cannot open sound/synth/emux/built-in.o: No such file or directory
make[2]: *** [sound/synth/built-in.o] Error 1
make[1]: *** [sound/synth] Error 2
make: *** [sound] Error 2

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
CONFIG_SND_SBAWE=y
# CONFIG_SND_SB16_CSP is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

John
