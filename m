Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRLUNnb>; Fri, 21 Dec 2001 08:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbRLUNnV>; Fri, 21 Dec 2001 08:43:21 -0500
Received: from [129.27.43.9] ([129.27.43.9]:49157 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S281795AbRLUNnL>;
	Fri, 21 Dec 2001 08:43:11 -0500
Date: Fri, 21 Dec 2001 14:43:09 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: conclusion: arp.c *must* be (still) defective
In-Reply-To: <20011221142133.C811@suse.de>
Message-ID: <Pine.LNX.4.10.10112211437400.793-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Mailing List,

I'm having great problems with ARP. Frankly, kernel 2.4.16 never gets the
proper arp address of the next-hop-router, no matter what I try.

My equipment: 

Suse 7.3 , kernel upgraded to 2.4.16
3com 3c509-b tx isapnp ethcard eth0
msi-something geforce2mx 200
sb16 isapnp
thunderbird 1.2 ghz
gigabyte 7ixe4 motherboard
512 mb ram @ 100 mhz fsb

I can only ping the IP of the network card itself.

Whenever I ping my nexthop router (ip: x.x.x.1) i get a pause of a few
seconds, then a whole sequence of "Destination unreachable".
Looking at the arp cache using "arp -a", I see that the arp cache is
always incomplete (always KEEPS being incomplete). 

Any clue is greatly appreciated, but I do suspect that the kernel 2.4.16's
ARP code is buggy since Win98 , win2k etc works flawlessly.

Yours

Alex


