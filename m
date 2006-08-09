Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWHIIkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWHIIkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWHIIkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:40:42 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:18771 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030484AbWHIIkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:40:22 -0400
Message-ID: <44D99F74.1000704@de.ibm.com>
Date: Wed, 09 Aug 2006 10:40:20 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 5/6] ehea: makefile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/ehea/Makefile |    7 +++++++
  1 file changed, 7 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/Makefile	2006-08-08 23:59:38.083467216 -0700
@@ -0,0 +1,7 @@
+#
+# Makefile for the eHEA ethernet device driver for IBM eServer System p
+#
+
+ehea_mod-objs = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o ehea_phyp.o
+obj-$(CONFIG_EHEA) += ehea_mod.o
+


