Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311874AbSCOAQO>; Thu, 14 Mar 2002 19:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311875AbSCOAPy>; Thu, 14 Mar 2002 19:15:54 -0500
Received: from [206.40.202.198] ([206.40.202.198]:26522 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311874AbSCOAPv>; Thu, 14 Mar 2002 19:15:51 -0500
Date: Thu, 14 Mar 2002 16:11:25 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: David Golden <david.golden@oceanfree.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <02031500124202.02088@golden1.goldens.ie>
Message-ID: <Pine.LNX.4.33.0203141608000.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, David Golden wrote:

> Date: Fri, 15 Mar 2002 00:12:42 +0000
> From: David Golden <david.golden@oceanfree.net>
> To: linux-kernel@vger.kernel.org
> Subject: Re: IO delay, port 0x80, and BIOS POST codes
>
> On Thursday 14 March 2002 22:55, Alan Cox wrote:
> >
> > We've got one. Its 0x80. It works everywhere with only marginal non
> > problematic side effects
>
> I've always liked POST cards.  They could hypothetically be useful
> for kernel development,too  - who hasn't wanted a low-level
> single-asm-instruction status output from a running system at one time or
> another , independent of any other output mechanisms?
>
> OK it's a single byte, but it's still nice...  That's two whole hex digits!
> DE... AD...  BE... EF... !

Any number of consecutive bits and a target I/O address can be very
useful.

I do it regularly for embedded kernel hacking... harmless I/O, picked up
by your logic analyzer.

Only drawback is it adds pathlength which can impact realtime if you get
excessive.

Johnh

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

