Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272269AbRIETLe>; Wed, 5 Sep 2001 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272274AbRIETLY>; Wed, 5 Sep 2001 15:11:24 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:65288 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272268AbRIETLF>;
	Wed, 5 Sep 2001 15:11:05 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 19:47:46 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: PATCH : remove warning in documentation for via_audio
Message-ID: <Pine.LNX.4.21.0109051945030.20371-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch removes a warning when the documentation is built. Applies
cleanly to 2.4.10-pre4, and with a 4-line offset to 2.4.9-ac6.

diff -urN linux-2.4.7/drivers/sound/via82cxxx_audio.c altered-2.4.7/drivers/sound/via82cxxx_audio.c
--- linux-2.4.7/drivers/sound/via82cxxx_audio.c	Sat Jul 21 22:47:35 2001
+++ altered-2.4.7/drivers/sound/via82cxxx_audio.c	Thu Aug 23 20:14:57 2001
@@ -862,6 +862,7 @@
 
 /**
  *	via_chan_clear - Stop DMA channel operation, and reset pointers
+ *	@card: the chip to accessed
  *	@chan: Channel to be cleared
  *
  *	Call via_chan_stop to halt DMA operations, and then resets

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

