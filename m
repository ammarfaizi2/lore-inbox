Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGUUHP>; Sun, 21 Jul 2002 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSGUUHP>; Sun, 21 Jul 2002 16:07:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3769 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315162AbSGUUHO>;
	Sun, 21 Jul 2002 16:07:14 -0400
Date: Sun, 21 Jul 2002 22:09:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <20020721205800.B26376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0207212206370.25809-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Russell King wrote:

> - William Irvin and Zwane Mwaikambo have been testing it, found a
>   deadlock, now fixed. (yay)

good.

> - Zwane reports that serial console doesn't work for him.  Oddly,
>   it works here on a Netwinder (which has all the bits'n'pieces to
>   be close enough to a PC with a PCI bus, southbridge, and standard
>   serial ports at standard IO bases and standard IRQs) so I'm at a
>   loss why this works for me but not Zwane.

i can test this, on SMP as well.

> I'm just sorting out a 2.5.26-rmk1 release, then update to 2.5.27, make
> sure it builds, and then I'll be sending the serial stuff to Linus.  
> Until then, I've no idea if any patch I create will apply to 2.5.27.

okay - since the IRQ changes do not (suppose to) affect UP functionality,
there's time to get it fixed.

	Ingo

