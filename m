Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbTCUAS7>; Thu, 20 Mar 2003 19:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263345AbTCUAS7>; Thu, 20 Mar 2003 19:18:59 -0500
Received: from fmr01.intel.com ([192.55.52.18]:32221 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S263343AbTCUAS4>;
	Thu, 20 Mar 2003 19:18:56 -0500
Date: Thu, 20 Mar 2003 17:13:23 +0200 (IST)
From: Shmulik Hen <hshmulik@intel.com>
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
To: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [Bonding][patch set] - Adding IEEE 802.3ad Dynamic link aggregation
 support
Message-ID: <Pine.LNX.4.44.0303201534360.10351-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following set of 7(+2) patches add support for 802.3ad link
aggregation mode on top of the latest release of bonding from source-forge 
(2.4.20-20030317). They also handle a set of bug fixes that were
discovered during the past several weeks of an extensive testing effort
done by our QA group. This comes as one of several enhancements Intel has
decided to contribute to the open source community. This code is ported
from our iANS product which has been around for some time. We are in the
process of porting our advanced networking features from iANS to the
bonding driver. In future releases we plan to add more features,
improvements and adapting the code for 2.5.x kernels.

The first 2 patches add support for point-to-point protocols to the
2.4.20/2.4.21-pre5 kernels in the net subtree, and are a pre-requisite for
the 802.3ad feature. The following patches only modify the bonding files.

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |
|                                                |
| Anti-Spam: shmulik dot hen at intel dot com    |







