Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSGIQUA>; Tue, 9 Jul 2002 12:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316836AbSGIQT7>; Tue, 9 Jul 2002 12:19:59 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17939 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316712AbSGIQT6> convert rfc822-to-8bit; Tue, 9 Jul 2002 12:19:58 -0400
Date: Tue, 9 Jul 2002 12:17:33 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Christian =?iso-8859-15?q?Borntr=E4ger?= <linux@borntraeger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1: NETDEV WATCHDOG: eth0: transmit timed out 
In-Reply-To: <200207061510.29594.linux@borntraeger.net>
Message-ID: <Pine.LNX.3.96.1020709121532.27294C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002, Christian [iso-8859-15] Bornträger wrote:

> I found some of these messages in the archive, but nothing really helped me.
> I have to remove the 3c59x driver , because network restart is not enough to 
> bring back life to my network connection.
> 
> I never saw this message with older kernels (<=2.4.18), but I moved to another 
> place with another network, so I am not sure if it is related to some 
> hardware problems or driver trouble.
> 
> The 3com shares the interrupt with some other cards on an KT133A-chipset. This 
> happens unfrequent but mostly when I have high traffic.

I have seen interrupt problems with that chipset when sharing interrupts
with the onboard stuff. I had to disable the 2nd serial port to get a NIC
working, and I still see spurrious INT from the parallel port, which I
need. Even when not in use it babbles.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

