Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTHAAtG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274894AbTHAAtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:49:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26265 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270641AbTHAAtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:49:02 -0400
Date: Fri, 1 Aug 2003 02:48:32 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jaroslav Kysela <perex@suse.cz>
cc: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>
Subject: [TRIVIAL][2.6.0-test2] move "config SOUND" to sound/Kconfig
Message-ID: <Pine.SOL.4.30.0308010240010.3421-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

http://home.elka.pw.edu.pl/~bzolnier/sound-Kconfig.patch
[ I think there is no need to increase traffic... ]

move "config SOUND" to sound/Kconfig

Allows all architectures to simply include the sound/Kconfig file.
Now somebody can finally update comment for CONFIG_SOUND ;-).

 arch/alpha/Kconfig     |   34 ----------------------------------
 arch/arm/Kconfig       |   35 ++---------------------------------
 arch/arm26/Kconfig     |   35 ++---------------------------------
 arch/cris/Kconfig      |   35 -----------------------------------
 arch/i386/Kconfig      |   34 ----------------------------------
 arch/ia64/Kconfig      |   19 -------------------
 arch/m68k/Kconfig      |   10 +---------
 arch/m68knommu/Kconfig |   34 ----------------------------------
 arch/parisc/Kconfig    |   34 ----------------------------------
 arch/ppc/Kconfig       |   37 -------------------------------------
 arch/ppc64/Kconfig     |   34 ----------------------------------
 arch/sh/Kconfig        |   34 ----------------------------------
 arch/sparc/Kconfig     |   35 -----------------------------------
 arch/sparc64/Kconfig   |   35 -----------------------------------
 arch/v850/Kconfig      |   34 ----------------------------------
 arch/x86_64/Kconfig    |   35 -----------------------------------
 sound/Kconfig          |   41 +++++++++++++++++++++++++++++++++++++++++
 17 files changed, 46 insertions(+), 509 deletions(-)

--
Bartlomiej

