Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVAMPdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVAMPdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVAMPbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:31:36 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:54788 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261654AbVAMPbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:02 -0500
Subject: [patch 5/8] delete unused header umn.h
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       domen@coderock.org
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:34 +0100
Message-Id: <20050113051334.BF94263251@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Domen Puncer <domen@coderock.org>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

Remove nowhere referenced header. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11/arch/um/include/umn.h |   27 ---------------------------
 1 files changed, 27 deletions(-)

diff -L arch/um/include/umn.h -puN arch/um/include/umn.h~uml-delete-unused-header-umn_h /dev/null
--- linux-2.6.11/arch/um/include/umn.h
+++ /dev/null	2005-01-10 11:39:51.461898480 +0100
@@ -1,27 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __UMN_H
-#define __UMN_H
-
-extern int open_umn_tty(int *slave_out, int *slipno_out);
-extern void close_umn_tty(int master, int slave);
-extern int umn_send_packet(int fd, void *data, int len);
-extern int set_umn_addr(int fd, char *addr, char *ptp_addr);
-extern void slip_unesc(unsigned char s);
-extern void umn_read(int fd);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
_
