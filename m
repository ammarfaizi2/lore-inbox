Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423179AbWCXGNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423179AbWCXGNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 01:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423171AbWCXGMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 01:12:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:38874 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161013AbWCXGLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 01:11:47 -0500
Cc: "Ed L. Cashin" <ecashin@coraid.com>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/12] aoe [7/8]: update driver compatibility string
In-Reply-To: <11431806531230-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Thu, 23 Mar 2006 22:10:53 -0800
Message-Id: <1143180653135-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aoe driver is not compatible with 2.6 kernels older
than 2.6.2.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/block/aoe/aoemain.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

02edb05e6310d3acbb26ffb038f0eb819274e6d0
diff --git a/drivers/block/aoe/aoemain.c b/drivers/block/aoe/aoemain.c
index f39d5ba..de08491 100644
--- a/drivers/block/aoe/aoemain.c
+++ b/drivers/block/aoe/aoemain.c
@@ -11,7 +11,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sam Hopkins <sah@coraid.com>");
-MODULE_DESCRIPTION("AoE block/char driver for 2.6.[0-9]+");
+MODULE_DESCRIPTION("AoE block/char driver for 2.6.2 and newer 2.6 kernels");
 MODULE_VERSION(VERSION);
 
 enum { TINIT, TRUN, TKILL };
-- 
1.2.4


