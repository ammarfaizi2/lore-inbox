Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275546AbRIZTnw>; Wed, 26 Sep 2001 15:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275547AbRIZTnn>; Wed, 26 Sep 2001 15:43:43 -0400
Received: from smtp1.cistron.nl ([195.64.68.40]:47881 "EHLO smtp1.cistron.nl")
	by vger.kernel.org with ESMTP id <S275546AbRIZTn0>;
	Wed, 26 Sep 2001 15:43:26 -0400
Message-ID: <3BB22FF6.5E792CAA@cistron.nl>
Date: Wed, 26 Sep 2001 21:43:50 +0200
From: Alfred Munnikes <munnikes@cistron.nl>
Reply-To: munnikes@cistron.nl
Organization: Munnikes
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process..
In-Reply-To: <Pine.LNX.4.33.0109261855220.6377-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > eth0: RealTek RTL-8029 found at 0xe000, IRQ 10, 00:00:B4:B6:73:BC.
> 
> > spurious 8259A interrupt: IRQ7.
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=26.
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=23.
> 
> apparently interrupt 10 got lost and was delivered as a spurious
> interrupt. This can be the result of out-of-spec hardware. (card or
> board.)

One moment, I haven't read the mail not totaly. My network card has IRQ
10 and the 'spurious 8259A interrupt' is about IRQ 7. Why should the IRQ
change ? And with the 2.4.9 kernel I have also 

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Tx timed out, cable problem? TSR=0x16, ISR=0x0, t=24.
...

but none 'spurious 8259A interrupt: IRQ7.'

I don't think these 2 messages aren't related to eachother, isn't it a
coincidence that they are comming after eachother ?

Alfred
