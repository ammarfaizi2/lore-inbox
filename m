Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSAGU3l>; Mon, 7 Jan 2002 15:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSAGU3c>; Mon, 7 Jan 2002 15:29:32 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:50446 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S286841AbSAGU3W> convert rfc822-to-8bit; Mon, 7 Jan 2002 15:29:22 -0500
Date: Mon, 7 Jan 2002 12:29:18 -0800 (PST)
From: Jauder Ho <jauderho@carumba.com>
X-X-Sender: jauderho@twinlark.arctic.org
To: Linus Torvalds <torvalds@transmeta.com>
cc: Abramo Bagnara <abramo@alsa-project.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        <sound-hackers@zabbo.net>, <linux-sound@vger.rutgers.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
In-Reply-To: <Pine.LNX.4.33.0201071044260.6694-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.43.0201071224220.23877-100000@twinlark.arctic.org>
X-Mailer: UW Pine 4.21 + a bunch of schtuff
X-There-Is-No-Hidden-Message-In-This-Email: There are no tyops either
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, that's kinda silly to have two different approaches. If the
consensus is to keep net/ and drivers/net/, why not just have sound/ and
drivers/sound/ too?

It is not a big stretch to grab sound/ and drivers/sound/ over just
sound/ and certainly the proposal of having a subsys/ directory is
essentially a rename of drivers/ to subsys/.

so....

net/
sound/
drivers/net/
drivers/sound/

The drivers subdir structure closely follows what happens one level up.
Not a problem and maintains the status quo. QED.

--Jauder

On Mon, 7 Jan 2002, Linus Torvalds wrote:

>
> On Mon, 7 Jan 2002, Abramo Bagnara wrote:
> >
> > Just to resume, you think that the way to go is:
> >
> > 1) to have sound/ with *all* sound related stuff inside
> > 2) to leave drivers/net/ and net/ like they are now (because although
> > it's suboptimal, to change it is a mess we don't want to face now)
>
> This is my current feeling.
>
> However, la donna é mobile, and I'm a primus donna, fer shure. So don't
> take it _too_ seriously, continue to argue the merits of other approaches.
>
> 		Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

