Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTFEUUT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTFEUUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:20:18 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:46302 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265109AbTFEUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:20:17 -0400
Date: Thu, 5 Jun 2003 22:33:46 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk9 zlib cleanup #4 z_off_t
Message-ID: <20030605203346.GE22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <20030605200958.GB22439@wohnheim.fh-wedel.de> <20030605201850.GC22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030605201850.GC22439@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This nice macro must have been one of the good intentions on the road
to hell.  Completely unused. :)

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster

--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_z_off_t	2003-06-05 22:13:00.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 22:18:36.000000000 +0200
@@ -64,6 +64,5 @@
 
 #include <linux/types.h> /* for off_t */
 #include <linux/unistd.h>    /* for SEEK_* and off_t */
-#define z_off_t  off_t
 
 #endif /* _ZCONF_H */
