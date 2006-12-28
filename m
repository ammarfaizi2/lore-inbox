Return-Path: <linux-kernel-owner+w=401wt.eu-S1754830AbWL1Mnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbWL1Mnv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832AbWL1Mnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:43:51 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:47819 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbWL1Mnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:43:50 -0500
Message-id: <1671375062399111337@wsc.cz>
Subject: [PATCH 1/1] Arch: add gitignore file for relocs in arch i386 fix
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: Thomas Meyer <thomas@m3y3r.de>
Date: Thu, 28 Dec 2006 13:43:55 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add gitignore file for relocs in arch i386 fix

The .gitigonre was intended to be in arch/ subtree.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Thomas Meyer <thomas@m3y3r.de>

---
commit 45dc5568e87fb6ce405b57e18cc0eb4a98da073c
tree c8d38366bee888b5cf043853a8c2edbabdd3b2ee
parent 6db76f0b93634fb9dffba7e87ad2a359ab6f1d8e
author Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 13:39:45 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 13:39:45 +0059

 arch/i386/boot/compressed/.gitignore |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/i386/boot/compressed/.gitignore b/arch/i386/boot/compressed/.gitignore
new file mode 100644
index 0000000..be0ed06
--- /dev/null
+++ b/arch/i386/boot/compressed/.gitignore
@@ -0,0 +1 @@
+relocs
diff --git a/i386/boot/compressed/.gitignore b/i386/boot/compressed/.gitignore
deleted file mode 100644
index be0ed06..0000000
--- a/i386/boot/compressed/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-relocs
