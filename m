Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283244AbSAGR3R>; Mon, 7 Jan 2002 12:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284285AbSAGR3C>; Mon, 7 Jan 2002 12:29:02 -0500
Received: from gate.perex.cz ([194.212.165.105]:61959 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S283244AbSAGR0q>;
	Mon, 7 Jan 2002 12:26:46 -0500
Date: Mon, 7 Jan 2002 18:25:13 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Christoph Hellwig <hch@caldera.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <20020107180656.A16283@caldera.de>
Message-ID: <Pine.LNX.4.31.0201071819090.498-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Christoph Hellwig wrote:

> On Mon, Jan 07, 2002 at 09:02:39AM -0800, Linus Torvalds wrote:
> > > linux/sound is silly.  It's drivers so put it under linux/drivers/sound.
> >
> > That was my initial reaction too, but Jaroslav clearly wants a
> > higher-level generic hierarchy. Which means that we're not talking about
> > _drivers_ any more, we're talking about something that is much more
> > closely related to a "networking" kind of thing.
>
> If you look at the code it clearly is driver code.

What is code in linux/sound/core then? This midlevel code is shared
with all drivers and definitely belongs to same place like
linux/net/core.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


