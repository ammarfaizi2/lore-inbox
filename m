Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbSKUTrL>; Thu, 21 Nov 2002 14:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSKUTrL>; Thu, 21 Nov 2002 14:47:11 -0500
Received: from cuc.ucc.ie ([143.239.211.116]:30621 "EHLO cuc.ucc.ie")
	by vger.kernel.org with ESMTP id <S266991AbSKUTrK>;
	Thu, 21 Nov 2002 14:47:10 -0500
Date: Thu, 21 Nov 2002 19:54:17 +0000
From: Neil Cafferkey <caffer@cs.ucc.ie>
To: linux-kernel@vger.kernel.org
Subject: Setting MAC address in ewrk3 driver
Message-ID: <20021121195417.A18859@cuc.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I may have found a bug in the ewrk3 network driver. When I try to
change the MAC address of a Digital DE205 NIC using "ifconfig eth0 hw
ether XX:XX:XX:XX:XX:XX", it appears to work ("ifconfig eth0" reports the
new address), but in fact it isn't sending or receiving packets any more.
I'm using kernel version 2.4.10.

I've tried this with the same result in two machines using different DE205
cards. I have changed the MAC address of other types of NICs without
problems, so I don't think it's something silly like an ARP problem.

I tried to report this to the driver author, David Davies, but the address 
given in the driver bounced. Please CC any responses to me, since I'm not 
subscribed to the list.

Regards,
Neil Cafferkey
