Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319035AbSIJBMh>; Mon, 9 Sep 2002 21:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319065AbSIJBMg>; Mon, 9 Sep 2002 21:12:36 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:48257 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S319035AbSIJBMg>; Mon, 9 Sep 2002 21:12:36 -0400
Subject: Wake-on-LAN/PCI Linux support
From: Felipe Alfaro Solana <falfaro@borak.es>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Sep 2002 03:17:13 +0200
Message-Id: <1031620633.1324.34.camel@teapot>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Does Linux currently support Wake-on-LAN/PCI? I have a 3Com 3c905 TX-M
NIC which supports wake-on-LAN and wake-on-PCI. On Windows XP, I have
configured the system so that I can use "ether-wake" to wake up my
system from standby/hibernation remotely through the network.

This even works when I shutdown the machine from Windows XP. It seems
that shutting down from Windows XP does not totally disable power from
the computer. I think the computer must be in a deep standby mode cause
the NIC is working and listening on the network. In fact, when shutting
down XP, the switch port for my NIC card shows the card is listening. If
I use "ether-wake", the computer powers up and starts booting up.

However, when I shut down linux by using "init 0", the system gets
totally shut down, including the NIC. The switch port for the NIC shows
the card is not mantaining the link and thus, "ether-wake" is totally
useless.

I would like to see similar support on Linux.

Sincerely,

   Felipe Alfaro

