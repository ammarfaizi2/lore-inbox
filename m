Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263196AbREWSLY>; Wed, 23 May 2001 14:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbREWSLP>; Wed, 23 May 2001 14:11:15 -0400
Received: from ns2.radioschefer.ch ([62.2.224.35]:63247 "EHLO
	ns2.radioschefer.ch") by vger.kernel.org with ESMTP
	id <S263194AbREWSLE>; Wed, 23 May 2001 14:11:04 -0400
Message-ID: <3B0BFD7F.B32695C8@bluewin.ch>
Date: Wed, 23 May 2001 20:12:15 +0200
From: Stephan Brauss <sbrauss@bluewin.ch>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD DT  (Win95; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 kernel freeze
In-Reply-To: <Pine.LNX.4.10.10105231215280.11617-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> what do you mean by freeze?  in theory, the fact that the irq
I cannot ping the machine anymore, no Ooops, no kernel messages, the
attached screen is freezed (which implies that no more interrupts
are handled, right?)

> for those slots is shared with arbitrary onboard peripherals
> shouldn't matter, since PCI devices can all share irq's.
Yes... And it is not the problem, as I make use of interrupt 
sharing on the first three slots.

> I guess it would be valuable to compare the boot messages
>From 2.2.19 and 2.4.4?

> under these conditions, since a real freeze implies that the 
> kernel is adjusting irq routing incorrectly...
Yes, one could think. But I checked that interrupt handling basically
works for slots 4+5 with "cat /proc/interrupts". As soon as
I start a larger ftp data transfer over an ethernet adapter in
one of these slots the problem occurs.
