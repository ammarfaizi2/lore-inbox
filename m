Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSLCNLn>; Tue, 3 Dec 2002 08:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSLCNLn>; Tue, 3 Dec 2002 08:11:43 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:22956 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261338AbSLCNLl>; Tue, 3 Dec 2002 08:11:41 -0500
Date: Tue, 3 Dec 2002 14:18:48 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@karaya.com>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (um)
Message-ID: <20021203131848.GJ2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused CONFIG_UDF_RW from UML defconfigs

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/um/config.release linux-2.5.50-eaa/arch/um/config.release
--- linux-2.5.50/arch/um/config.release	Tue Sep 17 10:42:22 2002
+++ linux-2.5.50-eaa/arch/um/config.release	Tue Dec  3 00:48:05 2002
@@ -228,7 +228,6 @@
 CONFIG_EXT2_FS=y
 CONFIG_SYSV_FS=m
 CONFIG_UDF_FS=m
-# CONFIG_UDF_RW is not set
 CONFIG_UFS_FS=m
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/um/defconfig linux-2.5.50-eaa/arch/um/defconfig
--- linux-2.5.50/arch/um/defconfig	Thu Nov 21 00:45:19 2002
+++ linux-2.5.50-eaa/arch/um/defconfig	Tue Dec  3 00:48:05 2002
@@ -205,7 +205,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_FS is not set
