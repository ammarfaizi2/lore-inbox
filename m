Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289136AbSA3MkT>; Wed, 30 Jan 2002 07:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSA3MkJ>; Wed, 30 Jan 2002 07:40:09 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:12293 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289136AbSA3Mj6>; Wed, 30 Jan 2002 07:39:58 -0500
Date: Wed, 30 Jan 2002 13:39:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16Vsny-0000Dj-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0201301306190.7674-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Jan 2002, Daniel Phillips wrote:

> > I'd rather make the patchbot more intelligent, that means it analyzes the
> > patch and produces a list of touched files. People can now register to get
> > notified about patches, which changes areas they are interested in.
>
> But they can already do that, by subscribing to the respective mailing list
> (obviously, the bot posts to the list as well as forwarding to the
> maintainer) and running the mails through a filter of their choice.

What about unmaintained parts?

> > In the simplest configuration nothing would change for Linus, but patches
> > wouldn't get lost and people could be notified if their patch was applied
> > or if it doesn't apply anymore.
>
> OK, it would be nice, but you wouldn't want to pile on so many features that
> this never gets implemented would you?  The minimal thing that forwards and
> posts patches is what we need now.  Like any other software it can be
> improved over time.

That's what I have in mind. What we can already do now is to store
incoming patches into some directory. That would give us already some
basic data to work with and we can start to implement new features as they
are needed.

> Automating the applied/dropped status is clearly the next problem to tackle,
> but that's harder, it involves behavioral changes on the maintainers side.

What "behavioral changes"? Maintainers should react in some way or another
react to patches no matter where come from.

> (Pragmatically, providing a web interface so somebody whose job it is to do
> that, can efficiently post 'applied' messages to the list would get the job
> done without making anyone learn new tools or change the way they work.)

Web interfaces can be nice, but the bulk work should be doable by mail.
For changes in areas which have a maintainer, the mail to Linus could
include a note "forwarded to maintainer x" and Linus can still decide,
whether he applies the patch or waits for the OK from the maintainer.

> By the way, who is going to code this?  Or are we determined to make
> ourselves look like wankers once again, by putting considerably more time
> into the lkml flamewar than goes into producing working code?
>
> (Hint: I am not going to code it, nor should I since I should be working in
> the kernel.)

That's a known problem, I have no time either, but we should give anyone
interested in this some example data. This data has to come from the
kernel hackers, but patch management system is better implemented by
non-kernel hackers.

