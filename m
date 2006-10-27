Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423660AbWJ0FE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423660AbWJ0FE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423663AbWJ0FE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:04:29 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:57461 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423660AbWJ0FE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:04:28 -0400
Date: Thu, 26 Oct 2006 21:59:46 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, holzheu@de.ibm.com
Subject: [PATCH] move SYS_HYPERVISOR inside the Generic Driver menu
Message-Id: <20061026215946.71267896.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Put SYS_HYPERVISOR inside the Generic Driver Config menu
where it should be.  Otherwise xconfig displays it as a
dangling (lost) menu item under Device Drivers, all by
itself (when all options are displayed).

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/base/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2619-rc3-pv.orig/drivers/base/Kconfig
+++ linux-2619-rc3-pv/drivers/base/Kconfig
@@ -37,8 +37,8 @@ config DEBUG_DRIVER
 
 	  If you are unsure about this, say N here.
 
-endmenu
-
 config SYS_HYPERVISOR
 	bool
 	default n
+
+endmenu


---
