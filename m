Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbUKUSVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUKUSVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUKUSVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 13:21:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61710 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261760AbUKUSTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 13:19:51 -0500
Date: Sun, 21 Nov 2004 19:19:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jaharkes@cs.cmu.edu, codalist@coda.cs.cmu.edu,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/coda/psdev.c shouldn't include lp.h (fwd)
Message-ID: <20041121181949.GH2924@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below (already ACK'ed by Jan Harkes) still applies 
and compiles against 2.6.10-rc2-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 7 Nov 2004 01:52:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jaharkes@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/coda/psdev.c shouldn't include lp.h


I don't see any reason why fs/coda/psdev.c includes lp.h


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/fs/coda/psdev.c.old	2004-11-07 01:31:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/fs/coda/psdev.c	2004-11-07 01:31:16.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/time.h>
-#include <linux/lp.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

