Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130587AbRCLUYy>; Mon, 12 Mar 2001 15:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130588AbRCLUYo>; Mon, 12 Mar 2001 15:24:44 -0500
Received: from smtp1.sentex.ca ([199.212.134.4]:35332 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S130587AbRCLUYa>;
	Mon, 12 Mar 2001 15:24:30 -0500
Message-ID: <3AAD2F0F.AC96318F@coplanar.net>
Date: Mon, 12 Mar 2001 15:18:23 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Hicks <mort@bork.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and PPPoE problem
In-Reply-To: <20010312145749.A8645@plato.bork.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks wrote:

> Hello,
>
> I'm using PPPoE with an i586 machine running 2.4.2.

are you using the kernel pppoe or the user-space one (rp-pppoe, etc)?
did it work on other kernels?

>
>
> The machine connects fine and allows network traffic to pass
> through the link.
>
> However, certain websites seem to choke.
> (notable ones are www.chapters.ca and www.hp.com)
>
> Using Lynx or Netscape I get the same results, a few bytes of
> traffic are received and then nothing (eventually the connection
> times out).
>
> The same does not happen in windows.  (ugh)
>
> I have not encountered any machine that I have telnet/ftp/ssh
> access to that breaks in this way so I can only confirm that http traffic
> is not working.
>
> This gateway machine does masquerading, and internal machines and the external
> machine react the same way.

are you positive the external (2.4.2 machine, right?) acts this way?

you can send me a tcpdump trace of a session or two that chokes.

>
>
> TIA
> mh
>
> Here is some useful info:
>
> mort@galileo:~$ uname -a
> Linux galileo 2.4.2 #4 Thu Feb 22 14:13:23 EST 2001 i586 unknown
>
> mort@galileo:~$ /sbin/ifconfig ppp0
> ppp0      Link encap:Point-to-Point Protocol
>           inet addr:209.217.122.37  P-t-P:209.217.122.1  Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1480  Metric:1
>           RX packets:1272056 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1476697 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:3
>           RX bytes:430171737 (410.2 Mb)  TX bytes:1260803415 (1202.3 Mb)
>
> mort@galileo:~$ /sbin/route
> Kernel IP routing table
> Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
> magma           *               255.255.255.255 UH    0      0        0 ppp0
> 192.168.69.0    *               255.255.255.0   U     0      0        0 eth0
> default         magma           0.0.0.0         UG    0      0        0 ppp0
>
> --
> Martin Hicks   || mort@bork.org
> Use PGP/GnuPG  || DSS PGP Key: 0x4C7F2BEE
> Beer: So much more than just a breakfast drink.
>
>   ------------------------------------------------------------------------
>    Part 1.2Type: application/pgp-signature

