Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSLCMtr>; Tue, 3 Dec 2002 07:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSLCMtr>; Tue, 3 Dec 2002 07:49:47 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:60843 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261290AbSLCMtg>; Tue, 3 Dec 2002 07:49:36 -0500
Date: Tue, 3 Dec 2002 13:56:24 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: Russell King <rmk@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (arm)
Message-ID: <20021203125624.GB2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_UDF_RW for ARM defconfigs...

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/arm/def-configs/a5k linux-2.5.50-eaa/arch/arm/def-configs/a5k
--- linux-2.5.50/arch/arm/def-configs/a5k	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/a5k	Tue Dec  3 00:48:04 2002
@@ -399,7 +399,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/adi_evb linux-2.5.50-eaa/arch/arm/def-configs/adi_evb
--- linux-2.5.50/arch/arm/def-configs/adi_evb	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/adi_evb	Tue Dec  3 00:48:04 2002
@@ -542,7 +542,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/adsbitsy linux-2.5.50-eaa/arch/arm/def-configs/adsbitsy
--- linux-2.5.50/arch/arm/def-configs/adsbitsy	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/adsbitsy	Tue Dec  3 00:48:04 2002
@@ -492,7 +492,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/anakin linux-2.5.50-eaa/arch/arm/def-configs/anakin
--- linux-2.5.50/arch/arm/def-configs/anakin	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/anakin	Tue Dec  3 00:48:04 2002
@@ -522,7 +522,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/assabet linux-2.5.50-eaa/arch/arm/def-configs/assabet
--- linux-2.5.50/arch/arm/def-configs/assabet	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/assabet	Tue Dec  3 00:48:04 2002
@@ -671,7 +671,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/badge4 linux-2.5.50-eaa/arch/arm/def-configs/badge4
--- linux-2.5.50/arch/arm/def-configs/badge4	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/badge4	Tue Dec  3 00:48:04 2002
@@ -857,7 +857,6 @@
 CONFIG_EXT2_FS=m
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/brutus linux-2.5.50-eaa/arch/arm/def-configs/brutus
--- linux-2.5.50/arch/arm/def-configs/brutus	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/brutus	Tue Dec  3 00:48:04 2002
@@ -237,7 +237,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_NCPFS_NLS is not set
diff -urN linux-2.5.50/arch/arm/def-configs/cerfcube linux-2.5.50-eaa/arch/arm/def-configs/cerfcube
--- linux-2.5.50/arch/arm/def-configs/cerfcube	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/cerfcube	Tue Dec  3 00:48:04 2002
@@ -660,7 +660,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/cerfpda linux-2.5.50-eaa/arch/arm/def-configs/cerfpda
--- linux-2.5.50/arch/arm/def-configs/cerfpda	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/cerfpda	Tue Dec  3 00:48:04 2002
@@ -698,7 +698,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/cerfpod linux-2.5.50-eaa/arch/arm/def-configs/cerfpod
--- linux-2.5.50/arch/arm/def-configs/cerfpod	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/cerfpod	Tue Dec  3 00:48:04 2002
@@ -662,7 +662,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/ebsa110 linux-2.5.50-eaa/arch/arm/def-configs/ebsa110
--- linux-2.5.50/arch/arm/def-configs/ebsa110	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/ebsa110	Tue Dec  3 00:48:04 2002
@@ -545,7 +545,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/edb7211 linux-2.5.50-eaa/arch/arm/def-configs/edb7211
--- linux-2.5.50/arch/arm/def-configs/edb7211	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/edb7211	Tue Dec  3 00:48:04 2002
@@ -344,7 +344,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/epxa10db linux-2.5.50-eaa/arch/arm/def-configs/epxa10db
--- linux-2.5.50/arch/arm/def-configs/epxa10db	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/epxa10db	Tue Dec  3 00:48:04 2002
@@ -557,7 +557,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/flexanet linux-2.5.50-eaa/arch/arm/def-configs/flexanet
--- linux-2.5.50/arch/arm/def-configs/flexanet	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/flexanet	Tue Dec  3 00:48:04 2002
@@ -655,7 +655,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/footbridge linux-2.5.50-eaa/arch/arm/def-configs/footbridge
--- linux-2.5.50/arch/arm/def-configs/footbridge	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/footbridge	Tue Dec  3 00:48:04 2002
@@ -629,7 +629,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/fortunet linux-2.5.50-eaa/arch/arm/def-configs/fortunet
--- linux-2.5.50/arch/arm/def-configs/fortunet	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/fortunet	Tue Dec  3 00:48:04 2002
@@ -468,7 +468,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/freebird linux-2.5.50-eaa/arch/arm/def-configs/freebird
--- linux-2.5.50/arch/arm/def-configs/freebird	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/freebird	Tue Dec  3 00:48:04 2002
@@ -506,7 +506,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/freebird_new linux-2.5.50-eaa/arch/arm/def-configs/freebird_new
--- linux-2.5.50/arch/arm/def-configs/freebird_new	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/freebird_new	Tue Dec  3 00:48:04 2002
@@ -526,7 +526,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/graphicsclient linux-2.5.50-eaa/arch/arm/def-configs/graphicsclient
--- linux-2.5.50/arch/arm/def-configs/graphicsclient	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/graphicsclient	Tue Dec  3 00:48:04 2002
@@ -598,7 +598,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/graphicsmaster linux-2.5.50-eaa/arch/arm/def-configs/graphicsmaster
--- linux-2.5.50/arch/arm/def-configs/graphicsmaster	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/graphicsmaster	Tue Dec  3 00:48:04 2002
@@ -573,7 +573,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/h3600 linux-2.5.50-eaa/arch/arm/def-configs/h3600
--- linux-2.5.50/arch/arm/def-configs/h3600	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/h3600	Tue Dec  3 00:48:04 2002
@@ -663,7 +663,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/huw_webpanel linux-2.5.50-eaa/arch/arm/def-configs/huw_webpanel
--- linux-2.5.50/arch/arm/def-configs/huw_webpanel	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/huw_webpanel	Tue Dec  3 00:48:04 2002
@@ -350,7 +350,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/integrator linux-2.5.50-eaa/arch/arm/def-configs/integrator
--- linux-2.5.50/arch/arm/def-configs/integrator	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/integrator	Tue Dec  3 00:48:04 2002
@@ -557,7 +557,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/iq80310 linux-2.5.50-eaa/arch/arm/def-configs/iq80310
--- linux-2.5.50/arch/arm/def-configs/iq80310	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/iq80310	Tue Dec  3 00:48:04 2002
@@ -651,7 +651,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/jornada720 linux-2.5.50-eaa/arch/arm/def-configs/jornada720
--- linux-2.5.50/arch/arm/def-configs/jornada720	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/jornada720	Tue Dec  3 00:48:04 2002
@@ -681,7 +681,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/lart linux-2.5.50-eaa/arch/arm/def-configs/lart
--- linux-2.5.50/arch/arm/def-configs/lart	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/lart	Tue Dec  3 00:48:04 2002
@@ -668,7 +668,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 CONFIG_UDF_FS=m
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/lubbock linux-2.5.50-eaa/arch/arm/def-configs/lubbock
--- linux-2.5.50/arch/arm/def-configs/lubbock	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/lubbock	Tue Dec  3 00:48:04 2002
@@ -715,7 +715,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/lusl7200 linux-2.5.50-eaa/arch/arm/def-configs/lusl7200
--- linux-2.5.50/arch/arm/def-configs/lusl7200	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/lusl7200	Tue Dec  3 00:48:04 2002
@@ -430,7 +430,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_NCPFS_NLS is not set
diff -urN linux-2.5.50/arch/arm/def-configs/omnimeter linux-2.5.50-eaa/arch/arm/def-configs/omnimeter
--- linux-2.5.50/arch/arm/def-configs/omnimeter	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/omnimeter	Tue Dec  3 00:48:04 2002
@@ -436,7 +436,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pangolin linux-2.5.50-eaa/arch/arm/def-configs/pangolin
--- linux-2.5.50/arch/arm/def-configs/pangolin	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pangolin	Tue Dec  3 00:48:04 2002
@@ -572,7 +572,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pfs168_mqtft linux-2.5.50-eaa/arch/arm/def-configs/pfs168_mqtft
--- linux-2.5.50/arch/arm/def-configs/pfs168_mqtft	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pfs168_mqtft	Tue Dec  3 00:48:04 2002
@@ -612,7 +612,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pfs168_mqvga linux-2.5.50-eaa/arch/arm/def-configs/pfs168_mqvga
--- linux-2.5.50/arch/arm/def-configs/pfs168_mqvga	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pfs168_mqvga	Tue Dec  3 00:48:04 2002
@@ -612,7 +612,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pfs168_sastn linux-2.5.50-eaa/arch/arm/def-configs/pfs168_sastn
--- linux-2.5.50/arch/arm/def-configs/pfs168_sastn	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pfs168_sastn	Tue Dec  3 00:48:04 2002
@@ -605,7 +605,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pfs168_satft linux-2.5.50-eaa/arch/arm/def-configs/pfs168_satft
--- linux-2.5.50/arch/arm/def-configs/pfs168_satft	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pfs168_satft	Tue Dec  3 00:48:04 2002
@@ -612,7 +612,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/pleb linux-2.5.50-eaa/arch/arm/def-configs/pleb
--- linux-2.5.50/arch/arm/def-configs/pleb	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/pleb	Tue Dec  3 00:48:04 2002
@@ -473,7 +473,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/shark linux-2.5.50-eaa/arch/arm/def-configs/shark
--- linux-2.5.50/arch/arm/def-configs/shark	Tue Dec  3 00:31:32 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/shark	Tue Dec  3 00:48:04 2002
@@ -772,7 +772,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/stork linux-2.5.50-eaa/arch/arm/def-configs/stork
--- linux-2.5.50/arch/arm/def-configs/stork	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/stork	Tue Dec  3 00:48:04 2002
@@ -662,7 +662,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/def-configs/system3 linux-2.5.50-eaa/arch/arm/def-configs/system3
--- linux-2.5.50/arch/arm/def-configs/system3	Fri Nov 15 12:41:44 2002
+++ linux-2.5.50-eaa/arch/arm/def-configs/system3	Tue Dec  3 00:48:04 2002
@@ -697,7 +697,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/arm/defconfig linux-2.5.50-eaa/arch/arm/defconfig
--- linux-2.5.50/arch/arm/defconfig	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/arm/defconfig	Tue Dec  3 00:48:04 2002
@@ -435,7 +435,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
