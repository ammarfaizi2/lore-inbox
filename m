Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSJ2RhA>; Tue, 29 Oct 2002 12:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262346AbSJ2RhA>; Tue, 29 Oct 2002 12:37:00 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:20352 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262324AbSJ2Rg7>; Tue, 29 Oct 2002 12:36:59 -0500
Message-ID: <3DBEC8BA.F2043BEF@cinet.co.jp>
Date: Wed, 30 Oct 2002 02:43:22 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.44-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET 22/25] add support for PC-9800 architecture (sound alsa)
References: <20021026115417.A1424@precia.cinet.co.jp>
		<s5hu1j630qh.wl@alsa2.suse.de> <s5hsmyp36c4.wl@alsa2.suse.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
> 
> Hi,
> 
> the attached is a patch to create a new driver module,
> snd-pc98-cs4232, which supports CS4232 on PC9800 and PC98II MPU
> daughterboard.  (if you find the module name weird, please change as
> you like.  the name is tentative :)
> in this patch, almost all pc98-specific hardware initialization is
> done in the card module, hence the changes to common modules become
> minimum.
(snip)
> please check whether it works for you.  if it's ok, i'd like to merge
> it into alsa cvs, so the changes will be sent as ALSA update patches
> later.
Thank you very much. I'm testing patch. And found some problems.
sound/drivers/opl3/Makefile, sound/core/Makefile, sound/core/seq/Makefile
and sound/core/seq/instr/Makefile needed additional patch for compile.
PCM works fine. But mpu401 plays very slow tempo. I can't find reason
yet.

Regards,
Osamu Tomita
