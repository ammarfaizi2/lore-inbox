Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWIFOUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIFOUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWIFOUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:20:33 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:34405 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751147AbWIFOUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:20:30 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 6/7] ehea: eHEA Makefile
Date: Wed, 6 Sep 2006 15:38:05 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200609061538.05537.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/Makefile |    6 ++++++
 1 file changed, 6 insertions(+)



--- linux-2.6.18-rc6-orig/drivers/net/ehea/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ kernel/drivers/net/ehea/Makefile	2006-09-06 15:53:43.000000000 +0200
@@ -0,0 +1,6 @@
+#
+# Makefile for the eHEA ethernet device driver for IBM eServer System p
+#
+ehea-y = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o ehea_phyp.o
+obj-$(CONFIG_EHEA) += ehea.o
+
