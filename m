Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFAN2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFAN2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:28:10 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:58632 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id S264608AbTFAN2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:28:09 -0400
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.70.-bk6 make help missing target
Date: Sun, 1 Jun 2003 15:41:38 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306011541.38213.rudmer@legolas.dynup.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that make help was missing the 'gconfig' target. Is this deliberate 
or someone just forgot to add it? What about the following patch?

	Rudmer

--- linux-2.5.70-bk6/Makefile.orig	2003-06-01 14:52:53.000000000 +0200
+++ linux-2.5.70-bk6/Makefile	2003-06-01 14:54:46.000000000 +0200
@@ -789,7 +789,8 @@
 	@echo  'Configuration targets:'
 	@echo  '  oldconfig	- Update current config utilising a line-oriented 
program'
 	@echo  '  menuconfig	- Update current config utilising a menu based program'
-	@echo  '  xconfig	- Update current config utilising a X-based program'
+	@echo  '  xconfig	- Update current config utilising a QT based program'
+	@echo  '  gconfig	- Update current config utilising a GTK based program'
 	@echo  '  defconfig	- New config with default answer to all options'
 	@echo  '  allmodconfig	- New config selecting modules when possible'
 	@echo  '  allyesconfig	- New config where all options are accepted with yes'

