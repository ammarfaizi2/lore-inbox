Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265512AbSJSEzu>; Sat, 19 Oct 2002 00:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSJSEzu>; Sat, 19 Oct 2002 00:55:50 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:16893 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP
	id <S265512AbSJSEzu>; Sat, 19 Oct 2002 00:55:50 -0400
Message-Id: <200210190458.g9J4wKvk008917@pool-141-150-241-241.delv.east.verizon.net>
Date: Sat, 19 Oct 2002 00:58:19 -0400
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 Fix pnp.h typo
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop016.verizon.net from [141.150.241.241] at Sat, 19 Oct 2002 00:01:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in pnp.h
(The ')' at the end s/b '}')

--- linux/include/linux/pnp.h~	Sat Oct 19 00:51:35 2002
+++ linux/include/linux/pnp.h	Sat Oct 19 00:51:39 2002
@@ -245,7 +245,7 @@
 
 /* just in case anyone decides to call these without PnP Support Enabled */
 static inline int pnp_protocol_register(struct pnp_protocol *protocol) { return -ENODEV; }
-static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; )
+static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_device(struct pnp_dev *dev) { ; }

-- 
Skip
