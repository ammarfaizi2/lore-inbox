Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261412AbSJMBHQ>; Sat, 12 Oct 2002 21:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSJMBHQ>; Sat, 12 Oct 2002 21:07:16 -0400
Received: from modemcable061.219-201-24.mtl.mc.videotron.ca ([24.201.219.61]:8343
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261412AbSJMBHP>; Sat, 12 Oct 2002 21:07:15 -0400
Date: Sat, 12 Oct 2002 20:53:04 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] make cifs/print_status static
Message-ID: <Pine.LNX.4.44.0210122050250.10081-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.5.42/fs/cifs/nterr.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.42/fs/cifs/nterr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 nterr.c
--- linux-2.5.42/fs/cifs/nterr.c	12 Oct 2002 16:56:42 -0000	1.1.1.1
+++ linux-2.5.42/fs/cifs/nterr.c	13 Oct 2002 00:45:56 -0000
@@ -694,7 +694,7 @@
 /*****************************************************************************
  Print an error message from the status code
  *****************************************************************************/
-void
+static void
 print_status(__u32 status_code)
 {
 	int idx = 0;

-- 
function.linuxpower.ca

