Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272580AbTG1AeH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272579AbTG1AEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:46 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272715AbTG0W6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:13 -0400
Date: Sun, 27 Jul 2003 21:17:56 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272017.h6RKHuDK029749@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: kill __NO_VERSION__ in intermezzo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Adrian Bunk)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/intermezzo/fileset.c linux-2.6.0-test2-ac1/fs/intermezzo/fileset.c
--- linux-2.6.0-test2/fs/intermezzo/fileset.c	2003-07-10 21:07:40.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/intermezzo/fileset.c	2003-07-23 15:44:21.000000000 +0100
@@ -22,8 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
-
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
