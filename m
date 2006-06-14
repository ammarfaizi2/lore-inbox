Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWFNBqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWFNBqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWFNBqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:46:42 -0400
Received: from xenotime.net ([66.160.160.81]:32705 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932393AbWFNBql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:46:41 -0400
Date: Tue, 13 Jun 2006 18:49:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH 2/3] kernel-doc for lib/cmdline.c
Message-Id: <20060613184926.bf40b6c8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add a new chapter for kernel-lib functions to kernel-api.tmpl.
Add lib/cmdline.c to the new kernel-lib chapter.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- linux-2617-rc6.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-rc6/Documentation/DocBook/kernel-api.tmpl
@@ -112,10 +112,23 @@ X!Ilib/string.c
      <sect1><title>Bit Operations</title>
 !Iinclude/asm-i386/bitops.h
      </sect1>
+  </chapter>
+
+  <chapter id="kernel-lib">
+     <title>Basic Kernel Library Functions</title>
+
+     <para>
+       The Linux kernel provides more basic utility functions.
+     </para>
+
      <sect1><title>Bitmap Operations</title>
 !Elib/bitmap.c
 !Ilib/bitmap.c
      </sect1>
+
+     <sect1><title>Command-line Parsing</title>
+!Elib/cmdline.c
+     </sect1>
   </chapter>
 
   <chapter id="mm">


---
