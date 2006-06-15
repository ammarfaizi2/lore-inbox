Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWFOLXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWFOLXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWFOLXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:23:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52189 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030221AbWFOLXa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:23:30 -0400
Date: Thu, 15 Jun 2006 12:23:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] m68k: windfarm is powerpc-only, don't do it on m68k macs
Message-ID: <20060615112329.GL27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/macintosh/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

c3d6ecc77e8e5d4ac82c3bf27ed02b8c0d83d41d
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 12ad462..ccf5df4 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -171,6 +171,7 @@ config THERM_PM72
 
 config WINDFARM
 	tristate "New PowerMac thermal control infrastructure"
+	depends on PPC
 
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"
-- 
1.3.GIT

