Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131310AbRALAn0>; Thu, 11 Jan 2001 19:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbRALAnQ>; Thu, 11 Jan 2001 19:43:16 -0500
Received: from d-dialin-1397.addcom.de ([62.96.164.205]:22257 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131310AbRALAnK>; Thu, 11 Jan 2001 19:43:10 -0500
Date: Fri, 12 Jan 2001 01:35:29 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: rdunlap <randy.dunlap@intel.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: That horrible hack from hell called A20
In-Reply-To: <3A5CBAE3.ACDD2494@intel.com>
Message-ID: <Pine.LNX.4.30.0101120130350.1288-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, rdunlap wrote:

> Here's a patch to 2.2.19-pre7 that is essentially a backport of the
> 2.4.0 gate-A20 code.
>
> This speeds up booting on my fast-A20 board (Celeron 500 MHz, no KBC)
> from 2 min:15 seconds to <too small to measure by my wrist watch>.
>
> Kai, you reported that your system was OK with 2.4.0-test12-pre6.
> Does that mean that it's OK with 2.4.0-final also?

Yes, i would have complained otherwise ;-)

> Comments?  Should we be merging Peter's int 0x15-first patch with this?
> And test for A20-gated after each step, before going to the next
> method?  Get that working and then backport it to 2.2.19?
> Have their been any test reports on Peter's last patch?  I didn't see
> any, but if that should be the goal, I'll give it a whirl.
>
> I'd like to see this applied to 2.2.19.  At least changing the long
> delay so that it doesn't appear that Linux isn't going to boot...

For what it's worth, 2.2.19pre7+your patch works fine here (across
suspend).

--Kai




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
