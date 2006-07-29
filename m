Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWG2Tmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWG2Tmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWG2Tmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:42:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:19415 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752076AbWG2Tmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:42:36 -0400
Date: Sat, 29 Jul 2006 21:42:34 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.18] [1/8] x86_64: Update defconfig
Message-ID: <44cbba2a.Uo232FiIZzQNdHEO%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update defconfig

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/defconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/defconfig
===================================================================
--- linux.orig/arch/x86_64/defconfig
+++ linux/arch/x86_64/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-git22
-# Tue Jul  4 14:24:40 2006
+# Linux kernel version: 2.6.18-rc2
+# Tue Jul 18 17:13:20 2006
 #
 CONFIG_X86_64=y
 CONFIG_64BIT=y
@@ -37,6 +37,7 @@ CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
@@ -413,6 +414,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -1195,7 +1197,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
-# CONFIG_USB_CY7C63 is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_PHIDGETKIT is not set
 # CONFIG_USB_PHIDGETSERVO is not set
@@ -1373,7 +1375,6 @@ CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
-# CONFIG_CIFS_DEBUG2 is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
