Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318326AbSHSLxn>; Mon, 19 Aug 2002 07:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSHSLxM>; Mon, 19 Aug 2002 07:53:12 -0400
Received: from dp.samba.org ([66.70.73.150]:35202 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S318344AbSHSLxK>;
	Mon, 19 Aug 2002 07:53:10 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15712.55945.77278.420121@argo.ozlabs.ibm.com>
Date: Mon, 19 Aug 2002 21:46:17 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix typos in drivers/video/Makefile
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects a couple of silly typos in drivers/video/Config.in
in current 2.5.

Paul.

diff -urN linux-2.5/drivers/video/Config.in pmac-2.5/drivers/video/Config.in
--- linux-2.5/drivers/video/Config.in	Wed Aug 14 09:15:02 2002
+++ pmac-2.5/drivers/video/Config.in	Wed Aug 14 18:28:28 2002
@@ -249,7 +249,7 @@
 	 define_tristate CONFIG_FBCON_CFB2 y
 	 define_tristate CONFIG_FBCON_CFB4 y
       else
-	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_SA1100" = "m"]; then 
+	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_SA1100" = "m" ]; then 
 	    define_tristate CONFIG_FBCON_CFB2 m
 	    define_tristate CONFIG_FBCON_CFB4 m
 	 fi
@@ -278,7 +278,7 @@
 	      "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
 	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
               "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
-	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m"-o \
+	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
 	      "$CONFIG_FB_SA1100" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB8 m
 	 fi
