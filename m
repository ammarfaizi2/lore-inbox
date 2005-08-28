Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVH1CtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVH1CtM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 22:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVH1CtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 22:49:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:450 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751061AbVH1CtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 22:49:12 -0400
Date: Sun, 28 Aug 2005 03:52:22 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in smc-ultra
Message-ID: <20050828025222.GG9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-base/drivers/net/smc-ultra.c current/drivers/net/smc-ultra.c
--- RC13-rc7-base/drivers/net/smc-ultra.c	2005-08-24 01:56:39.000000000 -0400
+++ current/drivers/net/smc-ultra.c	2005-08-27 22:47:43.000000000 -0400
@@ -68,6 +68,7 @@
 #include <linux/etherdevice.h>
 
 #include <asm/io.h>
+#include <asm/irq.h>
 #include <asm/system.h>
 
 #include "8390.h"
