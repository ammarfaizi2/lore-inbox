Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTAZTgl>; Sun, 26 Jan 2003 14:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTAZTgl>; Sun, 26 Jan 2003 14:36:41 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:1707
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S266978AbTAZTgk>; Sun, 26 Jan 2003 14:36:40 -0500
Message-ID: <3E343B03.3040800@rogers.com>
Date: Sun, 26 Jan 2003 14:46:11 -0500
From: Jeff Muizelaar <muizelaar@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] NE PnP Update from Jeff Muizelaar (5/6)
References: <20030125201528.GA12845@neo.rr.com> <3E33AE37.463C9CCF@yahoo.com>
In-Reply-To: <3E33AE37.463C9CCF@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------000708010202060900080405"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.43.126.4] using ID <muizelaar@rogers.com> at Sun, 26 Jan 2003 14:45:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000708010202060900080405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On top of the last patch. Here is a patch that adds some more pnp ids.
I have the national semi card so I know it works, but I am not sure 
about the other ones. They sound good though.

-Jeff

--------------000708010202060900080405
Content-Type: text/plain;
 name="ne-patch.3b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne-patch.3b"

--- linux-2.5.59/drivers/net/ne.c	2003-01-26 14:25:28.000000000 -0500
+++ linux-2.5.59-patched/drivers/net/ne.c	2003-01-26 14:25:02.000000000 -0500
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

--------------000708010202060900080405--

