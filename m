Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWBHDSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWBHDSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWBHDSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:18:42 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:55936 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751136AbWBHDSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:14 -0500
To: torvalds@osdl.org
Subject: [PATCH 04/29] missing includes in drivers/net/mv643xx_eth.c
Cc: linux-kernel@vger.kernel.org, dale@farnsworth.org, jgarzik@pobox.com
Message-Id: <E1F6fqN-0006Ba-W6@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1137630954 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/net/mv643xx_eth.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

b6298c22c5e9f698812e2520003ee178aad50c10
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index 7ef4b04..c0998ef 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -32,6 +32,8 @@
  */
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
+#include <linux/in.h>
+#include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/etherdevice.h>
-- 
0.99.9.GIT

