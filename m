Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTG1CTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271025AbTG1ABC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:02 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272944AbTG0XCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:10 -0400
Date: Sun, 27 Jul 2003 20:56:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307271956.h6RJuX70029539@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: more typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/cris/arch-v10/lib/old_checksum.c linux-2.6.0-test2-ac1/arch/cris/arch-v10/lib/old_checksum.c
--- linux-2.6.0-test2/arch/cris/arch-v10/lib/old_checksum.c	2003-07-10 21:13:04.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/cris/arch-v10/lib/old_checksum.c	2003-07-23 16:39:58.000000000 +0100
@@ -75,7 +75,7 @@
     sum += *((unsigned short *)buff)++;
   }
   if(endMarker - buff > 0) {
-    sum += *buff;                 /* add extra byte seperately */
+    sum += *buff;                 /* add extra byte separately */
   }
   BITOFF;
   return(sum);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/arch/cris/mm/fault.c linux-2.6.0-test2-ac1/arch/cris/mm/fault.c
--- linux-2.6.0-test2/arch/cris/mm/fault.c	2003-07-10 21:14:10.000000000 +0100
+++ linux-2.6.0-test2-ac1/arch/cris/mm/fault.c	2003-07-23 16:39:58.000000000 +0100
@@ -8,7 +8,7 @@
  *  $Log: fault.c,v $
  *  Revision 1.8  2003/07/04 13:02:48  tobiasa
  *  Moved code snippet from arch/cris/mm/fault.c that searches for fixup code
- *  to seperate function in arch-specific files.
+ *  to separate function in arch-specific files.
  *
  *  Revision 1.7  2003/01/22 06:48:38  starvik
  *  Fixed warnings issued by GCC 3.2.1
