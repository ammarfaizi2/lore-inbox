Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSLWOuP>; Mon, 23 Dec 2002 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSLWOuP>; Mon, 23 Dec 2002 09:50:15 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:28156 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265683AbSLWOuO>;
	Mon, 23 Dec 2002 09:50:14 -0500
Date: Mon, 23 Dec 2002 15:56:55 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       James Simmons <jsimmons@infradead.org>, Stian Jordet <liste@jordet.nu>,
       Allan Duncan <allan.d@bigpond.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51
In-Reply-To: <m1n0nbuvqh.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.4.21.0212231556070.16361-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 2002, Eric W. Biederman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > Well, at least r128's and radeon's need the memory controller and PLLs
> > initialized by the BIOS/firmware, we don't have documentation about how
> > to acheive that ourselves (and this can depend on the specific wiring of
> > a given card anyway).
> 
> I believe those actions have to be taken.  I haven't seen how flexible
> the chips are with respect to which memory they take, which is
> generally where most of the complexity comes in.
> 
> I have written northbridge memory initialization code that generally
> does not depend on the motherboard, I would be very surprised to find
> out that video card are generally more difficult (except in the area
> of documentation).

Do you have SPD EEPROMs on your video card's memory?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

