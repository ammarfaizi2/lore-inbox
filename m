Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQKPVH4>; Thu, 16 Nov 2000 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129750AbQKPVHq>; Thu, 16 Nov 2000 16:07:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3844 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129325AbQKPVHf>;
	Thu, 16 Nov 2000 16:07:35 -0500
Date: Sat, 1 Jan 2000 02:54:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Woodhouse <dwmw2@infradead.org>, David Hinds <dhinds@valinux.com>,
        torvalds@transmeta.com, tytso@valinux.com,
        linux-kernel@vger.kernel.org, tutso@mit.edu
Subject: Re: [PATCH] pcmcia event thread. (fwd)
Message-ID: <20000101025452.A53@toy>
In-Reply-To: <Pine.LNX.4.30.0011132222070.28525-100000@imladris.demon.co.uk> <3A106F81.FB5BE7F1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A106F81.FB5BE7F1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Nov 13, 2000 at 05:47:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Cool. Linus, please could you apply this patch. If the fact that i82365
> > and tcic are broken in 2.4 isn't on Ted's critical list, then I think it
> > probably ought to have been - and this should fix it.
> 
> It's purposefully not on Ted's critical list, the official line is "use
> pcmcia_cs external package" if you need i82365 or tcic instead of yenta

Ted, is this true? It would be wonderfull to be able to use i82365 without
need for pcmcia_cs...

I think in-kernel pcmcia crashing even on simple things *is* critical bug.

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
