Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSLVVWd>; Sun, 22 Dec 2002 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSLVVWc>; Sun, 22 Dec 2002 16:22:32 -0500
Received: from smtp.comcast.net ([24.153.64.2]:61784 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S265413AbSLVVWc>;
	Sun, 22 Dec 2002 16:22:32 -0500
Date: Sun, 22 Dec 2002 16:35:36 -0500
From: Joshua Stewart <joshua.stewart@comcast.net>
Subject: Re: From __cpu_raise_softirq() to net_rx_action()
In-reply-to: <Pine.LNX.4.33L2.0212221313400.16753-100000@dragon.pdx.osdl.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1040592944.11785.2.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.33L2.0212221313400.16753-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I understand it all, I will not be against putting together an
explanation of the whole process and posting it back to this mailing
list, or trying to find a Linux website that will host it.  Is this type
of this suitable for the Linux Documentation Project website?

Josh

On Sun, 2002-12-22 at 16:15, Randy.Dunlap wrote:
> On Sun, 22 Dec 2002, Joshua Stewart wrote:
> 
> | I'm still trying to follow a packet (or even better an sk_buff) from the
> | NIC card to user space.  I think I have a good chunk of it figured out,
> | but I'm missing a bit from the time that the __netif_rx_schedule()
> | routine calls __cpu_raise_softirq() until the routine net_rx_action()
> | occurs.  I read in a book on Linux TCP/IP implementation that the
> | softirq basically leads to a call to net_rx_action(), but I don't see
> | the connection yet.  It's probably due to my lack of understanding of
> | IRQ's (and software IRQ's).
> |
> | Any help is appreciated.
> 
> What are you going to do with this good info when you have it?
> Something like putting it on a web page would be very good, so that
> other people with similar questions can have a reference to look at.
> 
> -- 
> ~Randy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


