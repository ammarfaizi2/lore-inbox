Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936924AbWLDOuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936924AbWLDOuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936930AbWLDOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:50:23 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:55871 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S936924AbWLDOuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:50:21 -0500
Date: Mon, 4 Dec 2006 15:50:08 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Remove unused GENERIC_BUST_SPINLOCK from Kconfig.
Message-ID: <20061204145008.GC32059@skybase>
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
--- linux-2.6/arch/s390/Kconfig	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2006-12-04 14:50:31.000000000 +0100
@@ -33,9 +33,6 @@ config GENERIC_CALIBRATE_DELAY
 config GENERIC_TIME
 	def_bool y
 
-config GENERIC_BUST_SPINLOCK
-	bool
-
 mainmenu "Linux Kernel Configuration"
 
 config S390
