Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262182AbSJAQuG>; Tue, 1 Oct 2002 12:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbSJAQtT>; Tue, 1 Oct 2002 12:49:19 -0400
Received: from gate.perex.cz ([194.212.165.105]:36615 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262173AbSJAQsr>;
	Tue, 1 Oct 2002 12:48:47 -0400
Date: Tue, 1 Oct 2002 18:50:20 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [7/12] - 2002/08/26
Message-ID: <Pine.LNX.4.33.0210011848520.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A big one. Please, download it here:
ftp://ftp.alsa-project.org/pub/kernel-patches/set#2/7.patch

						Jaroslav

ChangeSet@1.650, 2002-10-01 14:17:46+02:00, perex@suse.cz
  ALSA update 2002/08/26 :
    - AC'97 codec
      - added ac97_can_amap() condition
      - removed powerup/powerdown sequence when sample rate is changed
      - added ac97_is_rev22 check function
      - added AC97_EI_* defines
      - available rates are in array
    - CS46xx
      - improved the SCB link mechanism
      - SMP deadlock should have been fixed now
    - OSS mixer emulation
      - added the proc interface for the configuration of OSS mixer volumes
    - rawmidi midlevel
      - removed unused snd_rawmidi_transmit_reset and snd_rawmidi_receive_reset functions
    - USB MIDI driver
      - integration of USB MIDI driver into USB audio driver by Clemens
    - intel8x0 - the big intel8x0 driver update
      - added support for ICH4
      - rewrited I/O (the third AC'97 codec registers are available only through memory)
      - code cleanups
      - ALI5455 specific code
      - added proc interface
    - VIA686, VIA8233
      - set the max periods to 128


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

