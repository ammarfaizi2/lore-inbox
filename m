Return-Path: <linux-kernel-owner+w=401wt.eu-S932528AbXARVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbXARVzp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbXARVzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:55:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3713 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932528AbXARVzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:55:44 -0500
Date: Thu, 18 Jan 2007 22:55:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/alternative.c should #include <asm/bugs.h>
Message-ID: <20070118215550.GF9093@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should include the headers containing the prototypes for
it's global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Jan 2007

--- linux-2.6.20-rc2-mm1/arch/i386/kernel/alternative.c.old	2007-01-03 23:13:18.000000000 +0100
+++ linux-2.6.20-rc2-mm1/arch/i386/kernel/alternative.c	2007-01-03 23:13:32.000000000 +0100
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
+#include <asm/bugs.h>
 
 static int no_replacement    = 0;
 static int smp_alt_once      = 0;

