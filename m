Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRAUD4F>; Sat, 20 Jan 2001 22:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131059AbRAUDzz>; Sat, 20 Jan 2001 22:55:55 -0500
Received: from knatte.tninet.se ([195.100.94.10]:12220 "HELO knatte.tninet.se")
	by vger.kernel.org with SMTP id <S130105AbRAUDzn>;
	Sat, 20 Jan 2001 22:55:43 -0500
Date: Sun, 21 Jan 2001 04:54:35 +0100
From: André Dahlqvist <anedah-9@sm.luth.se>
To: axel@uni-paderborn.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add help text for ATI Radeon
Message-ID: <20010121045435.A2443@sm.luth.se>
Mail-Followup-To: axel@uni-paderborn.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch adds a help text for the ATI Radeon graphics
card. The patch is against 2.4.1-pre9.

--- linux/Documentation/Configure.help~	Sun Jan 21 04:08:54 2001
+++ linux/Documentation/Configure.help	Sun Jan 21 04:49:29 2001
@@ -13132,6 +13132,11 @@
   is selected, the module will be called r128.o.  AGP support for
   this card is strongly suggested (unless you have a PCI version).
 
+ATI Radeon 
+CONFIG_DRM_RADEON
+  Choose this option if you have a ATI Radeon graphics card.
+  If M is selected, the module will be called radeon.o.
+
 Intel I810
 CONFIG_DRM_I810
   Choose this option if you have an Intel I810 graphics card.  If M is
-- 

André Dahlqvist <anedah-9@sm.luth.se>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
