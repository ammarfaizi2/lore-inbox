Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWCZRew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWCZRew (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWCZRew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:34:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:10189 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751214AbWCZRev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:34:51 -0500
Date: Sun, 26 Mar 2006 09:23:58 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: manfred@dbl.q-ag.de, manfred@colorfullife.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: + mqueue-comment-fix.patch added to -mm tree
Message-ID: <20060326152358.GA8280@sergelap.austin.ibm.com>
References: <200603261022.k2QAM7BQ001237@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603261022.k2QAM7BQ001237@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting akpm@osdl.org (akpm@osdl.org):
> 
> The patch titled
> 
>      mquueu comment fix
> 
> has been added to the -mm tree.  Its filename is
> 
>      mqueue-comment-fix.patch

Well as long as we're patching that, may as well fix the spelling:

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

--- mqueue.c.orig	2006-03-26 09:20:34.000000000 -0600
+++ mqueue.c	2006-03-26 09:21:30.000000000 -0600
@@ -761,7 +761,7 @@
  * The receiver accepts the message and returns without grabbing the queue
  * spinlock. Therefore an intermediate STATE_PENDING state and memory barriers
  * are necessary. The same algorithm is used for sysv semaphores, see
- * ipc/sem.c fore more details.
+ * ipc/sem.c for more details.
  *
  * The same algorithm is used for senders.
  */
