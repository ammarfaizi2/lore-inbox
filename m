Return-Path: <linux-kernel-owner+w=401wt.eu-S932100AbXAIOE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbXAIOE2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 09:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbXAIOE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 09:04:28 -0500
Received: from gate.perex.cz ([212.20.107.50]:54872 "EHLO gate.perex.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbXAIOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 09:04:27 -0500
Date: Tue, 9 Jan 2007 15:04:26 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@tm8103.perex-int.cz
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Takashi Iwai <tiwai@suse.de>
Subject: [ALSA PATCH] alsa-git merge request
Message-ID: <Pine.LNX.4.61.0701091413250.7910@tm8103.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do an update from:

  http://www.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git
  (linus branch)

The GNU patch is available at:

  ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-git-2007-01-09.patch.gz


The following files will be updated:

 include/sound/version.h     |    2 +-
 sound/pci/cmipci.c          |    3 ++-
 sound/pci/echoaudio/midi.c  |    6 ++++--
 sound/pci/hda/hda_generic.c |    5 +++--
 sound/pci/hda/hda_intel.c   |   14 +++++++++++---
 sound/usb/usbaudio.c        |   10 ++++++++--
 sound/usb/usbmixer.c        |    2 +-
 7 files changed, 30 insertions(+), 12 deletions(-)


The following things were done:

Clemens Ladisch:
      [ALSA] usb-audio: work around wrong frequency in CM6501 descriptors

Giuliano Pochini:
      [ALSA] Fix potential NULL pointer dereference in echoaudio midi

Jaroslav Kysela:
      [ALSA] version 1.0.14rc1

Jason Gaston:
      [ALSA] hda_intel: ALSA HD Audio patch for Intel ICH9

Mariusz Kozlowski:
      [ALSA] usb: usbmixer error path fix

Peer Chen:
      [ALSA] Audio: Add nvidia HD Audio controllers of MCP67 support to hda_intel.c

Takashi Iwai:
      [ALSA] hda-codec - Fix NULL dereference in generic hda code
      [ALSA] usbaudio - Fix kobject_add() error at reconnection

Timofei V. Bondarenko:
      [ALSA] _snd_cmipci_uswitch_put doesn't set zero flags

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
