Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130953AbRAaHXf>; Wed, 31 Jan 2001 02:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130966AbRAaHXZ>; Wed, 31 Jan 2001 02:23:25 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:26892 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S130953AbRAaHXM>;
	Wed, 31 Jan 2001 02:23:12 -0500
Date: Wed, 31 Jan 2001 08:23:03 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL and 3c59x (3c905c-tx)
In-Reply-To: <3A7746E7.B806CA5A@uow.edu.au>
Message-ID: <Pine.LNX.4.30.0101310812030.13346-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001, Andrew Morton wrote:
> The code was broken, so I disabled it.

Because of the loss of state bug with Cyclone, and the "missing" acpi_wake
workaround, right?

> I "fixed" WOL in the 2.2.19-pre candidate driver.  It's
> at http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19-pre6-1.gz
>
> I'd really appreciate it if you could test the WOL in
> that driver.  Then we can port it into 2.4 and try to
> fool Linus into thinking it's a bugfix :)

Of course it is a bug-fix!  I'm very bugged by the current behaviour!
Doesn't that count? :-)

Ugh.  Is the 2.2 driver more advanced than the 2.4 one?  Only temporary, I
hope... :-)

But alas, I cannot easily test this patch, since I need 2.4 for my ATA100
IDE controller, but please send me a patch for 2.4 as soon as you have
one, and I'll help you test it.

Would it be enough to port the acpi_wake function to 2.4?  If so, I can do
that myself.  In fact, I think I'll try that right away.  Who needs
breakfast anyway? :-)

/Tobias, the one smiley per sentence guy :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
