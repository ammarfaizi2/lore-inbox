Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTBGQzT>; Fri, 7 Feb 2003 11:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTBGQzT>; Fri, 7 Feb 2003 11:55:19 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:14079 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266552AbTBGQzS>; Fri, 7 Feb 2003 11:55:18 -0500
Date: Fri, 7 Feb 2003 12:14:23 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : sound/pci/es1968.c
Message-ID: <Pine.LNX.4.44.0302071213330.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 319, and removes an
offending semicolon. Please review for inclusion.

Regards,
Frank

--- linux/sound/pci/es1968.c.old	2003-01-16 21:22:24.000000000 -0500
+++ linux/sound/pci/es1968.c	2003-02-07 02:57:37.000000000 -0500
@@ -2674,7 +2674,7 @@
 	val = oval & ~0x04;
 	if (ucontrol->value.integer.value[0])
 		val |= 0x04;
-	if (val != oval); {
+	if (val != oval) {
 		pci_write_config_word(chip->pci, ESM_LEGACY_AUDIO_CONTROL, val);
 		return 1;
 	}

