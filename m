Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGKsC>; Wed, 7 Feb 2001 05:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGKrx>; Wed, 7 Feb 2001 05:47:53 -0500
Received: from [213.61.176.26] ([213.61.176.26]:56570 "EHLO
	pollux.server.x-cellent.com") by vger.kernel.org with ESMTP
	id <S129028AbRBGKrh>; Wed, 7 Feb 2001 05:47:37 -0500
Message-ID: <3A812800.CCDAA7ED@x-cellent.com>
Date: Wed, 07 Feb 2001 11:48:32 +0100
From: Stefan Majer <stefan@x-cellent.com>
Organization: x-cellent technologies GmbH
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 and Adaptec Duralan aka Starfire.c 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

I installed a Adaptec Quad Port Ethernet Adapter called Quartet64 and
after compiling 2.4.1
with starfire support i got the following  messages in syslog 

after 

ifconfig eth2 172.17.1.4 netmask 255.255.0.0 up

Feb  7 11:37:29 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 242749457 vs. ce781000 / ce781010.
Feb  7 11:38:25 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 240822289 vs. ce5aa800 / ce5aa810.
Feb  7 11:38:35 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 240820241 vs. ce5aa000 / ce5aa010.
Feb  7 11:38:39 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 237467665 vs. ce277800 / ce277810.
Feb  7 11:38:47 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 237465617 vs. ce277000 / ce277010.
Feb  7 11:39:25 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 238573585 vs. ce385800 / ce385810.
Feb  7 11:39:27 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 238571537 vs. ce385000 / ce385010.
Feb  7 11:39:27 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 233326609 vs. cde84800 / cde84810.
Feb  7 11:39:28 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 233324561 vs. cde84000 / cde84010.
Feb  7 11:39:29 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 235980817 vs. ce10c800 / ce10c810.
Feb  7 11:40:00 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 235978769 vs. ce10c000 / ce10c010.
Feb  7 11:40:24 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 234903569 vs. ce005800 / ce005810.
Feb  7 11:40:25 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 234901521 vs. ce005000 / ce005010.
Feb  7 11:40:35 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 234897425 vs. ce004000 / ce004010.
Feb  7 11:41:25 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 234899473 vs. ce004800 / ce004810.
Feb  7 11:41:28 cerro kernel: eth2: Internal fault: The skbuff addresses
do not match in netdev_rx: 234237969 vs. cdf63000 / cdf63010.
......


and so on

beside this messages everything is working as far as i can see but im a
bit afraid going in production with
this machine..


so please give me some hints


stefan majer
x-cellent technologies gmbh
rosenkavalierplatz 5
81925 munich 
germany
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
