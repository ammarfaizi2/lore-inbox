Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFBLkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTFBLkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:40:32 -0400
Received: from hal-5.inet.it ([213.92.5.24]:7084 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S262175AbTFBLka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:40:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: marcelo@conectiva.com.br
Subject: [PATCH] for config
Date: Mon, 2 Jun 2003 13:53:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <S262175AbTFBLka/20030602114030Z+119@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sended this twice... it only changes "AMD Viper support" to show also 
nVidia IDE support SO please apply.

bye,
Paolo

--- a/drivers/ide/Config.in	Thu Apr 24 11:23:57 2003
+++ b/drivers/ide/Config.in	Thu Apr 24 13:52:51 2003
@@ -47,7 +47,7 @@
 	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      ALI M15x3 WDC support (DANGEROUS)' 
CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
-	    dep_tristate '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    AMD and nVidia IDE support' CONFIG_BLK_DEV_AMD74XX 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_mbool    '      AMD Viper ATA-66 Override' CONFIG_AMD74XX_OVERRIDE 
$CONFIG_BLK_DEV_AMD74XX
 	    dep_tristate '    CMD64{3|6|8|9} chipset support' CONFIG_BLK_DEV_CMD64X 
$CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    Compaq Triflex IDE support' CONFIG_BLK_DEV_TRIFLEX 
$CONFIG_BLK_DEV_IDEDMA_PCI
