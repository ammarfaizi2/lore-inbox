Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSAGSk6>; Mon, 7 Jan 2002 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSAGSkt>; Mon, 7 Jan 2002 13:40:49 -0500
Received: from smtp2.libero.it ([193.70.192.52]:23790 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S285065AbSAGSk3>;
	Mon, 7 Jan 2002 13:40:29 -0500
Message-ID: <3C39EB68.BC8C804@alsa-project.org>
Date: Mon, 07 Jan 2002 19:39:36 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en, it
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@ns.caldera.de>,
        Jaroslav Kysela <perex@suse.cz>, sound-hackers@zabbo.net,
        linux-sound@vger.rutgers.edu, linux-kernel@vger.kernel.org
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0201071024450.6671-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 7 Jan 2002, Abramo Bagnara wrote:
> >
> > IMO the latter makes much more sense (also for "net" case), but I doubt
> > you're willing to change current schema.
> 
> Agreed. I do not really think that it makes sense to move "drivers/net" to
> "net/drivers" even if it _would_ be the logical way to group all net
> things together. Whatever potential incremental advantage (if any) just
> isn't worth the disruption.
> 
> > If you want to keep top level cleaner and avoid proliferation of entries
> > we might have:
> >
> > subsys/sound
> ...
> 
> No, I hate to create structure abstractions for their own sake, and a
> "subsys" kind of abstraction doesn't really add any information.

Ok, I agree.

Just to resume, you think that the way to go is:

1) to have sound/ with *all* sound related stuff inside
2) to leave drivers/net/ and net/ like they are now (because although
it's suboptimal, to change it is a mess we don't want to face now)

Right?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
