Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbRL3UXD>; Sun, 30 Dec 2001 15:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284820AbRL3UWx>; Sun, 30 Dec 2001 15:22:53 -0500
Received: from ns.suse.de ([213.95.15.193]:28427 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284890AbRL3UWi>;
	Sun, 30 Dec 2001 15:22:38 -0500
Date: Sun, 30 Dec 2001 21:22:37 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] procfs build failure in pre4
Message-ID: <Pine.LNX.4.33.0112302121420.7853-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another missing include..
(Needs VM_EXECUTABLE)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

--- base.c	2001/12/27 15:55:53	1.2
+++ base.c	2001/12/30 20:20:51	1.3
@@ -25,6 +25,7 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
+#include <linux/mm.h>

 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.


