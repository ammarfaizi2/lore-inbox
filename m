Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTARXKO>; Sat, 18 Jan 2003 18:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTARXKN>; Sat, 18 Jan 2003 18:10:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57828 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265168AbTARXKN>; Sat, 18 Jan 2003 18:10:13 -0500
Date: Sun, 19 Jan 2003 00:19:07 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove unused variable from drivers/net/irda/ali-ircc.c
Message-ID: <20030118231906.GT10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

the patch below removes an unused variable that generated a compile time 
warning. I've tested the compilation with 2.5.59.

cu
Adrian

--- linux-2.5.59-full/drivers/net/irda/ali-ircc.c.old	2003-01-19 00:09:16.000000000 +0100
+++ linux-2.5.59-full/drivers/net/irda/ali-ircc.c	2003-01-19 00:12:37.000000000 +0100
@@ -248,7 +248,6 @@
 	struct ali_ircc_cb *self;
 	struct pm_dev *pmdev;
 	int dongle_id;
-	int ret;
 	int err;
 			
 	IRDA_DEBUG(2, "%s(), ---------------- Start ----------------\n", __FUNCTION__);	
