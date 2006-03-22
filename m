Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWCVPWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWCVPWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCVPWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:22:25 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56964 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751307AbWCVPVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:21:55 -0500
Date: Wed, 22 Mar 2006 16:22:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, peter.oberparleiter@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 14/24] s390: remove experimental flag from dasd diag.
Message-ID: <20060322152221.GN5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[patch 14/24] s390: remove experimental flag from dasd diag.

The dasd diag discipline has been tested on 64 bit and is no longer
experimental.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/Kconfig linux-2.6-patched/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	2006-03-22 14:36:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/Kconfig	2006-03-22 14:36:25.000000000 +0100
@@ -49,7 +49,7 @@ config DASD_FBA
 
 config DASD_DIAG
 	tristate "Support for DIAG access to Disks"
-	depends on DASD && ( 64BIT = 'n' || EXPERIMENTAL)
+	depends on DASD
 	help
 	  Select this option if you want to use Diagnose250 command to access
 	  Disks under VM.  If you are not running under VM or unsure what it is,
