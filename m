Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751542AbWHNQbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbWHNQbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWHNQbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:31:34 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:12249 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751542AbWHNQbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:31:32 -0400
Message-ID: <44E0A562.7040106@de.ibm.com>
Date: Mon, 14 Aug 2006 18:31:30 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: netdev <netdev@vger.kernel.org>
CC: linux-ppc <linuxppc-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: [PATCH 6/7] ehea: eHEA Makefile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>


  drivers/net/ehea/Makefile |    7 +++++++
  1 file changed, 7 insertions(+)



--- linux-2.6.18-rc4-orig/drivers/net/ehea/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ kernel/drivers/net/ehea/Makefile	2006-08-14 09:05:11.734271473 -0700
@@ -0,0 +1,7 @@
+#
+# Makefile for the eHEA ethernet device driver for IBM eServer System p
+#
+
+ehea-y = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o ehea_phyp.o
+obj-$(CONFIG_EHEA) += ehea.o
+


