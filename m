Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWJVJJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWJVJJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWJVJJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:09:07 -0400
Received: from gate.perex.cz ([85.132.177.35]:34989 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932307AbWJVJJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:09:06 -0400
Date: Sun, 22 Oct 2006 11:09:02 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0610221105120.9461@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2006-10-22.patch.gz

Additional notes:

  This patch contains fixes, cleanups and new device IDs.


The following files will be updated:

 include/sound/version.h                |    2 -
 sound/core/control.c                   |    4 --
 sound/core/info.c                      |    5 ++
 sound/isa/Kconfig                      |    1 
 sound/isa/ad1816a/ad1816a.c            |    2 +
 sound/isa/cmi8330.c                    |    2 +
 sound/isa/gus/interwave.c              |    2 +
 sound/isa/opti9xx/opti92x-ad1848.c     |    2 +
 sound/pci/ac97/ac97_codec.c            |    8 +---
 sound/pci/ali5451/ali5451.c            |   11 +++++
 sound/pci/als300.c                     |   11 ++++-
 sound/pci/als4000.c                    |   11 ++++-
 sound/pci/atiixp.c                     |   11 ++++-
 sound/pci/atiixp_modem.c               |   11 ++++-
 sound/pci/azt3328.c                    |   11 ++++-
 sound/pci/cmipci.c                     |   11 ++++-
 sound/pci/cs4281.c                     |    9 ++++
 sound/pci/cs46xx/cs46xx_lib.c          |   11 +++++
 sound/pci/cs5535audio/cs5535audio_pm.c |   11 ++++-
 sound/pci/emu10k1/emu10k1.c            |   13 ++++--
 sound/pci/ens1370.c                    |   12 ++++-
 sound/pci/es1938.c                     |   29 +++++++++++--
 sound/pci/es1968.c                     |   71 +++++---------------------------
 sound/pci/fm801.c                      |   11 ++++-
 sound/pci/hda/hda_intel.c              |   35 +++++++++++-----
 sound/pci/hda/patch_analog.c           |    2 +
 sound/pci/hda/patch_atihdmi.c          |    1 
 sound/pci/hda/patch_realtek.c          |    4 +-
 sound/pci/intel8x0.c                   |   23 +++++++++-
 sound/pci/intel8x0m.c                  |   23 +++++++++-
 sound/pci/maestro3.c                   |   13 ++++--
 sound/pci/nm256/nm256.c                |   12 +++++
 sound/pci/riptide/riptide.c            |   11 ++++-
 sound/pci/trident/trident_main.c       |   18 ++++----
 sound/pci/via82xx.c                    |   12 ++++-
 sound/pci/via82xx_modem.c              |   12 ++++-
 sound/pci/vx222/vx222.c                |   11 ++++-
 sound/pci/ymfpci/ymfpci_main.c         |    9 ++++
 38 files changed, 299 insertions(+), 159 deletions(-)


The following things were done:

Amit Choudhary:
      [ALSA] sound/isa/gus/interwave.c: check kmalloc() return value
      [ALSA] sound/isa/cmi8330.c: check kmalloc() return value
      [ALSA] sound/isa/ad1816a/ad1816a.c: check kmalloc() return value
      [ALSA] sound/isa/opti9xx/opti92x-ad1848.c: check kmalloc() return value

Felix Kuehling:
      [ALSA] hda_intel: add ATI RS690 HDMI audio support

Jaroslav Kysela:
      [ALSA] version 1.0.13

Takashi Iwai:
      [ALSA] hda-codec - Fix assignment of PCM devices for Realtek codecs
      [ALSA] Various fixes for suspend/resume of ALSA PCI drivers
      [ALSA] Fix dependency of snd-adlib driver in Kconfig
      [ALSA] hda-codec - Add model entry for ASUS U5F laptop
      [ALSA] Fix re-use of va_list
      [ALSA] Fix AC97 power-saving mode
      [ALSA] Fix addition of user-defined boolean controls

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
