Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUAMXzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUAMXy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:54:56 -0500
Received: from sandershosting.com ([69.26.136.138]:33476 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S266217AbUAMXwz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:52:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401131849.46381@sandersweb.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] isapnp modem addition
Date: Tue, 13 Jan 2004 18:52:28 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds support for another pnp modem in 2.6 kernel.  Thanks.

--- drivers/serial/8250_pnp.c.orig	Tue Jan 13 17:40:13 2004
+++ drivers/serial/8250_pnp.c	Tue Jan 13 17:40:25 2004
@@ -295,6 +295,8 @@
 	{	"USR2080",		0	},
 	/* U.S. Robotics 56K FAX INT */
 	{	"USR3031",		0	},
+	/* U.S. Robotics 56K FAX INT */
+	{	"USR3050",		0	},
 	/* U.S. Robotics 56K Voice INT PnP */
 	{	"USR3070",		0	},
 	/* U.S. Robotics 56K Voice EXT PnP */

-- 
David Sanders
linux@sandersweb.net
