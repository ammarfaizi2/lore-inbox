Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284580AbSAGSCs>; Mon, 7 Jan 2002 13:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284619AbSAGSCj>; Mon, 7 Jan 2002 13:02:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21002 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284580AbSAGSCZ>; Mon, 7 Jan 2002 13:02:25 -0500
Date: Mon, 7 Jan 2002 10:00:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        <sound-hackers@zabbo.net>, <linux-sound@vger.rutgers.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <E16Ndc4-0001sW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201070959430.6559-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Alan Cox wrote:
> > Or we could just have a really _deep_ hierarchy, and put everything under
> > "linux/drivers/sound/..", but I'd rather break cleanly with the old.
>
> Christoph has an interesting point. Networking is
>
> 	net/[protocol]/
> 	drivers/net/[driver]
>
> so by that logic we'd have
>
> 	sound/soundcore.c
> 	sound/alsa/alsalibcode
> 	sound/oss/osscore
>
> 	sound/drivers/cardfoo.c
>
> which would also be much cleaner since the supporting crap would be seperate
> from the card drivers

I would certainly not oppose that. Look sane to me, although the question
then ends up being about "drivers/sound" or "sound/drivers" (the latter
has the advantage that it keeps sound together, the former is more
analogous to the "net" situation).

		Linus

