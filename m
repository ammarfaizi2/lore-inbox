Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319302AbSIKTrZ>; Wed, 11 Sep 2002 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319303AbSIKTrY>; Wed, 11 Sep 2002 15:47:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48514 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S319302AbSIKTrX>; Wed, 11 Sep 2002 15:47:23 -0400
Date: Wed, 11 Sep 2002 15:52:09 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH]: 2.4.20-pre6: befs still not in fs/Makefile
Message-ID: <Pine.LNX.4.44.0209111546460.5941-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marcelo!

befs (BeOS filesystem) still doesn't work in your series because it's
missing in fs/Makefile.  Patch:

===================================
--- linux.orig/fs/Makefile
+++ linux/fs/Makefile
@@ -66,6 +66,7 @@
 subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_DEVPTS_FS)	+= devpts
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
+subdir-$(CONFIG_BEFS_FS)	+= befs
 subdir-$(CONFIG_JFS_FS)		+= jfs
 
 
===================================

-- 
Regards,
Pavel Roskin

