Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSLCMwP>; Tue, 3 Dec 2002 07:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbSLCMwP>; Tue, 3 Dec 2002 07:52:15 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:63659 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261322AbSLCMwO>; Tue, 3 Dec 2002 07:52:14 -0500
Date: Tue, 3 Dec 2002 13:59:35 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Wesen <bjornw@axis.com>,
       dev-etrax@axis.com
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (cris)
Message-ID: <20021203125935.GC2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_UDF_RW from CRIS defconfig, (it's not used anymore...)

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/cris/defconfig linux-2.5.50-eaa/arch/cris/defconfig
--- linux-2.5.50/arch/cris/defconfig	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/cris/defconfig	Tue Dec  3 00:48:04 2002
@@ -455,7 +455,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
