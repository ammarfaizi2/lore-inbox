Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVC0TJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVC0TJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVC0TJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:09:40 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:40376 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261460AbVC0TJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:09:14 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] s/driverfs/sysfs/ in include/linux/cpu.h and net/sunrpc/rpc_pipe.c
Date: Sun, 27 Mar 2005 15:59:28 +0200
User-Agent: KMail/1.8
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271559.28893.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

driverfs has been renamed to sysfs long time ago.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.10/include/linux/cpu.h	2005-01-01 17:55:38.000000000 +0100
+++ linux-2.6.10/include/linux/cpu.h.fixed	2005-01-07 13:55:36.167681848 +0100
@@ -8,7 +8,7 @@
  * Basic handling of the devices is done in drivers/base/cpu.c
  * and system devices are handled in drivers/base/sys.c. 
  *
- * CPUs are exported via driverfs in the class/cpu/devices/
+ * CPUs are exported via sysfs in the class/cpu/devices/
  * directory. 
  *
  * Per-cpu interfaces can be implemented using a struct device_interface. 
--- linux-2.6.10/net/sunrpc/rpc_pipe.c	2005-01-01 17:55:50.000000000 +0100
+++ linux-2.6.10/net/sunrpc/rpc_pipe.c.fixed	2005-01-07 14:01:05.373634936 +0100
@@ -3,7 +3,7 @@
  *
  * Userland/kernel interface for rpcauth_gss.
  * Code shamelessly plagiarized from fs/nfsd/nfsctl.c
- * and fs/driverfs/inode.c
+ * and fs/sysfs/inode.c
  *
  * Copyright (c) 2002, Trond Myklebust <trond.myklebust@fys.uio.no>
  *
