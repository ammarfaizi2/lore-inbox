Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAMNWq>; Sat, 13 Jan 2001 08:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRAMNWg>; Sat, 13 Jan 2001 08:22:36 -0500
Received: from kamov.deltanet.ro ([193.226.175.3]:49933 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S129485AbRAMNWY>;
	Sat, 13 Jan 2001 08:22:24 -0500
Date: Sat, 13 Jan 2001 15:21:04 +0200
From: Petru Paler <ppetru@ppetru.net>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: [PATCH] sparc64 compile fix
Message-ID: <20010113152104.B2734@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- arch/sparc64/kernel/sys_sparc32.c.orig      Sat Jan 13 07:59:43 2001
+++ arch/sparc64/kernel/sys_sparc32.c   Sat Jan 13 08:00:23 2001
@@ -904,7 +904,7 @@
 {
        int cmds = cmd >> SUBCMDSHIFT;
        int err;
-       struct dqblk d;
+       struct dqblk32 d;
        mm_segment_t old_fs;
        char *spec;                                                                       

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
