Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272583AbTG1AFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272582AbTG1AEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272713AbTG0W6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:11 -0400
Date: Sun, 27 Jul 2003 21:25:23 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272025.h6RKPNlY029816@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: sunrpc doesnt need uaccess.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Frank Cusack)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/net/sunrpc/xprt.c linux-2.6.0-test2-ac1/net/sunrpc/xprt.c
--- linux-2.6.0-test2/net/sunrpc/xprt.c	2003-07-27 19:56:29.000000000 +0100
+++ linux-2.6.0-test2-ac1/net/sunrpc/xprt.c	2003-07-27 20:48:24.000000000 +0100
@@ -66,8 +66,6 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 
-#include <asm/uaccess.h>
-
 /*
  * Local variables
  */
