Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWAEPr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWAEPr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWAEPr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:47:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:60381 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751430AbWAEPrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:47:55 -0500
Date: Thu, 5 Jan 2006 09:41:59 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <afleming@freescale.com>
Subject: [PATCH] gfar: fix compile error
Message-ID: <Pine.LNX.4.44.0601050941160.31237-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing include of <linux/in.h> to get definition of IPPROTO_UDP.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 1a6720f78a7fb69451983e6b73723b57594ecac1
tree c8772f20a27fd82d28e78c342782297afb35c580
parent 7b5d230825fc228414dce7dc2bfdace4ecea4613
author Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:45:05 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 05 Jan 2006 09:45:05 -0600

 drivers/net/gianfar.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 146f951..637b73a 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -84,6 +84,7 @@
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
+#include <linux/in.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>

