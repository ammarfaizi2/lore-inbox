Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSLCMnz>; Tue, 3 Dec 2002 07:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSLCMnz>; Tue, 3 Dec 2002 07:43:55 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:50603 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261206AbSLCMnz>; Tue, 3 Dec 2002 07:43:55 -0500
Date: Tue, 3 Dec 2002 13:51:20 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (i386)
Message-ID: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that CONFIG_UDF_RW is not used anywhere, so I removed it from all
the defconfigs.

Regards
	Erlend Aasland

diff -urN linux-2.5.50/arch/i386/defconfig linux-2.5.50-eaa/arch/i386/defconfig
--- linux-2.5.50/arch/i386/defconfig	Tue Oct 22 00:13:57 2002
+++ linux-2.5.50-eaa/arch/i386/defconfig	Tue Dec  3 00:48:05 2002
@@ -804,7 +804,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 CONFIG_UDF_FS=y
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_FS is not set
