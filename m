Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTBISvS>; Sun, 9 Feb 2003 13:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTBISvS>; Sun, 9 Feb 2003 13:51:18 -0500
Received: from gate.perex.cz ([194.212.165.105]:61201 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267423AbTBISvR>;
	Sun, 9 Feb 2003 13:51:17 -0500
Date: Sun, 9 Feb 2003 20:00:37 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA update
Message-ID: <Pine.LNX.4.44.0302091958440.20215-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

  bk pull http://linux-sound.bkbits.net/linux-sound

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2003-02-09.patch.gz

Additional notes:

  This small patch will fix compilation problems for USB and PPC drivers.

The pull command will update the following files:

 include/sound/asound.h  |    1 -
 include/sound/timer.h   |    1 +
 include/sound/version.h |    2 +-
 sound/ppc/pmac.c        |    4 ++++
 sound/ppc/powermac.c    |    2 ++
 sound/ppc/tumbler.c     |    1 +
 sound/usb/usbaudio.c    |    4 ++--
 7 files changed, 11 insertions(+), 4 deletions(-)

through these ChangeSets:

<perex@suse.cz> (03/02/09 1.1015)
   ALSA update
     - moved inclusion of <linux/interrupt.h> from <sound/asound.h> to <sound/timer.h>
     - pmac driver - removed beep stuff for 2.5 kernels
     - USB driver - fixed compilation


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

