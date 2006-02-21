Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWBUDsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWBUDsf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbWBUDsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:15 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:11453 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161308AbWBUDsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:09 -0500
Message-Id: <20060221034750.710256000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:36 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>,
       Paul Mackerras <paulus@samba.org>
Subject: [-mm patch 8/8] ppc: fix undefined reference to hweight32
Content-Disposition: inline; filename=ppc-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build fix for ppc

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Cc: Paul Mackerras <paulus@samba.org>

 arch/ppc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+)

Index: 2.6-mm/arch/ppc/Kconfig
===================================================================
--- 2.6-mm.orig/arch/ppc/Kconfig
+++ 2.6-mm/arch/ppc/Kconfig
@@ -19,6 +19,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default y
 
+config GENERIC_HWEIGHT
+	bool
+	default y
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y

--
