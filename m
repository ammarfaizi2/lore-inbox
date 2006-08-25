Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWHYOva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWHYOva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWHYOuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:50:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30337 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030210AbWHYOt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:56 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/18] [PATCH] BLOCK: Remove no-longer necessary linux/buffer_head.h inclusions [try #3]
Date: Fri, 25 Aug 2006 15:49:53 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144953.30722.69453.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
References: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
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
index e1ba855..3ff865d 100644
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
