Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267996AbRG2OA6>; Sun, 29 Jul 2001 10:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbRG2OAs>; Sun, 29 Jul 2001 10:00:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:32779 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267996AbRG2OAb>;
	Sun, 29 Jul 2001 10:00:31 -0400
Date: Sun, 29 Jul 2001 11:00:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Lawrence Greenfield <leg+@andrew.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010729020812.D9350@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.33L.0107291058560.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Matthias Andree wrote:
> On Sat, 28 Jul 2001, Rik van Riel wrote:
>
> > > The standard is only useful if it specifies how to get data safely on
> > > disk - it is quite explicit for fsync(), but you evidently cannot
> > > fsync() a link().
> >
> > As Linus said, fsync() on the directory.
>
> Relying on that to work on other operating systems is no better than
> demanding synchronous meta data writes: relying on undocumented
> behaviour.
>
> If we spake about Linux-specific applications, that'd be okay, but we
> speak about portable applications, and the diversity is bigger than
> useful. Speed is not the only problem the OS has to solve.

I guess many MTAs have a small libc inside of them exactly
in order to handle things like this without fouling up the
core code too much.

Time to make your favorite MTA use link_slowly()  ;)

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

