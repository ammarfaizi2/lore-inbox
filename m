Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTIVAUI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTIVATu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:19:50 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16525 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262726AbTIVATC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:19:02 -0400
Date: Sun, 21 Sep 2003 20:11:59 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201159.GF24897@neo.rr.com>
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
# 03/09/21	ambx1@neo.rr.com	1.1358
# [PATCH] janitor: remove unneeded includes (isapnp)
# 
# From: Randy Hron <rwhron@earthlink.net>
# --------------------------------------------
#
diff -Nru a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
--- a/drivers/pnp/isapnp/compat.c	Sun Sep 21 19:45:53 2003
+++ b/drivers/pnp/isapnp/compat.c	Sun Sep 21 19:45:53 2003
@@ -9,7 +9,6 @@
 /* TODO: see if more isapnp functions are needed here */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/isapnp.h>
 #include <linux/string.h>
diff -Nru a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	Sun Sep 21 19:45:53 2003
+++ b/drivers/pnp/isapnp/core.c	Sun Sep 21 19:45:53 2003
@@ -35,7 +35,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff -Nru a/drivers/pnp/isapnp/proc.c b/drivers/pnp/isapnp/proc.c
--- a/drivers/pnp/isapnp/proc.c	Sun Sep 21 19:45:53 2003
+++ b/drivers/pnp/isapnp/proc.c	Sun Sep 21 19:45:53 2003
@@ -20,7 +20,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/isapnp.h>
 #include <linux/proc_fs.h>
