Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315324AbSEAGml>; Wed, 1 May 2002 02:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315325AbSEAGmk>; Wed, 1 May 2002 02:42:40 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:54020 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S315324AbSEAGmj>; Wed, 1 May 2002 02:42:39 -0400
Subject: 2.5.12 -- ALSA build error "sound/sound.o: In function
	`snd_pcm_period_elapsed' undefined reference to `snd_timer_interrupt'"
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 30 Apr 2002 23:40:28 -0700
Message-Id: <1020235229.16071.12.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/sound.o: In function `snd_pcm_period_elapsed':
sound/sound.o(.text+0x1b62a): undefined reference to
`snd_timer_interrupt'
sound/sound.o: In function `snd_pcm_timer_init':
sound/sound.o(.text+0x1ccaa): undefined reference to `snd_timer_new'
make: *** [vmlinux] Error 1

CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_EMU10K1=m


