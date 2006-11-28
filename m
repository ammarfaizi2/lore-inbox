Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935203AbWK1OLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935203AbWK1OLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 09:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935219AbWK1OLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 09:11:22 -0500
Received: from gate.perex.cz ([212.20.107.50]:57561 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S935203AbWK1OLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 09:11:21 -0500
Date: Tue, 28 Nov 2006 15:11:19 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0611281509030.29580@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-11-28.patch.gz

Additional notes:

  This update contains only serious fixes.


The following files will be updated:

 include/sound/version.h              |    2 +-
 sound/aoa/codecs/snd-aoa-codec-tas.c |   13 +++++++++----
 sound/core/oss/pcm_oss.c             |    3 ++-
 sound/core/pcm_native.c              |    6 ++++--
 sound/core/rtctimer.c                |   20 ++++++++++++++------
 sound/pci/emu10k1/emu10k1_main.c     |    1 +
 sound/pci/hda/patch_realtek.c        |    2 +-
 sound/pci/hda/patch_sigmatel.c       |   14 +++++++-------
 sound/usb/usbaudio.c                 |    3 ++-
 9 files changed, 41 insertions(+), 23 deletions(-)


The following things were done:

Clemens Ladisch:
      [ALSA] rtctimer: handle RTC interrupts with a tasklet

James Courtier-Dutton:
      [ALSA] snd-emu10k1: Fix capture for one variant.

Jaroslav Kysela:
      [ALSA] version 1.0.13

John W. Linville:
      [ALSA] hda: fix typo for xw4400 PCI sub-ID

Matt Porter:
      [ALSA] hda: fix sigmatel dell system detection

Paul Mackerras:
      [ALSA] Enable stereo line input for TAS codec

Takashi Iwai:
      [ALSA] Fix hang-up at disconnection of usb-audio


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
