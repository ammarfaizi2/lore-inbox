Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSFIH1B>; Sun, 9 Jun 2002 03:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317556AbSFIH1A>; Sun, 9 Jun 2002 03:27:00 -0400
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:30726 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317448AbSFIH1A>; Sun, 9 Jun 2002 03:27:00 -0400
Subject: 2.5.21 -- emumpu401.c:309: parse error before "emu10k1_midi_init"
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 09 Jun 2002 00:24:41 -0700
Message-Id: <1023607481.5775.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  gcc -Wp,-MD,.emumpu401.o.d -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=emumpu401   -c -o emumpu401.o emumpu401.c
emumpu401.c:309: parse error before "emu10k1_midi_init"
emumpu401.c:310: warning: return type defaults to `int'
emumpu401.c:332: parse error before "snd_emu10k1_midi"
emumpu401.c:333: warning: return type defaults to `int'
emumpu401.c:349: parse error before "snd_emu10k1_audigy_midi"
emumpu401.c:350: warning: return type defaults to `int'
make[3]: *** [emumpu401.o] Error 1
make[3]: Leaving directory `/usr/src/linux/sound/pci/emu10k1'

CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_VIRMIDI=m

#
# PCI devices
#
CONFIG_SND_EMU10K1=m


