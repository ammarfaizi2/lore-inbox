Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759127AbWK3IcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759127AbWK3IcS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759146AbWK3IcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:32:18 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:32268 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1759127AbWK3IcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:32:17 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] char: ip2 remove broken macro
Date: Thu, 30 Nov 2006 09:31:46 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300931.47007.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This macro is broken and unused so why not remove it.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/char/ip2/i2cmd.h |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.19-rc6-mm2-a/drivers/char/ip2/i2cmd.h	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/drivers/char/ip2/i2cmd.h	2006-11-30 00:53:38.000000000 +0100
@@ -367,11 +367,6 @@ static UCHAR cc02[];
 #define CSE_NULL  3  // Replace with a null
 #define CSE_MARK  4  // Replace with a 3-character sequence (as Unix)
 
-#define  CMD_SET_REPLACEMENT(arg,ch)   \
-			(((cmdSyntaxPtr)(ct36a))->cmd[1] = (arg), \
-			(((cmdSyntaxPtr)(ct36a))->cmd[2] = (ch),  \
-			(cmdSyntaxPtr)(ct36a))
-
 #define CSE_REPLACE  0x8	// Replace the errored character with the
 							// replacement character defined here
 


-- 
Regards,

	Mariusz Kozlowski
