Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262593AbRFNDYq>; Wed, 13 Jun 2001 23:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263092AbRFNDYg>; Wed, 13 Jun 2001 23:24:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:52745 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262593AbRFNDY0>;
	Wed, 13 Jun 2001 23:24:26 -0400
Date: Thu, 14 Jun 2001 00:24:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Daniel <ddickman@nyc.rr.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
Message-ID: <Pine.LNX.4.21.0106140018140.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, Daniel wrote:

OK, after my earlier troll posting, lets go over Daniel's
reasons point by point. Well actually, all of these points
fit in one argument.

> -- Getting rid of old code can help simplify the kernel. This means
> less chance of bugs.
> -- Simplifying the kernel means that it will be easier for newbies to
> understand and perhaps contribute.
> -- a simpler, cleaner kernel will also be of more use in an academic
> environment.
> -- a smaller kernel is easier to maintain and is easier to re-architect
> should the need arise.

Everything you propose to get rid of are DRIVERS.  They
do NOT complicate the core kernel, do NOT introduce bugs
in the core kernel and have absolutely NOTHING to do with
how simple or maintainable the core kernel is.

All of the arguments you give above are irrelevant to the
things you propose to have removed from the kernel.

> -- If someone really needs support for this junk, they will always
> have the option of using the 2.0.x, 2.2.x or 2.4.x series.

They have that option NOW, but in the future people may no
longer be interested in doing essential things like security
updates or network protocol updates to older kernels.

Also, forcing people to use these older kernels will only ADD
to the maintenance problems of the Linux kernel, instead of
making them less ... since then we'd have to release security
and network protocol updates against more kernel versions.

It would also make it impossible for people to combine new and
old hardware in one machine. Think of ham radio operators or
physics people who have their own home-brewn hardware for packet
radio or data acquisition.

It's not your arguments or the things you propose that make me
think you're a troll. It's the fact that the things you propose
are completely unrelated to the arguments you give for them ;)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

