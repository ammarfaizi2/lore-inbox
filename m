Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315301AbSDWSYy>; Tue, 23 Apr 2002 14:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315304AbSDWSYx>; Tue, 23 Apr 2002 14:24:53 -0400
Received: from mail1.webmessenger.it ([193.70.193.50]:34532 "EHLO
	mail1a.webmessenger.it") by vger.kernel.org with ESMTP
	id <S315301AbSDWSYw>; Tue, 23 Apr 2002 14:24:52 -0400
Message-ID: <010101c1eaf5$6185a480$0101a8c0@matteo>
From: "Matteo Pelati" <matteo@studiopelati.it>
To: <linux-kernel@vger.kernel.org>
Subject: net_device and multicast
Date: Tue, 23 Apr 2002 20:33:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm new to Linux kernel development and I have a question about networking.
I have a linux box acting as a multicast router and I've to write some code
that intercepts whenever a network interface is added or removed to a
multicast address. That seemed preatty straightforward since I noticed in
the net_device structure there is a pointer to IPv4 infos where i can find a
linked list of multicast addresses assigned to that interface.
The addresses in this list are the same shown doing a cat /proc/net/igmp ?

Since the strange fact is that I've my mcast router with two network
interfaces (eth0, eth1). When both my router and the other two hosts join
the same multicast group all the three bozes are receiving mcast traffic but
if I take a look at /proc/net/igmp on the router only one interface (eth0)
is assigned that mcast group.

Could anyone please give me a clue? I guess I'm missing something here...

Thanks
Matteo

