Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVARJlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVARJlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 04:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVARJlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 04:41:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30725 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261207AbVARJjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 04:39:54 -0500
Date: Tue, 18 Jan 2005 10:39:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/umem.c: make two functions static
Message-ID: <20050118093952.GA4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

diffstat output:
 drivers/block/umem.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

This patch was already sent on:
- 29 Nov 2004

--- linux-2.6.10-rc1-mm3-full/drivers/block/umem.c.old	2004-11-06 20:19:51.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/block/umem.c	2004-11-06 20:20:16.000000000 +0100
@@ -1181,7 +1181,7 @@
 -----------------------------------------------------------------------------------
 */
 
-int __init mm_init(void)
+static int __init mm_init(void)
 {
 	int retval, i;
 	int err;
@@ -1232,7 +1232,7 @@
 --                             mm_cleanup
 -----------------------------------------------------------------------------------
 */
-void __exit mm_cleanup(void)
+static void __exit mm_cleanup(void)
 {
 	int i;
 

