Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRADLcP>; Thu, 4 Jan 2001 06:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRADLcF>; Thu, 4 Jan 2001 06:32:05 -0500
Received: from gidayu.max.uni-duisburg.de ([134.91.242.4]:54031 "HELO
	gidayu.max.uni-duisburg.de") by vger.kernel.org with SMTP
	id <S129413AbRADLby>; Thu, 4 Jan 2001 06:31:54 -0500
Date: Thu, 4 Jan 2001 12:31:39 +0100
From: Christian Loth <chris@gidayu.max.uni-duisburg.de>
To: linux-kernel@vger.kernel.org
Subject: DHCP Problems with 3com 3c905C Tornado
Message-ID: <20010104123139.A15097@gidayu.max.uni-duisburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

  I recently installed a system with the 3c905C
NIC on RedHat 6.2. In our network, IP adresses
are granted via DHCP, although every host has
a fixed IP instead of a dynamic IP pool. The IP
is statically coupled with the MAC adresses of
our network.

  The freshly installed RedHat 6.2 worked nice
and flawlessly, and the IP was handed out correctly
to the new machine. However after upgrading
to the 2.2.16 RedHat Kernel RPMS, the DHCP negotiation
no longer worked! Okay, I said, maybe it is a RedHat
thing (they included modules both for the 90x and for the 59x
cards, and I tried both), so I downloaded 2.2.18 proper.
I compiled in the support for the card, but also: same
result. The old 2.2.14 RedHat kernel worked, but the
newer kernels did not.

  Unfortunately the machine had to go on the net, so I had
to switch the NIC for a DEC Tulip one, which worked flawlessly
under 2.2.18 again. Therfore I unfortunately can't volunteer
for testing :(, all I can say is that something happened
between 2.2.14 and 2.2.16/2.2.18 which made DHCP inoperable
for the 3c905C.

Please CC any replies to my email adress, as I am not subscribed
to linux-kernel.

- Chris

-- 
Christian Loth
Coder of 'Project Gidayu'
Computer Science Student, University of Dortmund
chris@gidayu.mud.de - http://gidayu.mud.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
