Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWDSIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWDSIeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDSIeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:34:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21386 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750778AbWDSIeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:34:13 -0400
Date: Wed, 19 Apr 2006 09:30:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch, 2.6.17-rc2] dm: fix typo
Message-ID: <20060419073030.GA15910@elte.hu>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm: fix typo.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
----

 drivers/md/dm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: linux/drivers/md/dm.c
===================================================================
--- linux.orig/drivers/md/dm.c
+++ linux/drivers/md/dm.c
@@ -1004,7 +1004,7 @@ int dm_create(struct mapped_device **res
 
 int dm_create_with_minor(unsigned int minor, struct mapped_device **result)
 {
-	return create_aux(minor, 1, reqult);
+	return create_aux(minor, 1, result);
 }
 
 static struct mapped_device *dm_find_md(dev_t dev)
