Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTLXBZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTLXBZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:25:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8644 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263102AbTLXBZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:25:24 -0500
Date: Tue, 23 Dec 2003 20:25:16 -0500
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: PATCH: 2.4 zr36120 missing dependancies
Message-ID: <20031224012516.GA15923@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- drivers/media/video/Makefile~	2003-12-24 01:29:10.000000000 +0000
+++ drivers/media/video/Makefile	2003-12-24 01:29:10.000000000 +0000
@@ -38,7 +38,7 @@
 	tda7432.o tda9875.o tda9887.o tuner.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
-obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
+obj-$(CONFIG_VIDEO_ZR36120) += zoran.o i2c-old.o
 obj-$(CONFIG_I2C_PARPORT) += i2c-parport.o i2c-old.o
 obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o


Alan
--
	"One is tempted to think of the planned RFID tagging of all US DoD
	supplies as a major step forward. This will finally enable the
	design of a new and far safer generation of mines that detonate
	only near people carrying DoD equipment."
		-- Markus Kuhn

