Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265398AbRF2CQs>; Thu, 28 Jun 2001 22:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRF2CQ3>; Thu, 28 Jun 2001 22:16:29 -0400
Received: from hacksaw.org ([216.41.5.170]:6879 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S265398AbRF2CQR>; Thu, 28 Jun 2001 22:16:17 -0400
Message-Id: <200106290216.f5T2GEE16780@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: "J . A . Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Fri, 29 Jun 2001 00:04:42 +0200."
             <20010629000442.A4544@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 22:16:14 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given that seeing as much as possible on a potentially small screen would be 
good, maybe tighter would be nice. In example:

kswapd:    v1.8
pty        Devices: 256 Unix98 ptys configured
serial:    v5.05b (2001-05-03) with 
           Options: MANY_PORTS SHARE_IRQ SERIAL_PCI
           Devices: ttyS00 at 0x03f8 (irq = 4) is a 16550A
                    ttyS01 at 0x02f8 (irq = 3) is a 16550A
rtclock:   v1.10d
ide:       v6.31
net:       v4.0 for Linux 2.2, from Swansea University Computer Society 
NET3.039
           Unix domain sockets 1.0 for NET4.0.
           TCP/IP 1.0 for NET4.0
           IP Protocols: ICMP, UDP, TCP, IGMP
           TCP: Hash tables configured (ehash 524288 bhash 65536)
           IPv4 over IPv4 tunneling driver
           early initialization of device tunl0 is deferred
           AppleTalk 0.18 for NET4.0


My hope would be that the name at the extreme left column would be the name of 
the module that would be loaded if it were a module, and the name of the main 
code file of the driver in question. That way, those trying to debug stuff 
could go right to the appropriate file, and start reading the code or nearby 
documentation.

Of course, the spacing I have above is optimistic, but just making sure that a 
new driver prints it's version line against the left margin, and everything 
else a few spaces out would help readability.

You might note that I eliminated the word Linux in 5 or 6 places. We know the 
driver works with Linux if it is booting. On the other hand "vX.X for Linux 
2.X" is useful, since it's part of the version number.

Your opinion may vary.

