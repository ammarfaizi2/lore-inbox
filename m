Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUKMX3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUKMX3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKMX1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:27:30 -0500
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:21918
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261204AbUKMXZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:25:21 -0500
Message-ID: <419697DB.9030402@ppp0.net>
Date: Sun, 14 Nov 2004 00:25:15 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040926 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
CC: perex@suse.cz
Subject: [PATCH] isapnp module_param conversion
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

module_param conversion for isapnp

Signed-off-by: Jan Dittmer <jdittmer@ppp0.net>


diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	2004-11-14 00:21:24 +01:00
+++ b/drivers/pnp/isapnp/core.c	2004-11-14 00:21:24 +01:00
@@ -58,13 +58,13 @@

 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Generic ISA Plug & Play support");
-MODULE_PARM(isapnp_disable, "i");
+module_param(isapnp_disable, int, 0);
 MODULE_PARM_DESC(isapnp_disable, "ISA Plug & Play disable");
-MODULE_PARM(isapnp_rdp, "i");
+module_param(isapnp_rdp, int, 0);
 MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
-MODULE_PARM(isapnp_reset, "i");
+module_param(isapnp_reset, int, 0);
 MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
-MODULE_PARM(isapnp_verbose, "i");
+module_param(isapnp_verbose, int, 0);
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");

