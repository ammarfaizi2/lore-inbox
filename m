Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRIETLX>; Wed, 5 Sep 2001 15:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272274AbRIETLN>; Wed, 5 Sep 2001 15:11:13 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:64520 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272265AbRIETLC>;
	Wed, 5 Sep 2001 15:11:02 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 19:50:53 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Ollie Lho <ollie@sis.com.tw>
cc: linux-kernel@vger.kernel.org
Subject: PATCH : remove documentation warnings in sis900
Message-ID: <Pine.LNX.4.21.0109051947560.20371-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch removes two warnings when making kernel docs. Applies
cleanly to 2.4.10-pre4 and 2.4.9-ac6.

diff -urN linux-2.4.7/drivers/net/sis900.c altered-2.4.7/drivers/net/sis900.c
--- linux-2.4.7/drivers/net/sis900.c	Sat Jul 21 22:48:09 2001
+++ altered-2.4.7/drivers/net/sis900.c	Fri Aug 24 21:11:43 2001
@@ -600,7 +600,7 @@
 /**
  * 	sis900_set_capability: - set the media capability of network adapter.
  *	@net_dev : the net device to probe for
- *	@mii_phy : default PHY
+ *	@phy : default PHY
  *
  *	Set the media capability of network adapter according to
  *	mii status register. It's necessary before auto-negotiate.
@@ -1190,6 +1190,7 @@
 
 /**
  *	sis900_set_mode: - Set the media mode of mac register.
+ *	@ioaddr: the address of the device
  *	@speed : the transmit speed to be determined
  *	@duplex: the duplex mode to be determined
  *

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

