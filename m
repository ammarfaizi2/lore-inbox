Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316855AbSHGBun>; Tue, 6 Aug 2002 21:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSHGBun>; Tue, 6 Aug 2002 21:50:43 -0400
Received: from chaos.analogic.com ([204.178.40.224]:20869 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316855AbSHGBum>; Tue, 6 Aug 2002 21:50:42 -0400
Date: Tue, 6 Aug 2002 21:57:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
Subject: Re: ethtool documentation
In-Reply-To: <1028671126.18478.190.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1020806215309.26428A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Aug 2002, Alan Cox wrote:

> On Tue, 2002-08-06 at 21:03, Richard B. Johnson wrote:
> > Sure you can. And it was assumed that the MAC address provided by
> > the manufacturer would always be used by the software for the MAC
> > address on the wire. However, 'software engineers' have decided
> 
> Umm no
> 
> DECnet used dynamically assigned MAC addresses from the beginning and
> Digital (now Compaq (now HP)) were one of the creators of the original
> DIX ethernet standard
> 
> Thats why several boards allow you to have a pair of receiving MAC
> addresses.
> 

That's not the MAC address. That's the multicast hash. They are
different. The MAC address says who you are. The multicast hash
says who you can receive (in addition to your MAC and the
all 1's broadcast). Of course there's also 'promisc' which turns
off receive filtering all together.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

