Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbTIMAZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTIMAZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:25:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:27881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261964AbTIMAZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:25:55 -0400
Date: Fri, 12 Sep 2003 17:25:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4][LSM] 2.6.0-test5-bk LSM comment fixup
Message-ID: <20030912172552.C8718@build.pdx.osdl.net>
References: <20030912171833.A8718@build.pdx.osdl.net> <20030912172312.B8718@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030912172312.B8718@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Sep 12, 2003 at 05:23:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From: John Levon <levon@movementarian.org>

 LSM: Update comments in register_security to reflect reality

 security/security.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

--- 2.6.0-test5-bk/security/security.c.comment	Wed Jun 11 17:40:12 2003
+++ 2.6.0-test5-bk/security/security.c	Fri Sep 12 15:41:47 2003
@@ -79,9 +79,8 @@
  * value passed to this function.  A call to unregister_security() should be
  * done to remove this security_options structure from the kernel.
  *
- * If the @ops structure does not contain function pointers for all hooks in
- * the structure, or there is already a security module registered with the
- * kernel, an error will be returned.  Otherwise 0 is returned on success.
+ * If there is already a security module registered with the kernel,
+ * an error will be returned.  Otherwise 0 is returned on success.
  */
 int register_security (struct security_operations *ops)
 {
