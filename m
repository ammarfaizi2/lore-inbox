Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262156AbSJAQmo>; Tue, 1 Oct 2002 12:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSJAQmo>; Tue, 1 Oct 2002 12:42:44 -0400
Received: from gate.perex.cz ([194.212.165.105]:32007 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262156AbSJAQmn>;
	Tue, 1 Oct 2002 12:42:43 -0400
Date: Tue, 1 Oct 2002 18:44:27 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2nd ALSA update [3/12] - 2002/08/13
Message-ID: <Pine.LNX.4.33.0210011842080.20016-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A big one. Please, download it here:
ftp://ftp.alsa-project.org/pub/kernel-patches/set#2/3.patch

						Jaroslav

ChangeSet@1.646, 2002-10-01 09:03:23+02:00, perex@suse.cz
  ALSA update 2002/08/13 :
    - C99-like structure initializers - first bunch of changes
    - CS46xx
      - fixed the compile with the older image
    - AC'97 codec
      - added the ids for ITE chips
      - check the validity of registers always in the limited register mode
    - intel8x0
      - allow ICH4 to proceed without probing PCR / SCR bits
    - VIA686
      - AC97 cold reset only when AC-link is down


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

