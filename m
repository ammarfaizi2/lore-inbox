Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbTCWG2T>; Sun, 23 Mar 2003 01:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTCWG2T>; Sun, 23 Mar 2003 01:28:19 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:31872 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262837AbTCWG2T>; Sun, 23 Mar 2003 01:28:19 -0500
Date: Sun, 23 Mar 2003 15:38:29 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.65-ac3] Updates for PC-9800 related (1/5) boot98
Message-ID: <20030323063829.GA2835@yuzuki.cinet.co.jp>
References: <20030323063207.GA2803@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323063207.GA2803@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture related files
against 2.5.65-ac3. (1/5)

Update alsa sound driver for PC-98.
Add missing target for PC-98 lost between 2.5.65-ac2 and 2.5.65-ac3.

Regards,
Osamu Tomita

diff -Nru linux-2.5.65-ac3/sound/core/Makefile linux98-2.5.65-ac3/sound/core/Makefile
--- linux-2.5.65-ac3/sound/core/Makefile	2003-03-23 11:47:19.000000000 +0900
+++ linux98-2.5.65-ac3/sound/core/Makefile	2003-03-23 12:13:28.000000000 +0900
@@ -95,6 +95,7 @@
 obj-$(CONFIG_SND_YMFPCI) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_POWERMAC) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
 obj-$(CONFIG_SND_SA11XX_UDA1341) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
+obj-$(CONFIG_SND_PC98_CS4232) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-hwdep.o
   obj-$(CONFIG_SND_SBAWE) += snd-hwdep.o
