Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTBIQ71>; Sun, 9 Feb 2003 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTBIQ7N>; Sun, 9 Feb 2003 11:59:13 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:50828 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267382AbTBIQ4W>;
	Sun, 9 Feb 2003 11:56:22 -0500
Date: Sun, 9 Feb 2003 12:06:52 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>
Cc: Art Haas <ahaas@airmail.net>, "Grover, Andrew" <andrew.grover@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] pnp - C99 patch for drivers/pnp/card.c from Art Haas (12/12) 2.5.59-bk3
Message-ID: <20030209120652.GA20983@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
	Art Haas <ahaas@airmail.net>,
	"Grover, Andrew" <andrew.grover@intel.com>,
	linux-kernel@vger.kernel.org
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

