Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262249AbSJARIb>; Tue, 1 Oct 2002 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSJARIa>; Tue, 1 Oct 2002 13:08:30 -0400
Received: from gate.perex.cz ([194.212.165.105]:43271 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262229AbSJARCM>;
	Tue, 1 Oct 2002 13:02:12 -0400
Date: Tue, 1 Oct 2002 19:03:49 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [12/12] - 2002/10/01
Message-ID: <Pine.LNX.4.33.0210011901490.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The last and big one. Please, download it here:
ftp://ftp.alsa-project.org/pub/kernel-patches/set#2/12.patch

						Jaroslav

ChangeSet@1.655, 2002-10-01 16:59:17+02:00, perex@suse.cz
  ALSA update 2002/10/01 :
    - deleted sound/pci/ice1712.c
    - fixed Makefile to point to sound/pci/ice1712 directory
    - added Ensoniq SoundScape header file and HWDEP IFACE
    - CS4231
      - added CS4231_HW_AD1845 and register definitions for AD1845
    - USB
      - added snd-rawmidi.o to the snd-usb-audio's dependency
    - PCI DMA allocation
      - fixed the wrapper again
    - AC'97 codec
      - added HSD11246 identification (Conexant), a bit improved proc contents
    - CMIPCI
      - changed the DMA configuration for period size
      - fixed compile with SOFT_AC3 option
      - added PCM_INFO_PAUSE to hw settings.  now pause should work properly
      - corrected the modem on/off bit (FLINK)
    - ICE1712
      - compilation fixes
    - intel8x0
      - use mmio for codec on nforce (pci resource 2)
      - clean up and fix ali5455 codes
    - RME32
      - enable 88.2/96kHz on capture with CS8414
    - VIA82xx
      - fixed the size of allocated bd array to be released
      - fixed the allocation size of idx_table
    - PPC Awacs
      - replaced one more mdelay() with schedule
      - try to touch mic boost on screamer at init
    - USB Audio
      - reset each interface at initialization
      - reset the old interface if a new interface is chosen
      - don't claim the interface which already claimed


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

