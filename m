Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSBSXOJ>; Tue, 19 Feb 2002 18:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289794AbSBSXN7>; Tue, 19 Feb 2002 18:13:59 -0500
Received: from mustard.heime.net ([194.234.65.222]:36994 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289790AbSBSXNx>; Tue, 19 Feb 2002 18:13:53 -0500
Date: Wed, 20 Feb 2002 00:13:48 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Schmidt <j.schmidt@paradise.net.nz>, <linux-kernel@vger.kernel.org>,
        Jens Schmidt <j.schmidt@paradise.net.nz>
Subject: Re: secure erasure of files?
In-Reply-To: <20020219.HQ8.97132600@karlsbakk.net>
Message-ID: <Pine.LNX.4.30.0202200012140.3890-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is one point, though.

Ibas told me, at at briefing, that they had recovered data, overwritten 37
times. This was in '93.

This also might tell the text underneath is false.

anyone?

roy

On Tue, 19 Feb 2002, Roy Sigurd Karlsbakk wrote:

> >I would strongly encourage somebody with fluent Norsk/English skills
> >to do a translation and post it to the list.
>
> I'll do my very best ...
>
> (translated by Roy Sigurd Karlsbakk - please don't spam me in case of bad
> speling :)
>
> With permission from the leader of Research and Deveopment department, I
> quote his complete answer:
>
> I'll try to answer your questions:
>
> The short answer is: No. It is not possible to read data that are (really)
> physically overwritten.
>
> Still, the reason to this is is a little different than what you are describing.
> To speak reasonably about this, we firstly need some basic understanding of how
> data is stored on a harddisk. A harddisk does not manipulate individual bits, but
> flux change. Simply explained is 'flux direction' however the magnetic field points
> clockwise or counter-clockwise. Thus, a 'flux change' is where the flux changes from
> CCW to CW or the other way around. The mapping between flux changes is not
> one-to-one.
> This means that we DO NOT use CW=0, CCW=1, but rather have each flux
> change
> giving the origin pf 2.5 to 3 bits in addition to the disks sequence detection.
> This means that it does not attempt to detect each bit isolated, but rather decodes
> a sequence at a time (typically 4096 bit = 1 sector).
>
> This sequence detection is quite the same as a human reading a bad
> fax. If we try to read the fax letter by letter, we may for instance
> mistake an 'a' with an 'o'. If this letter is part of the word 'bank',
> and we read it letter by letter, we'll end up with 'bonk. However, if we
> look at the whole word (the sequence of letters), we can probably see
> the most probable word is 'bank'.
>
> After data is overwritten, we can measure how strong the (field of the)
> old data is compared to the new ones. This means that all 'old' signals
> never really disappear. Still, our investigation shows that there is no
> officially documented way of how to change these (old) signals back to
> the origial data-
>
> It may seem this will demand trail-breaking discoveries in many different
> fields: Non-linear analysis and modelling, low-noice electronics (cryo-
> electronics), computer technology (super-fast number-chrunchers)
>
> This was the long (complicated) answer :)
>
> What is sure: Ibas does not know any documented methods, scientific
> environments or commercial services that do or demonstrate reading
> of overwritten data.
>
> --
> Thor Arne Johansen
> Avdelingssjef FoU, Ibas AS
>
> Addition:
>
> Still, it should be said that this is being argued upon between the
> 'wise' ones. This is - there are people that mean it is possible
> to read/recover overwritten data. But we have, as mentioned above,
> not found any scientific documentation or decriptions of how this
> can be done.
>
> -----------------------------------------------------------------------------
> --
> --
> Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
>
> Computers are like air conditioners.
> They stop working when you open Windows.
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

