Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286327AbRL0QGY>; Thu, 27 Dec 2001 11:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286324AbRL0QGN>; Thu, 27 Dec 2001 11:06:13 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:9374 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286327AbRL0QGA>;
	Thu, 27 Dec 2001 11:06:00 -0500
Date: Thu, 27 Dec 2001 17:05:57 +0100
To: linux-kernel@vger.kernel.org
Subject: kiB
Message-ID: <20011227160557.GB11106@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this shouldn't be that controversial, as it's only visible to people
compiling kernels :)

-- 

//anders/g

diff -ru linux-2.5.2-pre2/arch/i386/boot/tools/build.c linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c
--- linux-2.5.2-pre2/arch/i386/boot/tools/build.c	Mon Jul  2 22:56:40 2001
+++ linux-2.5.2-pre2-lvmfix/arch/i386/boot/tools/build.c	Thu Dec 27 16:48:55 2001
@@ -148,7 +148,7 @@
 	if (fstat (fd, &sb))
 		die("Unable to stat `%s': %m", argv[3]);
 	sz = sb.st_size;
-	fprintf (stderr, "System is %d kB\n", sz/1024);
+	fprintf (stderr, "System is %d kiB\n", sz/1024);
 	sys_size = (sz + 15) / 16;
 	/* 0x28000*16 = 2.5 MB, conservative estimate for the current maximum */
 	if (sys_size > (is_big_kernel ? 0x28000 : DEF_SYSSIZE))
