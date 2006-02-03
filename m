Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWBCUSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWBCUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWBCUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:18:16 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:46231 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751267AbWBCUSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:18:14 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pktcdvd: Remove version string
References: <m3bqxoci5g.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:18:04 +0100
In-Reply-To: <m3bqxoci5g.fsf@telia.com>
Message-ID: <m37j8cci2r.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The version information is not useful for a driver that is maintained
in Linus' kernel tree.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index f0a0ad4..01f070a 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -43,8 +43,6 @@
  *
  *************************************************************************/
 
-#define VERSION_CODE	"v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com"
-
 #include <linux/pktcdvd.h>
 #include <linux/config.h>
 #include <linux/module.h>
@@ -2679,7 +2677,6 @@ static int __init pkt_init(void)
 
 	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
 
-	DPRINTK("pktcdvd: %s\n", VERSION_CODE);
 	return 0;
 
 out:

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
