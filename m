Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275363AbRIZR2w>; Wed, 26 Sep 2001 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275358AbRIZR2d>; Wed, 26 Sep 2001 13:28:33 -0400
Received: from smtp2.cistron.nl ([195.64.68.41]:45323 "EHLO smtp2.cistron.nl")
	by vger.kernel.org with ESMTP id <S275356AbRIZR2Y>;
	Wed, 26 Sep 2001 13:28:24 -0400
Message-ID: <3BB21007.8E73A83E@cistron.nl>
Date: Wed, 26 Sep 2001 19:27:35 +0200
From: Alfred Munnikes <munnikes@cistron.nl>
Reply-To: munnikes@cistron.nl
Organization: Munnikes
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl, en
MIME-Version: 1.0
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process..
In-Reply-To: <Pine.LNX.4.33.0109261855220.6377-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
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

Sorry, I have a network card without a networkcable ( at this time), so
there is not a network cable plugged into the network card, that makes
the timeout. Nothing to worry about (the working kernel 2.4.9 has the
same error message)

Afred
