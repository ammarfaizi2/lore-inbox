Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbUDZLfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUDZLfo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 07:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264495AbUDZLfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 07:35:44 -0400
Received: from host16.apollohosting.com ([209.239.37.142]:46475 "EHLO
	host16.apollohosting.com") by vger.kernel.org with ESMTP
	id S263171AbUDZLfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 07:35:37 -0400
Date: Mon, 26 Apr 2004 13:35:27 +0200
To: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: 8139too not working in 2.6
From: "Mirko Caserta" <mirko@mcaserta.com>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr62ahdvlpsnffn@mail.mcaserta.com>
User-Agent: Opera M2/7.50 (Linux, build 663)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I know, it's a damn cheap eth card and I should get it replaced :)

Besides that, this card works just fine with 2.4.25 while it refuses to  
work on a recent 2.6 kernel. I tried 2.6.5 and even  
2.6.5-rc2-mm2-broken-out with no luck.

The card is correctly recognized but the kernel refuses to transmit any  
packet:

8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xe0821000, MAC_ADDR_REMOVED, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: Transmit timeout, status 0c 0005 c07f media 10.
eth0: Tx queue start entry 4  dirty entry 0.
eth0:  Tx descriptor 0 is 0008a03c. (queue head)
eth0:  Tx descriptor 1 is 0008a03c.
eth0:  Tx descriptor 2 is 0008a03c.
eth0:  Tx descriptor 3 is 0008a03c.

Someone told me to play around with the driver options but the machine is  
in production and I cannot play much with reboots :/

Any help would be very appreciated.

Mirko

