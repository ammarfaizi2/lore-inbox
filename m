Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbULLNA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbULLNA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 08:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbULLNA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 08:00:56 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:52971 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262072AbULLNAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 08:00:52 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041212130113.10564.41012.78969@localhost.localdomain>
Subject: [PATCH] moxa: Update status of Moxa Smartio driver
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.220.243] at Sun, 12 Dec 2004 07:00:51 -0600
Date: Sun, 12 Dec 2004 07:00:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After contacting Moxa, I found out that they no longer maintain the in-kernel
driver, and instead maintain an updated driver as an external patch.

This patch updates the documentation to reflect this.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc3-original/Documentation/moxa-smartio linux-2.6.10-rc3/Documentation/moxa-smartio
--- linux-2.6.10-rc3-original/Documentation/moxa-smartio	2004-12-03 16:53:46.000000000 -0500
+++ linux-2.6.10-rc3/Documentation/moxa-smartio	2004-12-12 07:49:44.419433515 -0500
@@ -1,3 +1,13 @@
+***NOTE*** - The driver included in the kernel is not maintained by Moxa.  They
+have a version 1.8 driver available from:
+
+http://www.moxa.com
+
+that works with 2.6 kernels.  Currently, Moxa has no plans to have their updated
+driver merged into the kernel.
+
+James Nelson <james4765@gmail.com> - 12-12-2004
+
 =============================================================================
 
 	MOXA Smartio Family Device Driver Ver 1.1 Installation Guide
