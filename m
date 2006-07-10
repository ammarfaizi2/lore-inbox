Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWGJXbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWGJXbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWGJXbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:31:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965009AbWGJXbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:31:39 -0400
Subject: [HDRINSTALL 1/3] Remove asm/irq.h from user visibility
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Jul 2006 00:32:03 +0100
Message-Id: <1152574324.25567.53.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches are available at git://git.infradead.org/hdrinstall-2.6.git

The first removes asm/irq.h from the exported headers -- there was never
any good reason for it to have been listed.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index d8d0bce..da163c1 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -1,5 +1,5 @@
 unifdef-y += a.out.h auxvec.h byteorder.h errno.h fcntl.h ioctl.h	\
-	ioctls.h ipcbuf.h irq.h mman.h msgbuf.h param.h poll.h		\
+	ioctls.h ipcbuf.h mman.h msgbuf.h param.h poll.h		\
 	posix_types.h ptrace.h resource.h sembuf.h shmbuf.h shmparam.h	\
 	sigcontext.h siginfo.h signal.h socket.h sockios.h stat.h	\
 	statfs.h termbits.h termios.h timex.h types.h unistd.h user.h

-- 
dwmw2

