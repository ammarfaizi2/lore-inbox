Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTIVA1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTIVA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:27:00 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17293 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262729AbTIVAT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:19:27 -0400
Date: Sun, 21 Sep 2003 20:12:25 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201225.GG24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921200935.GB24897@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1359
# [ISAPNP] remove unused isapnp_allow_dma0 modparam
# 
# It looks like this option has been moved from isapnp to resource.c,
# but the MODULE_PARM line is still there:
# 
# patch from: Gerald Teschl <gt@esi.ac.at>
# --------------------------------------------
#
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Sep 21 19:45:47 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Sep 21 19:45:47 2003
@@ -64,7 +64,6 @@
 MODULE_PARM_DESC(isapnp_rdp, "ISA Plug & Play read data port");
 MODULE_PARM(isapnp_reset, "i");
 MODULE_PARM_DESC(isapnp_reset, "ISA Plug & Play reset all cards");
-MODULE_PARM(isapnp_allow_dma0, "i");
 MODULE_PARM(isapnp_verbose, "i");
 MODULE_PARM_DESC(isapnp_verbose, "ISA Plug & Play verbose mode");
 MODULE_LICENSE("GPL");
