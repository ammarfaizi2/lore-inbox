Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277127AbRJOHOZ>; Mon, 15 Oct 2001 03:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277187AbRJOHOQ>; Mon, 15 Oct 2001 03:14:16 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:32781 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S277127AbRJOHOL>; Mon, 15 Oct 2001 03:14:11 -0400
Date: Mon, 15 Oct 2001 09:14:37 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: "Mehta, Phoram Kirtikumar (UMKC-Student)" <pkm722@umkc.edu>
cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: network device driver
In-Reply-To: <F918702592382F4991EB852F78EF36583203A3@KC-MAIL2.kc.umkc.edu>
Message-ID: <Pine.LNX.4.33.0110150913370.1088-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001, Mehta, Phoram Kirtikumar (UMKC-Student) wrote:

> 1. how does ifconfig and netstat get teh net statistics, where can i get
> the source to that funtion or source file.

They are from /proc/net/.

> 2. is there any funtion in the network device driver source by accessing
> which i can get the packets received or the type of packets. if not can
> anybody gimme some tips on how can i write it.

You can use a packet filter.

> i am trying to write or modify the eth device driver(3c509.c) in such a
> way that i can statistics of the traffic and then i also want to
> identify teh traffic. in short i want to incorporate a function in my
> driver which when acceseed would act as a sniffer/protocol analyzer .
> any help or advise will be appreciated.

Do it in userspace with packet filters. Look at tcpdump for example 
code.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
[...] Note that 120 sec is defined in the protocol as the maximum
possible RTT.  I guess we'll have to use something other than TCP
to talk to the University of Mars.
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

