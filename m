Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311825AbSCNWLX>; Thu, 14 Mar 2002 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311826AbSCNWLO>; Thu, 14 Mar 2002 17:11:14 -0500
Received: from [206.40.202.198] ([206.40.202.198]:11162 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311825AbSCNWKz>; Thu, 14 Mar 2002 17:10:55 -0500
Date: Thu, 14 Mar 2002 14:06:32 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <a6r6ck$8ia$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0203141403561.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Mar 2002, H. Peter Anvin wrote:

> Date: 14 Mar 2002 13:57:40 -0800
> From: H. Peter Anvin <hpa@zytor.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: IO delay, port 0x80, and BIOS POST codes
>
> Followup to:  <Pine.LNX.4.33.0203141318130.9855-100000@penguin.transmeta.com>
> By author:    Linus Torvalds <torvalds@transmeta.com>
> In newsgroup: linux.dev.kernel
> >
> > Port ED is fine for a BIOS, which (by definition) knows what the
> > motherboard devices are, and thus knows that ED cannot be used by
> > anything.
> >
> > But it _is_ an unused port, and that's exactly the kind of thing that
> > might be used sometime in the future. Remember the port 22/23 brouhaha
> > with Cyrix using it for their stuff, and later Intel getting into the fray
> > too?
> >
> > So the fact that ED works doesn't mean that _stays_ working.
> >
>
> It is, in fact, broken on several systems -- I tried ED in SYSLINUX
> for a while, and it broke things for people.

It does work on many, in fact, we used on a Crusoe based platform
as well as the other x86s

Let's make it a configurable kernel debug/hacking option else
we have the added burden of chasing down a common address.

Johnh

>
> 	-hpa
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
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

