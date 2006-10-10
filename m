Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbWJJG3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWJJG3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWJJG3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:29:07 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:62666 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S965016AbWJJG3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:29:05 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 02:27:34 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] apparent typo in ixgb.h, "_DEBUG_DRIVER_" looks wrong
Message-ID: <Pine.LNX.4.64.0610100219590.3442@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm *guessing* that "_DEBUG_DRIVER_" should really be "DEBUG_DRIVER"
here, since there is no other occurrence of the former anywhere in the
source tree.

Signed-off-by: Robert P. J. Day <rpjday@mindspting.com>
---

 drivers/net/ixgb/ixgb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
index 50ffe90..b2dd9b0 100644
--- a/drivers/net/ixgb/ixgb.h
+++ b/drivers/net/ixgb/ixgb.h
@@ -77,7 +77,7 @@ #include "ixgb_hw.h"
 #include "ixgb_ee.h"
 #include "ixgb_ids.h"

-#ifdef _DEBUG_DRIVER_
+#ifdef DEBUG_DRIVER
 #define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
 #else
 #define IXGB_DBG(args...)
