Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWI0Q7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWI0Q7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWI0Q7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:59:49 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:14029 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030243AbWI0Q7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:59:47 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 2/8] at91_serial -> atmel_serial: at91_serial.c
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:57:59 +0200
Message-Id: <11593762852168-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <115937628584-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename at91_serial.c atmel_serial.c

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/Makefile                          |    2 +-
 drivers/serial/{at91_serial.c => atmel_serial.c} |    0 
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 927faee..e49808a 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -54,5 +54,5 @@ obj-$(CONFIG_SERIAL_TXX9) += serial_txx9
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
-obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
+obj-$(CONFIG_SERIAL_AT91) += atmel_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
diff --git a/drivers/serial/at91_serial.c b/drivers/serial/atmel_serial.c
similarity index 100%
rename from drivers/serial/at91_serial.c
rename to drivers/serial/atmel_serial.c
-- 
1.4.1.1

