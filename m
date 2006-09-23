Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWIWAZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWIWAZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWIWAZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:25:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63630 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932213AbWIWAZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:25:23 -0400
Date: Sat, 23 Sep 2006 01:25:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm/backlight.h is ppc-only
Message-ID: <20060923002518.GZ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/macintosh/adbhid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index c69d23b..efd51e0 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -45,8 +45,8 @@ #include <linux/cuda.h>
 #include <linux/pmu.h>
 
 #include <asm/machdep.h>
-#include <asm/backlight.h>
 #ifdef CONFIG_PPC_PMAC
+#include <asm/backlight.h>
 #include <asm/pmac_feature.h>
 #endif
 
-- 
1.4.2.GIT
