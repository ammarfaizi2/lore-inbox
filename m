Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135413AbRDZOB5>; Thu, 26 Apr 2001 10:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRDZOBr>; Thu, 26 Apr 2001 10:01:47 -0400
Received: from corp1.cbn.net.id ([202.158.3.24]:13833 "HELO corp1.cbn.net.id")
	by vger.kernel.org with SMTP id <S135413AbRDZOBl> convert rfc822-to-8bit;
	Thu, 26 Apr 2001 10:01:41 -0400
Date: Thu, 26 Apr 2001 21:03:40 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
Cc: John Cavan <johnc@damncats.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104261423380.1026-100000@grignard.amagerkollegiet.dk>
Message-ID: <Pine.LNX.4.33.0104262026140.1816-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, [iso-8859-1] Rasmus Bøg Hansen wrote:
> > i'd be happy to accept proof that multi-user is a solution for
> > clueless user, not because it's proven on servers. but because it is
> > a solution by definition.
>
> Let's turn the question the other way. It's you trying to convince
> us, that everyone needs root access. What does a clueless user need root
> access for?

what work around what? right now it's the kernel who thinks that root
is special, and applications work around that because there's a
division of super-user and plain user. is that a must?
it's trivial to say that in multi-user system, one user shall not mess
with other user. in multi-process, a process shall not mess with other
process.
but when it comes to a computer which only has one user, why would
it stop a user. because the kernel thinks it isn't right? if he
felt like killing random process, which is owned by other than the
user, is it a wrong thing to do? he owns the computer, he may do
anything he wants.

and i'm not even trying to convince anyone. communicating is
closer.

>
> And if you really want everybody to have access to all files, you can
> just do a 'chmod 777 /'. Perhaps set it up as a cronjob to run daily?
>

> Besides you write, that a distro shipping single-user is evil. So you
> want the clueless user to recompile his own kernel to enable single-user

iff that distro starts up daemons.


> mode (why do at all call it 'single-user' when you still have different

i wrote somewhere that it was my mistake to call it single-user when i
mean all user has the same root cap, and reduce "user" (account) to
"profile".


		imel



