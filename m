Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275573AbRJOR54>; Mon, 15 Oct 2001 13:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJOR5r>; Mon, 15 Oct 2001 13:57:47 -0400
Received: from web10704.mail.yahoo.com ([216.136.130.212]:21266 "HELO
	web10704.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S274875AbRJOR5g>; Mon, 15 Oct 2001 13:57:36 -0400
Message-ID: <20011015175808.85935.qmail@web10704.mail.yahoo.com>
Date: Mon, 15 Oct 2001 10:58:08 -0700 (PDT)
From: Mal hacker <malhacker@yahoo.com>
Subject: Re: network device driver
To: "Mehta, Phoram Kirtikumar \(UMKC-Student\)" <pkm722@umkc.edu>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kirti, 
rather than doing it in kernel space why don't u do in userspace.
There's a lot of tools and libraries available! Take for example
tcpdump, ethereal, dniff and others as tools, libpcap (*nix packet
capturing library) or wincap (windows packet capturing library) and
many more. The kernel also provides a lot of other features via the
socket call to do these stuff. Could u please detail out what exactly
do u want to do and your major reason of getting inside the kernel ?

hope this helps..
mal
-------------------------------------------------------------------

On Sun, 14 Oct 2001, Mehta, Phoram Kirtikumar (UMKC-Student) wrote: >
1. how does ifconfig and netstat get teh net statistics, where can i
get
> the source to that funtion or source file. They are from /proc/net/.
> 2. is there any funtion in the network device driver source by
accessing
> which i can get the packets received or the type of packets. if not
can
> anybody gimme some tips on how can i write it. You can use a packet
filter. > i am trying to write or modify the eth device driver(3c509.c)
in such
a
> way that i can statistics of the traffic and then i also want to
> identify teh traffic. in short i want to incorporate a function in my
> driver which when acceseed would act as a sniffer/protocol analyzer .
> any help or advise will be appreciated. Do it in userspace with
packet filters. Look at tcpdump for example
code. Rasmus

=====

Image by FlamingText.com

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
