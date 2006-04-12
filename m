Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDLKAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDLKAF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 06:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWDLKAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 06:00:05 -0400
Received: from gate.perex.cz ([85.132.177.35]:22147 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932129AbWDLKAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 06:00:02 -0400
Date: Wed, 12 Apr 2006 12:00:00 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] update
Message-ID: <Pine.LNX.4.61.0604121158120.22163@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-04-12.patch.gz

The following files will be updated:

 include/sound/pcm.h                |    3 +--
 sound/core/oss/pcm_oss.c           |    7 ++++---
 sound/core/pcm.c                   |    2 +-
 sound/core/pcm_native.c            |    6 ++++--
 sound/isa/ad1848/ad1848.c          |   16 +++++++---------
 sound/isa/adlib.c                  |   11 +++++++----
 sound/isa/cmi8330.c                |   16 +++++++---------
 sound/isa/cs423x/cs4231.c          |   16 +++++++---------
 sound/isa/cs423x/cs4236.c          |   16 +++++++---------
 sound/isa/es1688/es1688.c          |   16 +++++++---------
 sound/isa/es18xx.c                 |   16 +++++++---------
 sound/isa/gus/gusclassic.c         |   16 +++++++---------
 sound/isa/gus/gusextreme.c         |   16 +++++++---------
 sound/isa/gus/gusmax.c             |   16 +++++++---------
 sound/isa/gus/interwave.c          |   16 +++++++---------
 sound/isa/opl3sa2.c                |   16 +++++++---------
 sound/isa/opti9xx/miro.c           |    7 +++++--
 sound/isa/opti9xx/opti92x-ad1848.c |    7 +++++--
 sound/isa/sb/sb16.c                |   16 +++++++---------
 sound/isa/sb/sb8.c                 |   16 +++++++---------
 sound/isa/sgalaxy.c                |   16 +++++++---------
 sound/isa/sscape.c                 |   16 +++++++---------
 sound/isa/wavefront/wavefront.c    |   16 +++++++---------
 sound/pci/ac97/ac97_codec.c        |    1 +
 sound/pci/au88x0/au88x0.h          |   13 ++++++-------
 sound/pci/au88x0/au88x0_core.c     |    2 +-
 sound/pci/au88x0/au88x0_eq.c       |    2 +-
 sound/pci/au88x0/au88x0_pcm.c      |    2 +-
 sound/pci/emu10k1/emu10k1_main.c   |    5 ++++-
 sound/pci/hda/patch_analog.c       |    6 ++++++
 sound/pci/hda/patch_sigmatel.c     |    3 +++
 sound/pci/via82xx.c                |    1 +
 32 files changed, 163 insertions(+), 171 deletions(-)


The following things were done:

Adrian Bunk:
      [ALSA] sound/core/pcm.c: make snd_pcm_format_name() static

Ashley Clark:
      [ALSA] hda-codec - Adds HDA support for Intel D945Pvs board with subdevice id 0x0707

Coywolf Qi Hunt:
      [ALSA] hda-codec - support HP Compaq Presario B2800 laptop with AD1986A codec

Dale Sedivec:
      [ALSA] au88x0 - clean up __devinit/__devexit

Eric Sesterhenn:
      [ALSA] Overrun in sound/pci/au88x0/au88x0_pcm.c

James Courtier-Dutton:
      [ALSA] emu10k1: Add some descriptive text.

OGAWA Hirofumi:
      [ALSA] pcm_oss: fix snd_pcm_oss_release() oops

Rene Herman:
      [ALSA] continue on IS_ERR from platform device registration
      [ALSA] unregister platform device again if probe was unsuccessful

Takashi Iwai:
      [ALSA] Fix Oops of PCM OSS emulation
      [ALSA] hda-codec - Add another HP laptop with AD1981HD
      [ALSA] via82xx - Add a dxs entry for ECS K8T890-A
      [ALSA] hda-codec - Add support of ASUS U5A with AD1986A codec
      [ALSA] ac97 - Add entry for VIA VT1618 codec

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
