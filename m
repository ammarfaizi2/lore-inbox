Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUH3FcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUH3FcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 01:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUH3FcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 01:32:16 -0400
Received: from ozlabs.org ([203.10.76.45]:3507 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266627AbUH3FcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 01:32:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.48233.611053.243292@cargo.ozlabs.ibm.com>
Date: Mon, 30 Aug 2004 15:34:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, engebret@us.ibm.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Update PPC MAINTAINERS & CREDITS
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Engebretsen has moved on to other things and is no longer
maintaining ppc64.  This patch adds an entry in CREDITS to note his
contribution in leading the team that did the PPC64 port originally
and updates various PPC-related MAINTAINERS entries.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/CREDITS akpm/CREDITS
--- linux-2.5/CREDITS	2004-08-30 10:55:34.000000000 +1000
+++ akpm/CREDITS	2004-08-30 15:28:50.495338464 +1000
@@ -911,6 +911,10 @@
 S: S-114 79 Stockholm
 S: Sweden
 
+N: David Engebretsen
+E: engebret@us.ibm.com
+D: Linux port to 64-bit PowerPC architecture
+
 N: Michael Engel
 E: engel@unix-ag.org
 D: DECstation framebuffer drivers
diff -urN linux-2.5/MAINTAINERS akpm/MAINTAINERS
--- linux-2.5/MAINTAINERS	2004-08-30 10:55:36.000000000 +1000
+++ akpm/MAINTAINERS	2004-08-30 15:14:08.865307608 +1000
@@ -1290,13 +1290,14 @@
 LINUX FOR POWERPC
 P:	Paul Mackerras
 M:	paulus@samba.org
-W:	http://www.fsmlabs.com/linuxppcbk.html
+W:	http://www.penguinppc.org/
+L:	linuxppc-dev@lists.linuxppc.org
 S:	Supported
 
 LINUX FOR POWER MACINTOSH
 P:	Benjamin Herrenschmidt
 M:	benh@kernel.crashing.org
-W:	http://www.linuxppc.org/
+W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.linuxppc.org
 S:	Maintained
 
@@ -1327,9 +1328,11 @@
 S:	Maintained
 
 LINUX FOR 64BIT POWERPC
-P:	David Engebretsen (stable kernel)
-M:	engebret@us.ibm.com
-P:	Anton Blanchard (development kernel)
+P:	Paul Mackerras
+M:	paulus@samba.org
+M:	paulus@au.ibm.com
+P:	Anton Blanchard
+M:	anton@samba.org
 M:	anton@au.ibm.com
 W:	http://linuxppc64.org
 L:	linuxppc64-dev@lists.linuxppc.org
