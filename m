Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbSJ2KYe>; Tue, 29 Oct 2002 05:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261755AbSJ2KYe>; Tue, 29 Oct 2002 05:24:34 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:24596 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261750AbSJ2KYe>; Tue, 29 Oct 2002 05:24:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44: include/linux/pnp.h typo
Date: Tue, 29 Oct 2002 11:30:49 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210291130.49755.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find below a very trivial patch. C compilers prefer { } above { ).

Jos 

--- include/linux/pnp-old.h	2002-10-29 11:18:10.000000000 +0100
+++ include/linux/pnp.h	2002-10-29 11:18:29.000000000 +0100
@@ -245,7 +245,7 @@
 
 /* just in case anyone decides to call these without PnP Support Enabled */
 static inline int pnp_protocol_register(struct pnp_protocol *protocol) { 
return -ENODEV; }
-static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; 
)
+static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; 
}
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_device(struct pnp_dev *dev) { ; }


