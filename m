Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbTBQXbr>; Mon, 17 Feb 2003 18:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBQXbr>; Mon, 17 Feb 2003 18:31:47 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:21921 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267658AbTBQXPj>;
	Mon, 17 Feb 2003 18:15:39 -0500
Date: Mon, 17 Feb 2003 18:25:10 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Art Haas <ahaas@airmail.net>
Subject: [PATCH] pnp - C99 patch for drivers/pnp/card.c from Art Haas (11/13)
Message-ID: <20030217182510.GA31477@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Art Haas <ahaas@airmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial contains C99 updates for card.c.  Credit for this patch should go
to Art Haas.

Please apply,
Adam


--- 1.5/drivers/pnp/card.c	Mon Jan 13 12:25:14 2003
+++ edited/drivers/pnp/card.c	Tue Jan 14 10:34:42 2003
@@ -43,8 +43,8 @@
 }

 struct bus_type pnpc_bus_type = {
-	name:	"pnp_card",
-	match:	card_bus_match,
+	.name	= "pnp_card",
+	.match	= card_bus_match,
 };
 
