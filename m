Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbTDAS03>; Tue, 1 Apr 2003 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262726AbTDAS03>; Tue, 1 Apr 2003 13:26:29 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:62625
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S262737AbTDAS0Z>; Tue, 1 Apr 2003 13:26:25 -0500
Message-ID: <3E89DBB2.4010502@rogers.com>
Date: Tue, 01 Apr 2003 13:34:26 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2/3] NE2000 driver updates
References: <3E89DB3C.7020909@rogers.com>
In-Reply-To: <3E89DB3C.7020909@rogers.com>
Content-Type: multipart/mixed;
 boundary="------------000408030608080700000401"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Tue, 1 Apr 2003 13:36:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000408030608080700000401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000408030608080700000401
Content-Type: text/plain;
 name="ne-pnp-id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-pnp-id.patch"

--- linux-2.5.66-nepnp/drivers/net/ne.c	2003-03-29 21:39:17.000000000 -0500
+++ linux-2.5.66-nepnpid/drivers/net/ne.c	2003-03-29 21:39:29.000000000 -0500
@@ -81,8 +81,16 @@
 	{.id = "AXE2011", .driver_data = 0},
 	/* NN NE2000 */
 	{.id = "EDI0216", .driver_data = 0},
+	/* Novell/Anthem NE1000 */
+	{.id = "PNP80d3", .driver_data = 0},
+	/* Novell/Anthem NE2000 */
+	{.id = "PNP80d4", .driver_data = 0},
+	/* NE1000 Compatible */
+	{.id = "PNP80d5", .driver_data = 0},
 	/* NE2000 Compatible */
 	{.id = "PNP80d6", .driver_data = 0},
+	/* National Semiconductor AT/LANTIC EtherNODE 16-AT3 */
+	{.id = "PNP8160", .driver_data = 0},
 };
 
 MODULE_DEVICE_TABLE(pnp, ne_pnp_table);

--------------000408030608080700000401--

