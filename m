Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbVCQPCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbVCQPCI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbVCQO7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:59:50 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:59084 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263087AbVCQO6d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:58:33 -0500
Date: Thu, 17 Mar 2005 15:58:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/8] s390: oprofile support.
Message-ID: <20050317145843.GH4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/8] s390: oprofile support.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Remove experimental tag from the s390 oprofile support.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/oprofile/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -urN linux-2.6/arch/s390/oprofile/Kconfig linux-2.6-patched/arch/s390/oprofile/Kconfig
--- linux-2.6/arch/s390/oprofile/Kconfig	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6-patched/arch/s390/oprofile/Kconfig	2005-03-17 15:38:06.000000000 +0100
@@ -1,16 +1,15 @@
 
 menu "Profiling support"
-	depends on EXPERIMENTAL
 
 config PROFILING
-	bool "Profiling support (EXPERIMENTAL)"
+	bool "Profiling support"
 	help
 	  Say Y here to enable profiling support mechanisms used by
 	  profilers such as readprofile or OProfile.
 
 
 config OPROFILE
-	tristate "OProfile system profiling (EXPERIMENTAL)"
+	tristate "OProfile system profiling"
 	depends on PROFILING
 	help
 	  OProfile is a profiling system capable of profiling the
