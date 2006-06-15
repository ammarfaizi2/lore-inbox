Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031133AbWFOTAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031133AbWFOTAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031136AbWFOTAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:00:51 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:56189 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1031133AbWFOTAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:00:49 -0400
Message-ID: <4491BC77.4040804@oracle.com>
Date: Thu, 15 Jun 2006 13:00:55 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm <akpm@osdl.org>, rmk+serial@arm.linux.org.uk
Subject: [Ubuntu PATCH] 8250_pnp:  Add support for other Wacom tablets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Collins <bcollins@ubuntu.com>

[UBUNTU:8250_pnp] Add support for other Wacom tablets that are around

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=6a242b6c279af7805a6cca8f39dbc5bfe1f78cd1

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- a/drivers/serial/8250_pnp.c
+++ b/drivers/serial/8250_pnp.c
@@ -323,8 +323,10 @@ static const struct pnp_device_id pnp_de
 	{	"USR9180",		0	},
 	/* U.S. Robotics 56K Voice INT PnP*/
 	{	"USR9190",		0	},
-	/* HP Compaq Tablet PC tc1100 Wacom tablet */
+	/* Wacom tablets */
+	{	"WACF004",		0	},
 	{	"WACF005",		0	},
+	{       "WACF006",              0       },
 	/* Rockwell's (PORALiNK) 33600 INT PNP */
 	{	"WCI0003",		0	},
 	/* Unkown PnP modems */



