Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269120AbUI2XSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbUI2XSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269168AbUI2XSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:18:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:15588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269120AbUI2XSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:18:13 -0400
Date: Wed, 29 Sep 2004 16:18:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: [PATCH] make CONFIG_PM_DEBUG depend on CONFIG_PM
Message-ID: <20040929161812.A1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make CONFIG_PM_DEBUG depend on CONFIG_PM

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/power/Kconfig 1.11 vs edited =====
--- 1.11/kernel/power/Kconfig	2004-08-01 20:36:39 -07:00
+++ edited/kernel/power/Kconfig	2004-09-29 16:01:40 -07:00
@@ -20,6 +20,7 @@
 
 config PM_DEBUG
 	bool "Power Management Debug Support"
+	depends on PM
 	---help---
 	This option enables verbose debugging support in the Power Management
 	code. This is helpful when debugging and reporting various PM bugs, 
