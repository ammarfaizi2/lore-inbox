Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWBJK0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWBJK0p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWBJK0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:26:45 -0500
Received: from mail11.bluewin.ch ([195.186.18.61]:51436 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S1751223AbWBJK0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:26:44 -0500
Cc: Arthur Othieno <apgo@patchbomb.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] block: floppy98 removal, really.
In-Reply-To: <11395671853420-git-send-email-apgo@patchbomb.org>
X-Mailer: git-send-email
Date: Fri, 10 Feb 2006 05:26:25 -0500
Message-Id: <1139567185365-git-send-email-apgo@patchbomb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Arthur Othieno <apgo@patchbomb.org>
To: apgo@patchbomb.org
Content-Transfer-Encoding: 7BIT
From: Arthur Othieno <apgo@patchbomb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

floppy98 went out together with the rest of PC98 subarch.
Remove stale Makefile entry that remained.

Signed-off-by: Arthur Othieno <apgo@patchbomb.org>

---

 drivers/block/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

80a4684b196db130039c8cd471f9dc10416da7db
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 3ec1f8d..410f259 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -7,7 +7,6 @@
 
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
-obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
 obj-$(CONFIG_AMIGA_FLOPPY)	+= amiflop.o
 obj-$(CONFIG_ATARI_FLOPPY)	+= ataflop.o
 obj-$(CONFIG_BLK_DEV_SWIM_IOP)	+= swim_iop.o
-- 
1.1.5


