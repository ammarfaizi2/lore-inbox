Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVCEQWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVCEQWS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCEQO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:14:58 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:62132 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262117AbVCEQGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:06:13 -0500
Date: Sat, 05 Mar 2005 11:06:11 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: PATCH-remove experimental depends from forcedeth
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503051106.11678.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've not seen a forcedeth mention go by on this list for quite some
time unless I made it.  It has been quite bulletproof here so I don't 
feel the need for it to remain dependent on the experimental status in 
the main .config.

Hence this patch to remove that requirement from the appropriate 
Kconfig.

Signed-off-by Gene Heskett <gene.heskett@verizon.net>

/usr/src/linux-2.6.11/drivers/net/Kconfig | 2+-
 one file changed, 2 deletions, 2 insertions

--- drivers/net/Kconfig.old 2005-03-05 10:43:45.000000000 -0500
+++ drivers/net/Kconfig 2005-03-05 11:01:01.000000000 -0500
@@ -1342,8 +1342,8 @@ config B44
    called b44.
 
 config FORCEDETH
- tristate "Reverse Engineered nForce Ethernet support (EXPERIMENTAL)"
- depends on NET_PCI && PCI && EXPERIMENTAL
+ tristate "Reverse Engineered nForce Ethernet support"
+ depends on NET_PCI && PCI
  help
    If you have a network (Ethernet) controller of this type, say Y and
    read the Ethernet-HOWTO, available from

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
