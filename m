Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWAaCps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWAaCps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWAaCps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:45:48 -0500
Received: from qbiz-online.de ([212.227.64.43]:22441 "EHLO qbiz.de")
	by vger.kernel.org with ESMTP id S1030277AbWAaCpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:45:47 -0500
Message-ID: <43DEDE58.9060903@luemmel.org>
Date: Tue, 31 Jan 2006 03:49:44 +0000
From: Christian Merkle <chris@luemmel.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051106)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] radeonfb: fix typo
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a cosmetical fixup.


Signed-off-by: Christian Merkle <chris@luemmel.org>


--- a/drivers/video/aty/radeonfb.h        2006-01-31 02:34:05.000000000 
+0000
+++ b/drivers/video/aty/radeonfb.h        2006-01-31 02:34:28.000000000 
+0000
@@ -139,7 +139,7 @@
   * This structure contains the various registers manipulated by this
   * driver for setting or restoring a mode. It's mostly copied from
   * XFree's RADEONSaveRec structure. A few chip settings might still be
- * tweaked without beeing reflected or saved in these registers though
+ * tweaked without being reflected or saved in these registers though
   */
  struct radeon_regs {
         /* Common registers */
@@ -382,7 +382,7 @@
  /* Note about this function: we have some rare cases where we must not 
hedule,
   * this typically happen with our special "wake up early" hook which 
allows us to
   * wake up the graphic chip (and thus get the console back) before 
everything else
- * on some machines that support that mecanism. At this point, 
interrupts are off
+ * on some machines that support that mechanism. At this point, 
interrupts are off
   * and scheduling is not permitted
   */
  static inline void _radeon_msleep(struct radeonfb_info *rinfo, 
unsigned long ms)
