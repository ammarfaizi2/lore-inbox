Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVKGDRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVKGDRS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKGDRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:17:17 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:31677 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932430AbVKGDRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:06 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Michael Krufky <mkrufky@m1k.net>
Subject: [Patch 04/20] V4L(902) Saa6588 c should build saa6588 ko rather
	than rds ko
Date: Mon, 07 Nov 2005 00:58:06 -0200
Message-Id: <1131333341.25215.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Krufky <mkrufky@m1k.net>

- Saa6588.c should build saa6588.ko, rather than rds.ko

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

 drivers/media/video/Makefile |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- hg.orig/drivers/media/video/Makefile
+++ hg/drivers/media/video/Makefile
@@ -5,7 +5,6 @@
 bttv-objs	:=	bttv-driver.o bttv-cards.o bttv-if.o \
 			bttv-risc.o bttv-vbi.o bttv-i2c.o bttv-gpio.o
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
-rds-objs        :=	saa6588.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
 tuner-objs	:=	tuner-core.o tuner-simple.o mt20xx.o tda8290.o tea5767.o
@@ -16,7 +15,7 @@ obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
-obj-$(CONFIG_VIDEO_SAA6588) += rds.o
+obj-$(CONFIG_VIDEO_SAA6588) += saa6588.o
 obj-$(CONFIG_VIDEO_SAA5246A) += saa5246a.o
 obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

