Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270747AbTGNS15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270748AbTGNS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:27:57 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:37255 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270747AbTGNS1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:27:50 -0400
Date: Mon, 14 Jul 2003 15:40:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: ajoshi@kernel.crashing.org
Cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
Message-ID: <Pine.LNX.4.55L.0307141533330.8994@freak.distro.conectiva>
References: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003 ajoshi@kernel.crashing.org wrote:

>
>
> On Mon, 14 Jul 2003, Marcelo Tosatti wrote:
> >
> > On Mon, 14 Jul 2003 ajoshi@kernel.crashing.org wrote:
> >
> > >
> > > Hi Marcelo,
> > >
> > > Is there any particular reason why you decided to merge Ben H.'s radeonfb
> > > update instead of the one I sent you?
> >
> > I've decided to CC lkml because I think there are other people interested
> > in this discussion.
> >
> > I merged his version because he sent me your update (0.1.8) plus his code
> > (which are useful fixes he has been working on).
>
> Which is what the original 0.1.8 patch included, his fixes were included.

Ah really? I though that his changes were not merged in your 0.1.8 patch.

So can I just revert his patch and accept your instead that all of his
stuff is in ? Whoaa, great.

>
> >
> > It seems things are broken now due to a missing header, but he also sent
> > me that.
>
> There was no missing header, if you see the patch I sent you (about 3
> times), the header file is in there.
>
> >
> > Do you have any objections to his fixes ?
> >
>
> Besides the obvious version changes and difficulty maintaining a driver
> where anyone seems to be able to change it in the official tree, the
> objections were deteremined and fixed in the patch I sent you.
>
> Refresh my memory as it seems things have  changed in kernel patch
> submission process:
>
> There is someone called a driver author or maintainer, this person
> recieves patches for fixes from various people, he/she then compiles them
> into a single patch and submits it to the kernel tree maintiner.  However
> nowdays it seems the kernel tree maintainer has the descretion to accept
> patches from anyone how puts up a fight, is this the case nowdays?

Ani, I received complains that you were not accepting patches from Ben. He
needs that code in.

> If so then please let me know, so I don't waste anymore of my time on
> this driver and let someone else play these silly games and maintain it.

I prefer playing no silly games in the 2.4 stable series, as I've been
trying to do so far. If you had accepted Ben's changes in the first place
I wouldnt need to apply his patch.

Ben is very interested in maintaining the driver, AFAIK. Is that
correct, Ben?

Are you interested in giving up maintenance?

For me it doenst matter who maintains the driver, as long as it is well
maintained.
