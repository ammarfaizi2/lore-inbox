Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130407AbRCEUKx>; Mon, 5 Mar 2001 15:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130408AbRCEUKn>; Mon, 5 Mar 2001 15:10:43 -0500
Received: from relay2.inwind.it ([212.141.53.73]:63397 "EHLO relay2.inwind.it")
	by vger.kernel.org with ESMTP id <S130407AbRCEUKa>;
	Mon, 5 Mar 2001 15:10:30 -0500
Date: Mon, 5 Mar 2001 21:11:04 +0100
From: Gianluca Anzolin <g.anzolin@inwind.it>
To: linux-kernel@vger.kernel.org
Cc: becker@webserv.gsfc.nasa.gov
Subject: NE2000 problem
Message-ID: <20010305211104.A383@fourier.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I'm experiencing a problem with an old NE2000 card. I use the ne.c 
driver provided with 2.4.x kernels. (I'm using 2.4.2-ac11)

	The problem is that I can ping the card (with any packet size)
but if I try ssh it doesn't work, the same for other programs which use
TCP. So ICMP works, TCP doesn't and also UDP doesn't work. 

	The interesting thing is that I can view all the packets I send
from another PC using tcpdump. So the card should work as I can see any
packet it sends.

The data of the NE2000 card follow:
	
	chipset:	UML8001
	IRQ:		5
	I/O ports:	0x320-0x32f
	HW MAC:		55:AA:44:32:39:41

(the MAC is strange, the other cards I have begin all with 00)

Thank you for your attention,

	Gianluca


	

	
