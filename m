Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWEZOWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWEZOWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWEZOW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:27012 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750780AbWEZOV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:57 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 4/10] uint16_t -> u16
Message-Id: <E1FjdCG-00033M-Kn@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uint16_t replaced with more kernel-appropriate u16.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

46e9182ba5ba7c1b503f23b69f3accce416f1b71
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index a0e9f05..9376482 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -141,7 +141,7 @@ static match_table_t tokens = {
  *
  * Returns zero on good version; non-zero otherwise
  */
-int ecryptfs_verify_version(uint16_t version)
+int ecryptfs_verify_version(u16 version)
 {
 	int rc = 0;
 	unsigned char major;
-- 
1.3.3

