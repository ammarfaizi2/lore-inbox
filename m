Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967577AbWK2TPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967577AbWK2TPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967579AbWK2TPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:15:07 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:23562 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S967577AbWK2TPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:15:05 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] h8300 stray bracket fix
Date: Wed, 29 Nov 2006 20:14:34 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611292014.34759.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Add the stray bracket.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/h8300/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/h8300/kernel/setup.c	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/h8300/kernel/setup.c	2006-11-29 15:41:07.000000000 +0100
@@ -116,7 +116,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #else
 	if ((memory_end < CONFIG_BLKDEV_RESERVE_ADDRESS) && 
-	    (memory_end > CONFIG_BLKDEV_RESERVE_ADDRESS)
+	    (memory_end > CONFIG_BLKDEV_RESERVE_ADDRESS))
 	    /* overlap userarea */
 	    memory_end = CONFIG_BLKDEV_RESERVE_ADDRESS; 
 #endif

-- 
Regards,

	Mariusz Kozlowski
