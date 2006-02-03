Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945943AbWBCUX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945943AbWBCUX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBCUX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:23:28 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:46252 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751302AbWBCUX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:23:27 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: [PATCH 3/5] Let CDROM_PKTCDVD_WCACHE depend on EXPERIMENTAL
References: <m3bqxoci5g.fsf@telia.com> <m37j8cci2r.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:19:32 +0100
In-Reply-To: <m37j8cci2r.fsf@telia.com>
Message-ID: <m33bj0ci0b.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Unless the help text is outdated, this seems to be logical.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 139cbba..db6818f 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -437,8 +437,8 @@ config CDROM_PKTCDVD_BUFFERS
 	  pktsetup time.
 
 config CDROM_PKTCDVD_WCACHE
-	bool "Enable write caching"
-	depends on CDROM_PKTCDVD
+	bool "Enable write caching (EXPERIMENTAL)"
+	depends on CDROM_PKTCDVD && EXPERIMENTAL
 	help
 	  If enabled, write caching will be set for the CD-R/W device. For now
 	  this option is dangerous unless the CD-RW media is known good, as we

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
