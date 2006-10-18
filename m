Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422846AbWJRUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWJRUJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWJRUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:09:18 -0400
Received: from mail.suse.de ([195.135.220.2]:7346 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422808AbWJRUJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:12 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: "Ed L. Cashin" <ecashin@coraid.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 3/15] aoe: remove unused NARGS enum
Date: Wed, 18 Oct 2006 13:08:54 -0700
Message-Id: <1161202152750-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021491255-git-send-email-greg@kroah.com>
References: <20061018200433.GA10079@kroah.com> <11612021463993-git-send-email-greg@kroah.com> <11612021491255-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L. Cashin <ecashin@coraid.com>

The NARGS enum is left over from older code versions.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/aoe/aoechr.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index 8a7a081..0c543d3 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -15,7 +15,6 @@ enum {
 	MINOR_INTERFACES,
 	MINOR_REVALIDATE,
 	MSGSZ = 2048,
-	NARGS = 10,
 	NMSG = 100,		/* message backlog to retain */
 };
 
-- 
1.4.2.4

