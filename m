Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTERDcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 23:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTERDcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 23:32:39 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:42070 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261928AbTERDci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 23:32:38 -0400
Date: Sat, 17 May 2003 20:45:28 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.69 net/sunrpc/sunrpc_syms.c (trivial)
Message-ID: <20030517204528.A12071@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5.69/net/sunrpc/sunrpc_syms.c.orig	Sat May 17 20:44:29 2003
+++ linux-2.5.69/net/sunrpc/sunrpc_syms.c	Sat May 17 20:44:37 2003
@@ -169,7 +169,7 @@
 #ifdef RPC_DEBUG
 	rpc_unregister_sysctl();
 #endif
-#ifdef CONFIG_PROCFS
+#ifdef CONFIG_PROC_FS
 	rpc_proc_exit();
 #endif
 }

