Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUIBGAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUIBGAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267596AbUIBGAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:00:30 -0400
Received: from sweep.bur.st ([202.61.227.58]:15111 "EHLO sweep.bur.st")
	by vger.kernel.org with ESMTP id S267602AbUIBF7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 01:59:46 -0400
Date: Thu, 2 Sep 2004 13:59:44 +0800
From: Trent Lloyd <lathiat@bur.st>
To: linux-kernel@vger.kernel.org
Subject: OPL3-SA2 and mixers (and yes, I read the docs)
Message-ID: <20040902055944.GA9855@sweep.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Random-Number: 8.28412526975728e+81
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Just a concern regarding the OPL3SA2 driver

I know it creates 2 mixers, and it does for me, however the first
refuses to work in anything I ry (aumix, rexima, gnome volume controls,
etc)

the second works for PCM, but my speakers are still fairly quiet, so I
figure I need to turn something up in the first mixer, which refuses to
work :)

As an example:
gateway:/home/lathiat# aumix -I -d /dev/mixer
 aumix:  SOUND_MIXER_READ_DEVMASK
 gateway:/home/lathiat# 

No idea what this means, but I read elsewhere this command works, so not
sure whats up.

Also the ALSA driver refuses to work, hence im using the OSS one (the
ALSA one either refuses to load or when it loads gets no sound,
depending on various option tweaks)

Anyone got any idea why the first mixer isnt working?

oh and,
gateway:/home/lathiat# uname -a
Linux gateway 2.6.8.1 #1 Wed Aug 25 17:11:54 WST 2004 i686 GNU/Linux

--- dmesg except ---
opl3sa2: Chipset version = 0x3
opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)
opl3sa2: 1 PnP card(s) found.

and io_port=0x220, irq=9, dma1=0, dma2=1, doubt thatl make any
difference tho, with the exception that mss_io might need to be set to
something? not sure on that...

Cheers,
Trent
Bur.st

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
