Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSLVVYU>; Sun, 22 Dec 2002 16:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSLVVYT>; Sun, 22 Dec 2002 16:24:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265470AbSLVVYS>;
	Sun, 22 Dec 2002 16:24:18 -0500
Date: Sun, 22 Dec 2002 13:31:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Joshua Stewart <joshua.stewart@comcast.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: From __cpu_raise_softirq() to net_rx_action()
In-Reply-To: <1040592944.11785.2.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0212221330150.16753-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Dec 2002, Joshua Stewart wrote:

| After I understand it all, I will not be against putting together an
| explanation of the whole process and posting it back to this mailing
| list, or trying to find a Linux website that will host it.  Is this type
| of this suitable for the Linux Documentation Project website?
|
| Josh

Yes, it should be fine for LDP.

Thanks,
-- 
~Randy

| On Sun, 2002-12-22 at 16:15, Randy.Dunlap wrote:
| > On Sun, 22 Dec 2002, Joshua Stewart wrote:
| >
| > | I'm still trying to follow a packet (or even better an sk_buff) from the
| > | NIC card to user space.  I think I have a good chunk of it figured out,
| > | but I'm missing a bit from the time that the __netif_rx_schedule()
| > | routine calls __cpu_raise_softirq() until the routine net_rx_action()
| > | occurs.  I read in a book on Linux TCP/IP implementation that the
| > | softirq basically leads to a call to net_rx_action(), but I don't see
| > | the connection yet.  It's probably due to my lack of understanding of
| > | IRQ's (and software IRQ's).
| > |
| > | Any help is appreciated.
| >
| > What are you going to do with this good info when you have it?
| > Something like putting it on a web page would be very good, so that
| > other people with similar questions can have a reference to look at.
| >
| > --
| > ~Randy

