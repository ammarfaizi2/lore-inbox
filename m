Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSJAQ4x>; Tue, 1 Oct 2002 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbSJAQ4k>; Tue, 1 Oct 2002 12:56:40 -0400
Received: from gate.perex.cz ([194.212.165.105]:38663 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262130AbSJAQ4U>;
	Tue, 1 Oct 2002 12:56:20 -0400
Date: Tue, 1 Oct 2002 18:57:58 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [8/12] - 2002/09/06
Message-ID: <Pine.LNX.4.33.0210011856450.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A big one. Please, download it here:
ftp://ftp.alsa-project.org/pub/kernel-patches/set#2/8.patch

						Jaroslav

ChangeSet@1.651, 2002-10-01 14:44:13+02:00, perex@suse.cz
  ALSA update 2002/09/06 :
    - VIA686 and VIA8233 driver merge to VIA82xx
    - ioctl32 fixes
    - fixed OOPS in snd_pcm_sgbuf_delete (not initialized)
    - I2C - call hw_stop() before returning at the error pointer
    - AC'97 codec - added more AC97 IDs by Laszlo Melis
    - CS46xx - mutex initialization fix
    - ENS1371 - added one more card to S/PDIF capabilities
    - intel8x0
      - fixed secondary and third codec indexes
    - PPC Keywest - initialize MCS in loop until it succeeds
    - PPC Tumbler - the initial support for snapper (TAS3004) on some tibook
    - USB Audio - mixer fixes


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

