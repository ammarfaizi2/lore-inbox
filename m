Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWIWAYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWIWAYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWIWAYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:24:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28339 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932207AbWIWAYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:24:31 -0400
Date: Sat, 23 Sep 2006 01:24:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aoa is pmac-only
Message-ID: <20060923002425.GY29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 sound/aoa/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/aoa/Kconfig b/sound/aoa/Kconfig
index 2f4334d..5d5813c 100644
--- a/sound/aoa/Kconfig
+++ b/sound/aoa/Kconfig
@@ -1,5 +1,5 @@
 menu "Apple Onboard Audio driver"
-	depends on SND!=n && PPC
+	depends on SND!=n && PPC_PMAC
 
 config SND_AOA
 	tristate "Apple Onboard Audio driver"
-- 
1.4.2.GIT
