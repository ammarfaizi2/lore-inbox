Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVBHGSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVBHGSC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 01:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBHGSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 01:18:02 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:56990 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S261489AbVBHGRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 01:17:55 -0500
Message-ID: <4208599C.9020904@xmission.com>
Date: Mon, 07 Feb 2005 23:18:04 -0700
From: maxer <maxer@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050109 Fedora/1.7.5-3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: skge driver from Stephen H. doesn't support the following SysKonnect
 sk98lin supported on board lan
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 166.70.55.125
X-SA-Exim-Mail-From: maxer@xmission.com
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mgr1.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The description in kernel 2.6.11-rc3-mm1 make for the skge driver states 
the following:
 
"*New SysKonnect GigaEthernet support (EXPERIMENTAL) (SKGE)

This driver support the Marvell Yukon or SysKonnect SK-98xx/SK-95xx
and related Gigabit Ethernet adapters. It is a new smaller driver
driver with better performance and more complete ethtool support.

It does not support the link failover and network management
features that "portable" vendor supplied sk98lin driver does.* "

What makes my PCI Express mobo with on board 04:00.0 Ethernet 
controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller 
(rev 17)
*not *supported by skge driver is that it is a  NEW generation  driver  
Marvell Yukon  2.

I have SysKonnect's sk98lin driver working for me under a custom built 
2.6.9 kernel using SysKonnect's driver version 7.09 patched in the kernel.

The motherboard I'm using is a new Intel D915GEV. The specs on the lan 
show as:

Gigabit (10/100/1000 Mbits/sec) LAN subsystem using the Marvel* Yukon* 
88E8050 PCI Express* Gigabit Ethernet Controller.

Don't try this Stephen's skge driver with this, it isn't supported.

RaXeT
