Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTI1KML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 06:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTI1KML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 06:12:11 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:63499 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262379AbTI1KKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 06:10:22 -0400
Date: Sun, 28 Sep 2003 20:10:13 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [WIRELESS] Added probe declaration in arlan-main.c
Message-ID: <20030928101013.GA11057@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The declaration for probe got lost in the move from arlan to arlan-main.
This patch puts it back.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

Index: kernel-source-2.5/drivers/net/wireless/arlan-main.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/net/wireless/arlan-main.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 arlan-main.c
--- kernel-source-2.5/drivers/net/wireless/arlan-main.c	28 Sep 2003 04:44:14 -0000	1.1.1.1
+++ kernel-source-2.5/drivers/net/wireless/arlan-main.c	28 Sep 2003 10:08:11 -0000
@@ -22,6 +22,7 @@
 static char encryptionKey[12] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};
 static int mem = memUNKNOWN;
 int arlan_debug = debugUNKNOWN;
+static int probe = probeUNKNOWN;
 static int numDevices = numDevicesUNKNOWN;
 static int spreadingCode = spreadingCodeUNKNOWN;
 static int channelNumber = channelNumberUNKNOWN;

--9jxsPFA5p3P2qPhR--
