Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTLURXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTLURXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:23:24 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:33806 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263645AbTLURXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:23:19 -0500
Date: Sun, 21 Dec 2003 18:24:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] fix file reference in sym53c8xx_2 help
Message-Id: <20031221182406.20965c70.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, hi all,

A very simple patch against 2.6.0 follows, which fixes an improper file
reference in the scsi sym53c8xx_2 driver help text. The referenced
documentation file was moved in 2.5.48 but the help text was not updated
accordingly.

Please apply.
And thanks a lot for the excellent work :)

--- linux-2.6.0/drivers/scsi/Kconfig.orig	Sun Dec 21 17:35:00 2003
+++ linux-2.6.0/drivers/scsi/Kconfig	Sun Dec 21 17:36:34 2003
@@ -903,7 +903,7 @@
 	  language.  It does not support LSI53C10XX Ultra-320 PCI-X SCSI
 	  controllers; you need to use the Fusion MPT driver for that.
 
-	  Please read <file:drivers/scsi/sym53c8xx_2/Documentation.txt> for more
+	  Please read <file:Documentation/scsi/sym53c8xx_2.txt> for more
 	  information.
 
 config SCSI_SYM53C8XX_DMA_ADDRESSING_MODE


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
