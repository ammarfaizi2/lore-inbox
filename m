Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbRGWTrR>; Mon, 23 Jul 2001 15:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267917AbRGWTrH>; Mon, 23 Jul 2001 15:47:07 -0400
Received: from csa.iisc.ernet.in ([144.16.67.8]:25617 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S267525AbRGWTqs>;
	Mon, 23 Jul 2001 15:46:48 -0400
Date: Tue, 24 Jul 2001 01:16:32 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Arp problem 
Message-ID: <Pine.SOL.3.96.1010724011120.10879A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,
	I have a machine with multiple network cards with different IP
addresses assigned. All are in the same network (I need this for
whatever reason). But when a arp request
appears on the wire for any of these IP addresses, all the interfaces go
ahead and give their respective ethernet addresses against that IP
address (I have seen this with tcpdump). This causes the other machines to
pick up wrong ethernet address against the IP address. 

	Anybody having any idea why such a thing might happen. All cards
are with DEC 21140 chip. I am using RH6.2 with kernel version 2.2.14-5.0.

	I am ready to give more info on the configuration etc (ifconfig
dump, routing table etc.).

TIA
sourav
--------------------------------------------------------------------------------


