Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132071AbQLaFHF>; Sun, 31 Dec 2000 00:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135698AbQLaFGz>; Sun, 31 Dec 2000 00:06:55 -0500
Received: from [200.230.208.16] ([200.230.208.16]:10513 "EHLO plutao.vb.com.br")
	by vger.kernel.org with ESMTP id <S132071AbQLaFGp>;
	Sun, 31 Dec 2000 00:06:45 -0500
From: "Carlos E. Gorges" <carlos@techlinux.com.br>
Organization: Tech Informatica
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test12 drivers/Makefile
Date: Sun, 31 Dec 2000 00:40:05 -0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00123100423002.03973@shark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




--- linux-2.4.0-t12.vanilla+reiser/drivers/Makefile	Thu Dec 21 12:52:17 2000
+++ linux-2.4.0-t12/drivers/Makefile	Sun Dec 31 00:38:09 2000
@@ -42,6 +42,7 @@
 subdir-$(CONFIG_HAMRADIO)	+= net/hamradio
 subdir-$(CONFIG_ACPI)		+= acpi
 
+subdir-$(CONFIG_I2C)		+= i2c
 
 # Subdirectories that should be entered when MAKING_MODULES=1, even if set to 'y'.
 both-m		:= $(filter $(mod-subdirs), $(subdir-y))
--EOF--

no coments :-).

cya;
-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
