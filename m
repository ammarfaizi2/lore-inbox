Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSL3Awz>; Sun, 29 Dec 2002 19:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSL3Awz>; Sun, 29 Dec 2002 19:52:55 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:21741 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S262472AbSL3Awx>;
	Sun, 29 Dec 2002 19:52:53 -0500
Subject: Re: [PATCH] vlsi_ir.h, add #define for KERNEL_VERSION
From: Steven Barnhart <sbarn03@softhome.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021230002205.A13560@infradead.org>
References: <1041207283.23364.6.camel@sbarn.net> 
	<20021230002205.A13560@infradead.org>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Dec 2002 20:01:18 -0500
Message-Id: <1041210085.26120.1.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_jive-6267-1041210075-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_jive-6267-1041210075-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

On Sun, 2002-12-29 at 19:22, Christoph Hellwig wrote:

> What about including <linux/version.h> instead? :)
> 

Ok that obviously is better so here is the updated patch. Please apply
and comment on any other problems with that :)

Steven

-----
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.976   -> 1.977  
#	drivers/net/irda/vlsi_ir.c	1.14    -> 1.15   
#	include/net/irda/vlsi_ir.h	1.6     -> 1.7    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.977
# [PATCH] Add missing include <linux/version.h> to vlsi_ir.c in place of
previous patch.
# --------------------------------------------
#
diff -Nru a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	Sun Dec 29 19:59:26 2002
+++ b/drivers/net/irda/vlsi_ir.c	Sun Dec 29 19:59:26 2002
@@ -49,7 +49,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/wrapper.h>
-
+#include <linux/version.h>
 #include <net/irda/vlsi_ir.h>
 
 /********************************************************/
diff -Nru a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Sun Dec 29 19:59:26 2002
+++ b/include/net/irda/vlsi_ir.h	Sun Dec 29 19:59:26 2002
@@ -26,7 +26,7 @@
 
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
-#define KERNEL_VERSION
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4) 
 #ifdef CONFIG_PROC_FS
 /* PDE() introduced in 2.5.4 */


--=_jive-6267-1041210075-0001-2
Content-Type: text/plain; name="vlsi.c-patch"; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=vlsi.c-patch

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.976   -> 1.977 =20
#	drivers/net/irda/vlsi_ir.c	1.14    -> 1.15  =20
#	include/net/irda/vlsi_ir.h	1.6     -> 1.7   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/29	steven@sbarn.net	1.977
# [PATCH] Add missing include <linux/version.h> to vlsi_ir.c in place of pr=
evious patch.
# --------------------------------------------
#
diff -Nru a/drivers/net/irda/vlsi_ir.c b/drivers/net/irda/vlsi_ir.c
--- a/drivers/net/irda/vlsi_ir.c	Sun Dec 29 19:59:26 2002
+++ b/drivers/net/irda/vlsi_ir.c	Sun Dec 29 19:59:26 2002
@@ -49,7 +49,7 @@
 #include <net/irda/irda.h>
 #include <net/irda/irda_device.h>
 #include <net/irda/wrapper.h>
-
+#include <linux/version.h>
 #include <net/irda/vlsi_ir.h>
=20
 /********************************************************/
diff -Nru a/include/net/irda/vlsi_ir.h b/include/net/irda/vlsi_ir.h
--- a/include/net/irda/vlsi_ir.h	Sun Dec 29 19:59:26 2002
+++ b/include/net/irda/vlsi_ir.h	Sun Dec 29 19:59:26 2002
@@ -26,7 +26,7 @@
=20
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
-#define KERNEL_VERSION
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)=20
 #ifdef CONFIG_PROC_FS
 /* PDE() introduced in 2.5.4 */

--=_jive-6267-1041210075-0001-2--
