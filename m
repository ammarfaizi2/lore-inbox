Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276534AbRJKQ3b>; Thu, 11 Oct 2001 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJKQ3V>; Thu, 11 Oct 2001 12:29:21 -0400
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:27603 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276534AbRJKQ3E>; Thu, 11 Oct 2001 12:29:04 -0400
Message-ID: <3BC5C866.1337F5DF@home.com>
Date: Thu, 11 Oct 2001 12:27:18 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 / 
 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
In-Reply-To: <002001c15250$6fad3c50$020da8c0@nitemare>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I haven't noticed this problem on my system...

I have an 82558 that uses this driver on a Tyan S1836DLUAN motherboard.
I have Dual PIIIs and the system is multi homed. I have a 2nd interface that
uses the NE2000 PCI driver.

The system is my workstation but also acts as an internet gateway (via cable
modem) and firewall for 2 other computers. My workstation is on 24/7 and has
never hungup.

I am currently using 2.4.10 for the kernel but I've used most kenels since
the 2.4.0testX days.

In your tests, is the 80 - 130 megs a single file or is it an aggregate. In
my use I far exceed the amount of data but it's web surfing so the files are
much smaller the what you mention.

John

Robbert Kouprie wrote:

> Hi all,
>
> I can confirm that the known bug in the Intel EtherExpress Pro/100
> adapter is still not worked around in recent kernels. The bug only
> manifests itself when the card is operating on 10 Mbit half duplex. On
> 100 Mbit there are no problems. The problem is that after the device
> received certain amount of traffic (between 80 and 130 Mb in my tests)
> the device will lockup on new connections. Processes start to hang after
> this and logging in is impossible. The only solution is to reset the
> interface (using a previously logged in root session) and reboot the
> system.
>

