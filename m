Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVA0Xec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVA0Xec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVA0Xeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:34:31 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:42492 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261305AbVA0XbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:31:15 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cristoph@lameter.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050127233114.23569.96450.95057@localhost.localdomain>
In-Reply-To: <20050127233053.23569.16444.60993@localhost.localdomain>
References: <20050127233053.23569.16444.60993@localhost.localdomain>
Subject: [PATCH 3/8] pcxx: Remove reference in drivers/char/Makefile
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 17:31:14 -0600
Date: Thu, 27 Jan 2005 17:31:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes references to the pcxx driver drivers/char/Makefile

It depends on the previous patches.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc2-mm1-original/drivers/char/Makefile linux-2.6.11-rc2-mm1/drivers/char/Makefile
--- linux-2.6.11-rc2-mm1-original/drivers/char/Makefile	2005-01-24 17:15:56.000000000 -0500
+++ linux-2.6.11-rc2-mm1/drivers/char/Makefile	2005-01-27 16:27:03.000000000 -0500
@@ -28,7 +28,6 @@
 obj-$(CONFIG_CYCLADES)		+= cyclades.o
 obj-$(CONFIG_STALLION)		+= stallion.o
 obj-$(CONFIG_ISTALLION)		+= istallion.o
-obj-$(CONFIG_DIGI)		+= pcxx.o
 obj-$(CONFIG_DIGIEPCA)		+= epca.o
 obj-$(CONFIG_SPECIALIX)		+= specialix.o
 obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
