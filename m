Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUAWGgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUAWGgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:36:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17362 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266513AbUAWGgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:40 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: Update post-halloween doc url.
Message-Id: <E1Ajuub-0000xD-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did a s/2.5/2.6/ a while ago, as it made more sense
when 2.6 appeared.  Old URL will continue to work (symlink to
the new file).  If I move this again, whack me.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/Makefile linux-2.5/Makefile
--- bk-linus/Makefile	2004-01-21 15:58:33.000000000 +0000
+++ linux-2.5/Makefile	2004-01-23 04:27:23.000000000 +0000
@@ -690,7 +690,7 @@ modules_install: _modinst_ _modinst_post
 _modinst_:
 	@if [ -z "`$(DEPMOD) -V | grep module-init-tools`" ]; then \
 		echo "Warning: you may need to install module-init-tools"; \
-		echo "See http://www.codemonkey.org.uk/post-halloween-2.5.txt";\
+		echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
 		sleep 1; \
 	fi
 	@rm -rf $(MODLIB)/kernel
