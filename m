Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275470AbTHSFVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275499AbTHSFVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:21:33 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:8678 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275470AbTHSFVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:21:31 -0400
Date: Tue, 19 Aug 2003 15:22:38 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH, TRIVIAL] 2.6.0-t3: hd.c typo fix
Message-ID: <20030819052238.GF643@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted this typo whilst debugging my C99 patch:

--- linux.backup/drivers/ide/legacy/hd.c	Sat Aug 16 15:02:44 2003
+++ linux/drivers/ide/legacy/hd.c	Tue Aug 19 14:44:50 2003
@@ -715,7 +715,7 @@
 
 	hd_queue = blk_init_queue(do_hd_request, &hd_lock);
 	if (!hd_queue) {
-		unegister_blkdev(MAJOR_NR,"hd");
+		unregister_blkdev(MAJOR_NR,"hd");
 		return -ENOMEM;
 	}
 

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
