Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbWJ2SVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWJ2SVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 13:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWJ2SVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 13:21:35 -0500
Received: from master.altlinux.org ([62.118.250.235]:31497 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932354AbWJ2SVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 13:21:34 -0500
From: Sergey Vlasov <vsu@altlinux.ru>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] drivers/ide/pci/generic.c: add missing newline to the all-generic-ide message
Date: Sun, 29 Oct 2006 21:21:32 +0300
Message-Id: <11621460922750-git-send-email-vsu@altlinux.ru>
X-Mailer: git-send-email 1.4.3.3.gd9638
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 drivers/ide/pci/generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index e9a8881..e0d4904 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -49,7 +49,7 @@ static int ide_generic_all;		/* Set to c
 static int __init ide_generic_all_on(char *unused)
 {
 	ide_generic_all = 1;
-	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.");
+	printk(KERN_INFO "IDE generic will claim all unknown PCI IDE storage controllers.\n");
 	return 1;
 }
 __setup("all-generic-ide", ide_generic_all_on);
-- 
1.4.3.3.gd9638

