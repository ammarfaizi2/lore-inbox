Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268481AbTBWPKN>; Sun, 23 Feb 2003 10:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268483AbTBWPKN>; Sun, 23 Feb 2003 10:10:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7441 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268481AbTBWPKM>; Sun, 23 Feb 2003 10:10:12 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] kernel/pm.c requires <linux/init.h>
Message-Id: <E18mxvO-0000eC-00@raistlin.arm.linux.org.uk>
Date: Sun, 23 Feb 2003 15:20:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch appears not to be in 2.5.62, but applies cleanly.

Subject: kernel/pm.c requires <linux/init.h>

 kernel/pm.c |    2 +-
 1 files changed, 1 insertion, 1 deletion

--- orig/kernel/pm.c	Sun Feb 16 11:46:30 2003
+++ linux/kernel/pm.c	Sat Feb 15 15:46:59 2003
@@ -17,7 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
-
+#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
