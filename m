Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266404AbUBLGdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 01:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUBLGdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 01:33:11 -0500
Received: from ozlabs.org ([203.10.76.45]:38359 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266404AbUBLGdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 01:33:08 -0500
Subject: [PATCH] radeonfb: disable debug output by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076567425.868.181.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 17:30:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Just apply that on top of the new radeonfb patch to make it quiet
by default ;)

Ben.

===== drivers/video/aty/radeonfb.h 1.1 vs edited =====
--- 1.1/drivers/video/aty/radeonfb.h	Thu Feb 12 16:51:20 2004
+++ edited/drivers/video/aty/radeonfb.h	Thu Feb 12 17:25:18 2004
@@ -332,7 +332,7 @@
 /*
  * Debugging stuffs
  */
-#define DEBUG		1
+#define DEBUG		0
 
 #if DEBUG
 #define RTRACE		printk


