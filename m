Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUJ1XR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUJ1XR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUJ1XQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:16:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27410 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261326AbUJ1XPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:15:17 -0400
Date: Fri, 29 Oct 2004 01:14:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sched.c: remove an unused function
Message-ID: <20041028231445.GE3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The patch below removes an unused function from kernel/sched.c


diffstat output:
 kernel/sched.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

- --- linux-2.6.10-rc1-mm1-full/kernel/sched.c.old	2004-10-28 22:33:14.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/kernel/sched.c	2004-10-28 22:34:47.000000000 +0200
@@ -438,11 +438,6 @@
 	return rq;
 }
 
- -static inline void rq_unlock(runqueue_t *rq)
- -{
- -	spin_unlock_irq(&rq->lock);
- -}
- -
 #ifdef CONFIG_SCHEDSTATS
 /*
  * Called when a process is dequeued from the active array and given

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgX1lmfzqmE8StAARAva8AKCKU+UIq++mdjpHqK4YbvoXmGBAwwCfS7OY
p7bxTJ7cdG5gZCkWhPWCyVc=
=UigC
-----END PGP SIGNATURE-----
