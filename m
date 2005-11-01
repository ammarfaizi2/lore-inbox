Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVKAIQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVKAIQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVKAIQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:16:31 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:14197 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965079AbVKAIQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:16:23 -0500
Message-ID: <43672430.5070501@m1k.net>
Date: Tue, 01 Nov 2005 03:15:44 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 29/37] dvb: fixed inittab register 0x12 for BSRU6/BSBE1
Content-Type: multipart/mixed;
 boundary="------------020706080309070802030408"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020706080309070802030408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------020706080309070802030408
Content-Type: text/x-patch;
 name="2406.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2406.patch"

From: Oliver Endriss <o.endriss@gmx.de>

fixed inittab register 0x12 for BSRU6/BSBE1

Signed-off-by: Oliver Endriss <o.endriss@gmx.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ linux-2.6.14-git3/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -1198,7 +1198,7 @@
         0x0e, 0x23,             /* alpha_tmg = 2, beta_tmg = 3 */
         0x10, 0x3f,             // AGC2  0x3d
         0x11, 0x84,
-        0x12, 0xb5,             // Lock detect: -64  Carrier freq detect:on
+        0x12, 0xb9,
         0x15, 0xc9,             // lock detector threshold
         0x16, 0x00,
         0x17, 0x00,
@@ -1240,7 +1240,7 @@
 	0x0e, 0x23,		/* alpha_tmg = 2, beta_tmg = 3 */
 	0x10, 0x3f,		// AGC2  0x3d
 	0x11, 0x84,
-	0x12, 0xb5,		// Lock detect: -64  Carrier freq detect:on
+	0x12, 0xb9,
 	0x15, 0xc9,		// lock detector threshold
 	0x16, 0x00,
 	0x17, 0x00,


--------------020706080309070802030408--
