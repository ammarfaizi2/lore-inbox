Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTEAQqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEAQqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 12:46:55 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:12795
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261162AbTEAQqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 12:46:53 -0400
Message-ID: <3EB15263.8010000@rogers.com>
Date: Thu, 01 May 2003 12:59:15 -0400
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] NE2000 driver updates
References: <3EB15127.2060409@rogers.com>
In-Reply-To: <3EB15127.2060409@rogers.com>
Content-Type: multipart/mixed;
 boundary="------------040308070903050807010804"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Thu, 1 May 2003 12:59:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308070903050807010804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040308070903050807010804
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

--------------040308070903050807010804--

