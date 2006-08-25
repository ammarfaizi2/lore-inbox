Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422856AbWHYThs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbWHYThs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422853AbWHYThs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:37:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422851AbWHYThq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:37:46 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/18] [PATCH] BLOCK: Remove no-longer necessary linux/buffer_head.h inclusions [try #4]
Date: Fri, 25 Aug 2006 20:37:37 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825193737.11384.48544.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
References: <20060825193658.11384.8349.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Remove inclusions of linux/buffer_head.h that are no longer necessary due to the
transfer of a number of things out of there.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c   |    1 -
 fs/cifs/inode.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 5ff8e3a..82e8d83 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -16,7 +16,6 @@ #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
-#include <linux/buffer_head.h>
 #include "volume.h"
 #include "vnode.h"
 #include <rxrpc/call.h>
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b88147c..05f874c 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -19,7 +19,6 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 #include <linux/fs.h>
-#include <linux/buffer_head.h>
 #include <linux/stat.h>
 #include <linux/pagemap.h>
 #include <asm/div64.h>
