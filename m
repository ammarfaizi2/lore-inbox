Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271203AbTHCPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 11:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271204AbTHCPa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 11:30:26 -0400
Received: from desa.unpunk.com ([38.118.140.57]:43738 "EHLO desa.unpunk.com")
	by vger.kernel.org with ESMTP id S271203AbTHCPaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 11:30:25 -0400
Date: Sun, 3 Aug 2003 08:30:24 -0700
To: linux-kernel@vger.kernel.org
Subject: unknown ethernet device
Message-ID: <20030803153024.GA3602@unpunk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: floyd@unpunk.com (Matt Mercer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I discovered an unknown onboard ethernet device recently. I'm
thinking it is either an e100. Adding the ID to the
list in the e100 driver and the nic seems to work fine. 

Anyone know anything about this device, should it be added
to the e100 driver?

lspci -s00:04.0 -xxx
00:04.0 Ethernet controller: Intel Corp.: Unknown device 0105 (rev 0d)
00: 86 80 05 01 17 01 90 02 0d 00 00 02 10 40 80 00
10: 00 d0 7f fe 01 af 00 00 00 00 7a fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 11 10
30: 00 00 7e fe dc 00 00 00 00 00 00 00 09 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
e0: 00 40 00 4b 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-Matt

