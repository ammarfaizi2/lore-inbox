Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFBOyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFBOyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 10:54:17 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:5066 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262400AbTFBOyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 10:54:16 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.70] fs/Kconfig fix
Date: Mon, 2 Jun 2003 17:10:54 +0200
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306021710.54842@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this fixes a typo in the CIFS help text an updates a comment on devpts, which
is now also needed if devfs is in use.

Eike

--- linux-2.5.70-bk3/fs/Kconfig.orig	2003-05-29 15:36:42.000000000 +0200
+++ linux-2.5.70-bk3/fs/Kconfig	2003-05-29 15:45:13.000000000 +0200
@@ -824,8 +824,8 @@
 	  API. Please read <file:Documentation/Changes> for more information
 	  about the Unix98 pty devices.
 
-	  Note that the experimental "/dev file system support"
-	  (CONFIG_DEVFS_FS)  is a more general facility.
+	  Note that this is needed even if "/dev file system support"
+	  (CONFIG_DEVFS_FS) is set.
 
 config DEVPTS_FS_XATTR
 	bool "/dev/pts Extended Attributes"
@@ -1504,7 +1504,7 @@
 	  cifs module since smbfs is currently more stable and provides
 	  support for older servers.  The intent of this module is to provide the
 	  most advanced network file system function for CIFS compliant servers, 
-	  including support for dfs (heirarchical name space), secure per-user
+	  including support for dfs (hierarchical name space), secure per-user
 	  session establishment, safe distributed caching (oplock), optional
 	  packet signing, Unicode and other internationalization improvements, and
 	  optional Winbind (nsswitch) integration.  This module is in an early
