Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945987AbWJTM6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945987AbWJTM6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423125AbWJTM6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:58:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:59885 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423226AbWJTM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:58:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=YjF1NgNFwCHJBUnBj9fOGGWVEi5HEKfjMoDt+QZXHWsEafdI6WuEM12E2BvhLJesPPCXxQDsY4DdV2uYKrmRpVilYg5E22DvcpLlaJZNVZlSxgnoXMpIFUkzvZ2u5kn1Ao3H1ySl4Q2i0sHLgpT1J7U3IHN5qtQ+hKajZMyNDlc=
Date: Fri, 20 Oct 2006 16:58:42 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Markus Lidel <markus.lidel@shadowconnect.com>
Subject: [PATCH 2/3] i2o/exec-osm.c: use "unsigned long flags;"
Message-ID: <20061020125842.GB17199@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just like everyone else.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/message/i2o/exec-osm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/message/i2o/exec-osm.c
+++ b/drivers/message/i2o/exec-osm.c
@@ -127,7 +127,7 @@ int i2o_msg_post_wait_mem(struct i2o_con
 	DECLARE_WAIT_QUEUE_HEAD(wq);
 	struct i2o_exec_wait *wait;
 	static u32 tcntxt = 0x80000000;
-	long flags;
+	unsigned long flags;
 	int rc = 0;
 
 	wait = i2o_exec_wait_alloc();

