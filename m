Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbUKOGuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUKOGuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUKOGsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:48:30 -0500
Received: from havoc.gtf.org ([69.28.190.101]:44505 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261533AbUKOGqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:46:45 -0500
Date: Mon, 15 Nov 2004 01:46:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [netdrvr] netdev-2.4 queue updated
Message-ID: <20041115064644.GA14578@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(this is waiting for the next Marcelo release, before going upstream)

BK users:

	bk pull bk://gkernel.bkbits.net/netdev-2.4

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.28-rc3-netdev1.patch.bz2

This will update the following files:

 Documentation/Configure.help                  |   84 --
 Documentation/networking/dl2k.txt             |   44 -
 Documentation/networking/e1000.txt            |  216 +++--
 drivers/net/3c59x.c                           |  500 ++++++++----
 drivers/net/dl2k.c                            |  309 +++++--
 drivers/net/dl2k.h                            |   19 
 drivers/net/e1000/e1000_ethtool.c             |    6 
 drivers/net/e1000/e1000_hw.c                  |   25 
 drivers/net/e1000/e1000_main.c                |    2 
 drivers/net/e1000/e1000_param.c               |    2 
 drivers/net/forcedeth.c                       | 1020 ++++++++++++++++++--------
 drivers/net/wireless/prism54/isl_38xx.c       |   12 
 drivers/net/wireless/prism54/isl_38xx.h       |   14 
 drivers/net/wireless/prism54/isl_ioctl.c      |   24 
 drivers/net/wireless/prism54/islpci_dev.c     |    8 
 drivers/net/wireless/prism54/islpci_dev.h     |    2 
 drivers/net/wireless/prism54/islpci_hotplug.c |    2 
 drivers/net/wireless/prism54/prismcompat.h    |    4 
 drivers/net/wireless/prism54/prismcompat24.h  |    4 
 include/linux/mii.h                           |    7 
 include/linux/pci_ids.h                       |   11 
 21 files changed, 1524 insertions(+), 791 deletions(-)

through these ChangeSets:

<edward_peng:alphanetworks.com>:
  o dl2k: correct author's email

Ganesh Venkatesan:
  o e1000: Update to Configure.help
  o e100: Update to Configure.help
  o e1000: white space corrections
  o e1000: driver version update
  o e1000: fix set ringparam for ethtool returning error
  o e1000: remove unused function e1000_enable_mng_pass_thru
  o e1000: fix set_pauseparam for fiber serdes link
  o e1000: Update Documentation/networking/e1000.txt

Jeff Garzik:
  o [netdrvr dl2k] remove unused constant 'CFI'
  o [netdrvr dl2k] new TX scheme, fix minor bug

John W. Linville:
  o 3c59x: resync with 2.6

Manfred Spraul:
  o Backport of the 0.30 forcedeth driver to 2.4. It's a new backport, starting from the 2.6 tree.

Margit Schubert-While:
  o prism54 sparse fixes
  o prism54 fix resume processing
  o prism54 sync with 2.6

