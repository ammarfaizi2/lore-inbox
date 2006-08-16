Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWHPRVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWHPRVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHPRVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:21:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:53927 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751211AbWHPRVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:21:54 -0400
X-Authenticated: #1347008
Message-ID: <44E3552A.6010705@gmx.net>
Date: Wed, 16 Aug 2006 19:26:02 +0200
From: Dirk <noisyb@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060503 Debian/1.7.8-1sarge6
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH/FIX for drivers/cdrom/cdrom.c
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------040201080600030204000501"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040201080600030204000501
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have changed a message that didn't clearly tell the user what was goin
on...

Please have a look!

Thank you,
Dirk

--------------040201080600030204000501
Content-Type: text/plain;
 name="cdrom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdrom.patch"

--- drivers/cdrom/cdrom.c.old	2006-08-16 19:04:11.000000000 +0200
+++ drivers/cdrom/cdrom.c	2006-08-16 19:04:51.000000000 +0200
@@ -2455,7 +2455,7 @@
 		if (tracks.data > 0) return CDS_DATA_1;
 		/* Policy mode off */
 
-		cdinfo(CD_WARNING,"This disc doesn't have any tracks I recognize!\n");
+		cdinfo(CD_WARNING,"I'm a stupid fuck that will repeat this interesting message while endlessly trying to access the media you just inserted until your CD/DVD burning task is eventually fucked\n");
 		return CDS_NO_INFO;
 		}
 

--------------040201080600030204000501--
