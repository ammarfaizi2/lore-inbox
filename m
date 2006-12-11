Return-Path: <linux-kernel-owner+w=401wt.eu-S937702AbWLKWnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937702AbWLKWnx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937694AbWLKWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:43:53 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64739 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937702AbWLKWnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:43:52 -0500
Date: Mon, 11 Dec 2006 14:44:18 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: kvm-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Cc: avi@qumranet.com, akpm <akpm@osdl.org>
Subject: [PATCH] kvm needs menu structure
Message-Id: <20061211144418.f10a7f5b.randy.dunlap@oracle.com>
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

KVM config items need to be inside a menu structure instead of
dangling off of Device Drivers.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-git18.orig/drivers/kvm/Kconfig
+++ linux-2.6.19-git18/drivers/kvm/Kconfig
@@ -1,7 +1,7 @@
 #
 # KVM configuration
 #
-config KVM
+menuconfig KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on X86 && EXPERIMENTAL
 	---help---


---
