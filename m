Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSHHMnj>; Thu, 8 Aug 2002 08:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHHMnj>; Thu, 8 Aug 2002 08:43:39 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:16650 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S316880AbSHHMni> convert rfc822-to-8bit;
	Thu, 8 Aug 2002 08:43:38 -0400
Date: Thu, 8 Aug 2002 15:47:18 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: Frederik Dannemare <tux@sentinel.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: forcing the tg3 into full duplex
In-Reply-To: <1028809316.1770.13.camel@frda-linux.staff.tdk.net>
Message-ID: <Pine.LNX.4.33.0208081546290.23460-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 8 Aug 2002, Frederik Dannemare wrote:

> Hi,
>
> anybody knows how to do this?
>
> I was hoping to be able to set an option like "full_duplex=1" or
> something when loading the module, but this doesn't work. Also doing a
> "modinfo tg3" tells me there's only a debug parm (tg3_debug) for the
> module.
>
> Machine: Dell PowerEdge 2650
> OS/kernel: SuSE 8 with standard kernel (2.4.18-64GB-SMP)
>
> /var/log/messages output:
> Aug  8 15:38:08 serv100 kernel: tg3.c:v0.97 (Mar 13, 2002)
> Aug  8 15:38:08 serv100 kernel: eth0: Tigon3 [partno(BCM95701A10) rev
> 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT E
> thernet 00:06:5b:3e:46:e2
> Aug  8 15:38:08 serv100 kernel: eth1: Tigon3 [partno(BCM95701A10) rev
> 0105 PHY(5701)] (PCIX:133MHz:64-bit) 10/100/1000BaseT E
> thernet 00:06:5b:3e:46:e3
> Aug  8 15:38:08 serv100 kernel: eth0: Link is up at 100 Mbps, half
> duplex.
> Aug  8 15:38:08 serv100 kernel: eth0: Flow control is off for TX and off
> for RX.
>
> I also tried mii-tool on the interface which reports this:
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
>
>
> Please let me know if more info from my part is needed for
> troubleshooting. Many thanks in advance.
>

I think tigon3-driver supports ethtool. Try it.


- Pasi Kärkkäinen


                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

