Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWHRMPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWHRMPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWHRMPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:15:40 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:14960 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030340AbWHRMPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:15:39 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 6/7] ehea: eHEA Makefile
Date: Fri, 18 Aug 2006 13:36:08 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Disposition: inline
To: netdev <netdev@vger.kernel.org>
Cc: Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608181336.08808.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 


 drivers/net/ehea/Makefile |    7 +++++++
 1 file changed, 7 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/Makefile	2006-08-18 00:01:00.755974823 -0700
@@ -0,0 +1,7 @@
+#
+# Makefile for the eHEA ethernet device driver for IBM eServer System p
+#
+
+ehea-y = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o ehea_phyp.o
+obj-$(CONFIG_EHEA) += ehea.o
+
