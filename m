Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129792AbRALWBn>; Fri, 12 Jan 2001 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129811AbRALWBd>; Fri, 12 Jan 2001 17:01:33 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:54773 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129792AbRALWB0>; Fri, 12 Jan 2001 17:01:26 -0500
Message-ID: <3A5F7E96.AA60C7C4@Home.net>
Date: Fri, 12 Jan 2001 17:00:54 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: miles@megapathdsl.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
In-Reply-To: <Pine.LNX.4.10.10101020019010.8957-100000@vaio.greennet> <3A51D40F.48B9ADB9@home.net> <3A5F791F.BCC236C1@Home.net> <3A5F7D2E.87BFC9B@megapathdsl.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, hrm.... Guess I shouldn't have turned that on ;)
Sorry. nevermind :)


Miles Lane wrote:

> Make sure your kernel build .config file contains the line:
>
>         # CONFIG_INET_ECN is not set
>
> not
>
>         CONFIG_INET_ECN=y
>
> Here's what the kernel configuration help has to say:
>
>   Explicit Congestion Notification (ECN) allows routers to notify
>   clients about network congestion, resulting in fewer dropped packets
>   and increased network performance. This option adds ECN support to the
>   Linux kernel, as well as a sysctl (/proc/sys/net/ipv4/tcp_ecn) which
>   allows ECN support to be disabled at runtime.
>
>   Note that, on the Internet, there are many broken firewalls which
>   refuse connections from ECN-enabled machines, and it may be a while
>   before these firewalls are fixed. Until then, to access a site behind
>   such a firewall (some of which are major sites, at the time of this
>   writing) you will have to disable this option, either by saying N now
>   or by using the sysctl.
>
> Shawn Starr wrote:
> >
> > Here's something strange that i've been noticing with 2.4.0. Some websites I am
> > unable to access now. For example:
> >
> > http://www.scotiabank.ca/simplify/index.html
>
> <snip>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
