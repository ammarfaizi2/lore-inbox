Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135909AbRDZUtR>; Thu, 26 Apr 2001 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135911AbRDZUs5>; Thu, 26 Apr 2001 16:48:57 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:58891 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S135909AbRDZUsq>; Thu, 26 Apr 2001 16:48:46 -0400
Date: Thu, 26 Apr 2001 22:47:49 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <imel96@trustix.co.id>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104262026140.1816-100000@tessy.trustix.co.id>
Message-ID: <Pine.LNX.4.33.0104262222500.5306-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001 imel96@trustix.co.id wrote:

>
> On Thu, 26 Apr 2001, [iso-8859-1] Rasmus Bøg Hansen wrote:
> > > i'd be happy to accept proof that multi-user is a solution for
> > > clueless user, not because it's proven on servers. but because it is
> > > a solution by definition.
> >
> > Let's turn the question the other way. It's you trying to convince
> > us, that everyone needs root access. What does a clueless user need root
> > access for?
>
> what work around what? right now it's the kernel who thinks that root
> is special, and applications work around that because there's a
> division of super-user and plain user. is that a must?

Basically yes. But if you do not want _any_ security - you can drop it.
I started using Linux (and unix in general) in '96 (thanks Linus). And
now - feelin like an experienced linux (unix) user I feel more like
ever, I do _not_ want to be root

You do not understand the unix security aspects. You do not want unix
security and do not want unix. Then stop using it. People from redmond
allow you to trash your system without any special effort.

Stop bugging us. Have you noticed you never got response from Linus? He
is probably still laughing (or feeling pissed off) - Stop trashing his
(good) work, I know he is not the only one (I thank every Linux
developer)... Did you ever realize, that the unix security model hasn't
changed radically for 30 years? Beacause what? It is (opposite your
patch) mostly good.

> it's trivial to say that in multi-user system, one user shall not mess
> with other user. in multi-process, a process shall not mess with other
> process.

Ok. If you want to fuck up other people's processes, do it. Kill init
and get strange panics. If you want to crash other people's work, do
it. But begone from _my_ box!!!! Go to a bar and get drunk (as you do
not seem to have anything better to use your time for),.

> but when it comes to a computer which only has one user, why would
> it stop a user. because the kernel thinks it isn't right? if he
> felt like killing random process, which is owned by other than the
> user, is it a wrong thing to do? he owns the computer, he may do
> anything he wants.

Yeah. If he wants to do that he logs in as root. 'killall -1'? 'dd
if=/dev/zero of=/dev/kcore'. Yeah, crash your computer if you want. But
the 'clueless user does not want to'!

> and i'm not even trying to convince anyone. communicating is
> closer.

Who are you not trying to convince? You propose a patch - you try to
convince us to drop the unix secuity model...

> > And if you really want everybody to have access to all files, you can
> > just do a 'chmod 777 /'. Perhaps set it up as a cronjob to run daily?
>
> > Besides you write, that a distro shipping single-user is evil. So you
> > want the clueless user to recompile his own kernel to enable single-user
>
> iff that distro starts up daemons.

Or the user starts up daemons. He has root privileges after all.

> > mode (why do at all call it 'single-user' when you still have different
>
> i wrote somewhere that it was my mistake to call it single-user when i
> mean all user has the same root cap, and reduce "user" (account) to
> "profile".

Ok. My mistake. You want to use 'user profiles' but not use the
advantages...

You don't have to. You can use Windows if you want to. You can just use
root. As long as you do not hack /sbin/login or xdm, you will still have
to type login/password - no win, no gain.

If it wasn't for the nips, being so good at bulding ships
the yards would still be open in the clyde

get out to a war and get shot!

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
I don't suffer from insanity, i enjoy every minute of it!
--------------------------------- [ moffe at amagerkollegiet dot dk ] -

