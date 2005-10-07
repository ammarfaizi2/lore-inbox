Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbVJGONe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVJGONe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbVJGONd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:13:33 -0400
Received: from gate.perex.cz ([85.132.177.35]:39386 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S932656AbVJGONd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:13:33 -0400
Date: Fri, 7 Oct 2005 16:13:31 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [ALSA PATCH] Small patches for 2.6.14
Message-ID: <Pine.LNX.4.61.0510071605300.8709@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2005-10-07.patch.gz

Additional notes:

  The repository contains only small fixes/patches for 2.6.14 final.

The following files will be updated:

 include/sound/ac97_codec.h       |    2 +
 include/sound/emu10k1.h          |    2 -
 sound/arm/pxa2xx-ac97.c          |    2 -
 sound/isa/opl3sa2.c              |    2 +
 sound/pci/ac97/ac97_bus.c        |   23 +++++------------
 sound/pci/ac97/ac97_codec.c      |    3 --
 sound/pci/ac97/ac97_patch.c      |    6 +++-
 sound/pci/ali5451/ali5451.c      |    6 +++-
 sound/pci/emu10k1/emu10k1_main.c |    5 +++
 sound/pci/emu10k1/emumixer.c     |   11 +++++++-
 sound/pci/hda/hda_generic.c      |    6 +---
 sound/pci/hda/hda_intel.c        |    5 +++
 sound/pci/hda/patch_realtek.c    |   22 +++--------------
 sound/pci/korg1212/korg1212.c    |    2 -
 sound/pci/via82xx.c              |    2 +
 sound/ppc/pmac.c                 |    1 
 sound/usb/usbaudio.c             |    8 +++---
 sound/usb/usbmixer_maps.c        |   10 +++++++
 sound/usb/usbquirks.h            |   50 ++++++++++++++++++++++++++++++++++++++-
 19 files changed, 115 insertions(+), 53 deletions(-)

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
