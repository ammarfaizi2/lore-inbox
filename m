Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277270AbRJOH4k>; Mon, 15 Oct 2001 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277321AbRJOH4a>; Mon, 15 Oct 2001 03:56:30 -0400
Received: from web11907.mail.yahoo.com ([216.136.172.191]:14353 "HELO
	web11907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277323AbRJOH4M>; Mon, 15 Oct 2001 03:56:12 -0400
Message-ID: <20011015075644.56437.qmail@web11907.mail.yahoo.com>
Date: Mon, 15 Oct 2001 00:56:44 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Re: network device driver
To: =?ISO-8859-1?Q? "Rasmus=5FB=F8g=5FHansen" ?= 
	<moffe@amagerkollegiet.dk>,
        "Mehta, Phoram Kirtikumar \(UMKC-Student\)" <pkm722@umkc.edu>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110150913370.1088-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Rasmus_Bøg_Hansen <moffe@amagerkollegiet.dk>
wrote:
> On Sun, 14 Oct 2001, Mehta, Phoram Kirtikumar
> (UMKC-Student) wrote:
> 
> > 1. how does ifconfig and netstat get teh net
> statistics, where can i get
> > the source to that funtion or source file.
> 
> They are from /proc/net/.
Yeah, here you can find src of network utilities:
http://www.tazenda.demon.co.uk/phil/net-tools/

> 
> > 2. is there any funtion in the network device
> driver source by accessing
> > which i can get the packets received or the type
> of packets. if not can
> > anybody gimme some tips on how can i write it.
> 
> You can use a packet filter.
> 
> > i am trying to write or modify the eth device
> driver(3c509.c) in such a
> > way that i can statistics of the traffic and then
> i also want to
> > identify teh traffic. in short i want to
> incorporate a function in my
> > driver which when acceseed would act as a
> sniffer/protocol analyzer .
> > any help or advise will be appreciated.
> 
> Do it in userspace with packet filters. Look at
> tcpdump for example 
> code.
Sure. Or ... to use netfilter hook functions (if you
can't use user space code)

> 
> Rasmus
> 
> -- 
> -- [ Rasmus 'Møffe' Bøg Hansen ]
> ---------------------------------------
> [...] Note that 120 sec is defined in the protocol
> as the maximum
> possible RTT.  I guess we'll have to use something
> other than TCP
> to talk to the University of Mars.
> --------------------------------- [ moffe at
> amagerkollegiet dot dk ] --
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
