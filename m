Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTFFSTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTFFSTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:19:16 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:5045 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262151AbTFFSTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:19:13 -0400
Date: Fri, 6 Jun 2003 20:32:47 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk11 zlib cleanup #2 cpp
Message-ID: <20030606183247.GB10487@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030606183126.GA10487@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hope we don't use any cplusplus in the kernel.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu

--- linux-2.5.70-bk11/include/linux/zlib.h~zlib_cleanup_cpp	2003-06-06 15:56:15.000000000 +0200
+++ linux-2.5.70-bk11/include/linux/zlib.h	2003-06-06 19:53:06.000000000 +0200
@@ -33,10 +33,6 @@
 
 #include <linux/zconf.h>
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 #define ZLIB_VERSION "1.1.3"
 
 /* 
@@ -640,8 +636,4 @@
 extern int           zlib_inflateSyncPoint (z_streamp z);
 extern const uLong * zlib_get_crc_table    (void);
 
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* _ZLIB_H */
