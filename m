Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWIFOLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWIFOLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWIFOLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:11:33 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:37573 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751095AbWIFOLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:11:31 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [2.6.19 PATCH 0/7] ehea: IBM eHEA Ethernet Device Driver
Date: Wed, 6 Sep 2006 15:29:05 +0200
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
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200609061529.05632.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the latest version of the IBM eHEA Ethernet Device Driver.
We integrated the comment we got from Francois Romieu.

Thanks,
Jan-Bernd

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com> 
Changelog-by:  Jan-Bernd Themann <themann@de.ibm.com>

Differences to patch set http://www.spinics.net/lists/netdev/msg13972.html

Changelog:
- replace dev_alloc_skb by netdev_alloc_skb
- goto target naming rework
- minor coding style issues


 drivers/net/Kconfig             |    9 
 drivers/net/Makefile            |    1 
 drivers/net/ehea/Makefile       |    6 
 drivers/net/ehea/ehea.h         |  443 ++++++
 drivers/net/ehea/ehea_ethtool.c |  294 ++++
 drivers/net/ehea/ehea_hcall.h   |   51 
 drivers/net/ehea/ehea_hw.h      |  290 ++++
 drivers/net/ehea/ehea_main.c    | 2686 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/ehea/ehea_phyp.c    |  705 ++++++++++
 drivers/net/ehea/ehea_phyp.h    |  454 ++++++
 drivers/net/ehea/ehea_qmr.c     |  604 ++++++++
 drivers/net/ehea/ehea_qmr.h     |  362 +++++
 12 files changed, 5905 insertions(+)

