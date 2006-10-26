Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752127AbWJZJEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbWJZJEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWJZJEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:04:39 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:57000 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422809AbWJZJEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:04:23 -0400
Date: Thu, 26 Oct 2006 11:04:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Remove unused GENERIC_BUST_SPINLOCK from Kconfig.
Message-ID: <20061026090420.GH16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Remove unused GENERIC_BUST_SPINLOCK from Kconfig.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    3 ---
 1 files changed, 3 deletions(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-10-26 10:43:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-10-26 10:44:09.000000000 +0200
@@ -33,9 +33,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_TIME
 	def_bool y
 
-config GENERIC_BUST_SPINLOCK
-	bool
-
 mainmenu "Linux Kernel Configuration"
 
 config S390
