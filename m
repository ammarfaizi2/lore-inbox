Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWIWMHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWIWMHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 08:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIWMHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 08:07:09 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:14780 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1750768AbWIWMHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 08:07:07 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAJm/FEWLcAIN
X-IronPort-AV: i="4.09,207,1157320800"; 
   d="scan'208"; a="3398928:sNHT31147216"
Date: Sat, 23 Sep 2006 14:07:04 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Patrick McHardy <kaber@trash.net>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
Message-ID: <20060923120704.GA32284@zlug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the resubmit of the Ethernet over IPv4 tunnel driver
for Linux.  I want to thank all reviewers for their annotations and
helpfull input.  This version contains some major changes to the driver.
It uses an own device type now (ARPHRD_ETHERIP). This fixes the problem
that EtherIP devices could not be safely differenced from Ethernet
devices. This change also required some other changes. First a second
patch to the bridge code is included to allow the use of EtherIP devices
in a bridge.  The third patch includes the necessary changes to iproute2
(support of the new ARPHRD and general tunnel configuration support for
 EtherIP).

Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>
