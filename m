Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVC1Fqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVC1Fqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 00:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVC1Fqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 00:46:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:20451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbVC1Fqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 00:46:43 -0500
Date: Sun, 27 Mar 2005 21:42:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: ]PATCH] cpuset: make function decl. ANSI
Message-Id: <20050327214226.72dc5a34.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel/cpuset.c:1428:41: warning: non-ANSI function declaration

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 kernel/cpuset.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./kernel/cpuset.c~cpuset_void ./kernel/cpuset.c
--- ./kernel/cpuset.c~cpuset_void	2005-03-26 21:48:12.000000000 -0800
+++ ./kernel/cpuset.c	2005-03-27 20:59:21.000000000 -0800
@@ -1425,7 +1425,7 @@ void cpuset_init_current_mems_allowed(vo
  * Do not call this routine if in_interrupt().
  */
 
-void cpuset_update_current_mems_allowed()
+void cpuset_update_current_mems_allowed(void)
 {
 	struct cpuset *cs = current->cpuset;
 


---
