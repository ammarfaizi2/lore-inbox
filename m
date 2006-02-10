Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWBJMNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWBJMNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBJMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:13:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:59341 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751133AbWBJMNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:13:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: fix mistake in documentation
Date: Fri, 10 Feb 2006 13:14:44 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101314.44571.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a mistake in the swsusp documentation.

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/swsusp.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc2-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.16-rc2-mm1.orig/Documentation/power/swsusp.txt
+++ linux-2.6.16-rc2-mm1/Documentation/power/swsusp.txt
@@ -344,7 +344,6 @@ Q: How do I make suspend more verbose?
 
 A: If you want to see any non-error kernel messages on the virtual
 terminal the kernel switches to during suspend, you have to set the
-kernel console loglevel to at least 4 (KERN_WARNING), for example by
-doing
+kernel console loglevel to at least 5, for example by doing
 
-	echo 4 > /proc/sys/kernel/printk
+	echo 5 > /proc/sys/kernel/printk
