Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSEPJ37>; Thu, 16 May 2002 05:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316618AbSEPJ36>; Thu, 16 May 2002 05:29:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:30399 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316617AbSEPJ36>;
	Thu, 16 May 2002 05:29:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [patch] 2.4.19-pre8 remove duplicate CONFIG_SOUND_EMU10K1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 May 2002 19:28:48 +1000
Message-ID: <32491.1021541328@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SOUND_EMU10K1 += ac97_codec.o occurs twice.
To be sure, to be sure ....

Index: 19-pre8.1/drivers/sound/Makefile
--- 19-pre8.1/drivers/sound/Makefile Fri, 01 Mar 2002 11:01:28 +1100 kaos (linux-2.4/P/b/4_Makefile 1.3.2.2.1.3.1.2 644)
+++ 19-pre8.1(w)/drivers/sound/Makefile Thu, 16 May 2002 19:25:13 +1000 kaos (linux-2.4/P/b/4_Makefile 1.3.2.2.1.3.1.2 644)
@@ -75,7 +75,6 @@ obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_code
 obj-$(CONFIG_SOUND_BCM_CS4297A)	+= swarm_cs4297a.o
 obj-$(CONFIG_SOUND_RME96XX)     += rme96xx.o
 obj-$(CONFIG_SOUND_BT878)	+= btaudio.o
-obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_codec.o
 obj-$(CONFIG_SOUND_IT8172)	+= ite8172.o ac97_codec.o
 
 ifeq ($(CONFIG_MIDI_EMU10K1),y)

