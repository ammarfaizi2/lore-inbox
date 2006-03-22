Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWCVPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWCVPRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCVPRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:17:21 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:63195 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751299AbWCVPRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:17:19 -0500
Date: Wed, 22 Mar 2006 16:17:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/24] s390: connector support.
Message-ID: <20060322151746.GH5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 8/24] s390: connector support.

Include connector config in the s390 arch Kconfig to get support
for connectors.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2006-03-22 14:36:16.000000000 +0100
@@ -460,6 +460,8 @@ config PCMCIA
 
 source "drivers/base/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "drivers/scsi/Kconfig"
 
 source "drivers/s390/Kconfig"
