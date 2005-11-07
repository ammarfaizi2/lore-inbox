Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVKGDTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVKGDTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVKGDSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:18:01 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:7042 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932431AbVKGDRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:17:38 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [Patch 13/20] V4L SAA7134 alsa build fix
Date: Mon, 07 Nov 2005 00:58:10 -0200
Message-Id: <1131333341.25215.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- Fixes saa7134-alsa build inside saa7134 driver.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/saa7134/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- hg.orig/drivers/media/video/saa7134/Makefile
+++ hg/drivers/media/video/saa7134/Makefile
@@ -3,7 +3,8 @@ saa7134-objs :=	saa7134-cards.o saa7134-
 		saa7134-oss.o saa7134-ts.o saa7134-tvaudio.o	\
 		saa7134-vbi.o saa7134-video.o saa7134-input.o
 
-obj-$(CONFIG_VIDEO_SAA7134) += saa7134.o saa7134-empress.o saa6752hs.o
+obj-$(CONFIG_VIDEO_SAA7134) +=  saa7134.o saa7134-empress.o \
+				saa6752hs.o saa7134-alsa.o
 obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
 EXTRA_CFLAGS += -I$(src)/..


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

