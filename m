Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbUL1IcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUL1IcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1IcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:32:25 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6117 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261777AbUL1I3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:29:31 -0500
Date: Tue, 28 Dec 2004 09:27:55 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] s390: DCSS driver cleanup fix
Message-ID: <20041228082755.GG7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 6/8] s390: dcss driver.

From: Carsten Otte <cotte@de.ibm.com>

 - Fix codingstyle.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 arch/s390/mm/extmem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2004-12-28 08:50:51.000000000 +0100
@@ -545,7 +545,8 @@
 /*
  * save segment content permanently
  */
-void segment_save(char *name)
+void
+segment_save(char *name)
 {
 	struct dcss_segment *seg;
 	int startpfn = 0;
