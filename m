Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLCNIF>; Tue, 3 Dec 2002 08:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSLCNIE>; Tue, 3 Dec 2002 08:08:04 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:18348 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261295AbSLCNID>; Tue, 3 Dec 2002 08:08:03 -0500
Date: Tue, 3 Dec 2002 14:15:28 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
       sparclinux@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (sparc)
Message-ID: <20021203131528.GI2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused CONFIG_UDF_RW from sparc{,64} defconfigs

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/sparc/defconfig linux-2.5.50-eaa/arch/sparc/defconfig
--- linux-2.5.50/arch/sparc/defconfig	Tue Oct 22 00:13:59 2002
+++ linux-2.5.50-eaa/arch/sparc/defconfig	Tue Dec  3 00:48:05 2002
@@ -374,7 +374,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/sparc64/defconfig linux-2.5.50-eaa/arch/sparc64/defconfig
--- linux-2.5.50/arch/sparc64/defconfig	Fri Nov  1 00:07:20 2002
+++ linux-2.5.50-eaa/arch/sparc64/defconfig	Tue Dec  3 00:48:05 2002
@@ -724,7 +724,6 @@
 CONFIG_EXT2_FS=y
 CONFIG_SYSV_FS=m
 CONFIG_UDF_FS=m
-CONFIG_UDF_RW=y
 CONFIG_UFS_FS=m
 CONFIG_UFS_FS_WRITE=y
 CONFIG_XFS_FS=m
