Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVH1Cok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVH1Cok (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 22:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVH1Cok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 22:44:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54465 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750874AbVH1Cok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 22:44:40 -0400
Date: Sun, 28 Aug 2005 03:47:50 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in tda80xx
Message-ID: <20050828024750.GF9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c current/drivers/media/dvb/frontends/tda80xx.c
--- RC13-rc7-base/drivers/media/dvb/frontends/tda80xx.c	2005-08-24 01:56:38.000000000 -0400
+++ current/drivers/media/dvb/frontends/tda80xx.c	2005-08-27 22:36:10.000000000 -0400
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <asm/irq.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"
