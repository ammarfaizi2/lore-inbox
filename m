Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbQKDHSz>; Sat, 4 Nov 2000 02:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132500AbQKDHSp>; Sat, 4 Nov 2000 02:18:45 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25099 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132484AbQKDHSd>;
	Sat, 4 Nov 2000 02:18:33 -0500
Message-ID: <3A03B843.37E774FA@mandrakesoft.com>
Date: Sat, 04 Nov 2000 02:18:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Thomas Sailer <sailer@ife.ee.ethz.ch>, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <Pine.LNX.4.10.10011032237270.25382-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 4 Nov 2000, Jeff Garzik wrote:
> > > So fix the stupid API.
> > >
> > > The above is just idiocy.
> >
> > We're pretty much stuck with the API, until we look at merging ALSA in
> > 2.5.x.  Broken API or not, OSS is a mature API, and there are
> > spec-correct apps that depend on this behavior.
> 
> Considering that about 100% of the sound drivers do not follow that
> particular API damage anyway (they can't, as has been pointed out: the
> driver doesn't even receive enough information to be _able_ to follow the
> documented API), I doubt that there are all that many programs that depend
> on it.
> 
> Yes, some drivers apparently _try_ to follow the spec to some degree, but
> we should just change the documentation asap.

Fine with me.  Allows for some driver simplification, and it only
applies to the lesser-used recording stuff at any rate.

	Jeff


-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
