Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLCNCs>; Tue, 3 Dec 2002 08:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLCNCr>; Tue, 3 Dec 2002 08:02:47 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:12460 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261349AbSLCNCr>; Tue, 3 Dec 2002 08:02:47 -0500
Date: Tue, 3 Dec 2002 14:10:00 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
       parisc-linux@parisc-linux.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (parisc)
Message-ID: <20021203131000.GG2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_UDF_RW from parisc defconfig (it's not used anymore)

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/parisc/defconfig linux-2.5.50-eaa/arch/parisc/defconfig
--- linux-2.5.50/arch/parisc/defconfig	Fri Nov  1 00:07:19 2002
+++ linux-2.5.50-eaa/arch/parisc/defconfig	Tue Dec  3 00:48:05 2002
@@ -576,7 +576,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
