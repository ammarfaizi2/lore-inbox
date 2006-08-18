Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHRMHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHRMHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWHRMHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:07:36 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43459 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932432AbWHRMHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:07:35 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Date: Fri, 18 Aug 2006 13:28:04 +0200
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
Message-Id: <200608181328.04607.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is the latest version of the IBM eHEA Ethernet Device Driver.
The main difference to the previous version is the rework of the debug
mechanism. 
We highly appreciate further comments.

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set: http://www.spinics.net/lists/netdev/msg11593.html

Changelog:

- Logging rework (EDEB macros removed, netif_msg_X mechansim used)


 drivers/net/Kconfig             |    6 
 drivers/net/Makefile            |    1 
 drivers/net/ehea/Makefile       |    7 
 drivers/net/ehea/ehea.h         |  442 +++++++
 drivers/net/ehea/ehea_ethtool.c |  264 ++++
 drivers/net/ehea/ehea_hcall.h   |   51 
 drivers/net/ehea/ehea_hw.h      |  292 ++++
 drivers/net/ehea/ehea_main.c    | 2480 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/ehea/ehea_phyp.c    |  884 ++++++++++++++
 drivers/net/ehea/ehea_phyp.h    |  523 ++++++++
 drivers/net/ehea/ehea_qmr.c     |  643 ++++++++++
 drivers/net/ehea/ehea_qmr.h     |  367 +++++
 12 files changed, 5960 insertions(+)



