Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbTAXRz5>; Fri, 24 Jan 2003 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTAXRz4>; Fri, 24 Jan 2003 12:55:56 -0500
Received: from mail.netbsd.org ([155.53.1.253]:22265 "HELO mail.netbsd.org")
	by vger.kernel.org with SMTP id <S261427AbTAXRzz>;
	Fri, 24 Jan 2003 12:55:55 -0500
Date: Fri, 24 Jan 2003 10:03:53 -0800 (PST)
From: Bill Studenmund <wrstuden@netbsd.org>
X-X-Sender: <wrstuden@vespasia.home-net.icnt.net>
To: arief_mulya <arief@bna.telkomsel.co.id>
cc: <linux-kernel@vger.kernel.org>, <tech@openbsd.org>,
       <freebsd-hackers@freebsd.org>, <tech-kern@netbsd.org>
Subject: Re: Technical Differences of *BSD and Linux
In-Reply-To: <3E30C2A5.5040502@bna.telkomsel.co.id>
Message-ID: <Pine.NEB.4.33.0301240937270.18483-100000@vespasia.home-net.icnt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, arief_mulya wrote:

> Dear all,
>
>
> I Apologize, If this thread has existed before, and so if
> this is very offtopic and tiredsome for most of you here.
>
> I'm a newbie, and just about to get my feet wet into the
> kernel-code, been using (GNU/)Linux (or whatever the name
> is, I personally don't really care, I caremost at the
> technical excellence) for the last two years, I personally
> think it's a toupper(great); system.
>
> But after recently reviewing some BSD based systems, I began
> to wonder. And these are my questions (I'm trying to avoid
> flame and being a troll here, so if there's any of my
> questions is not on technical basis, or are being such a
> jerk troll please just trash filter my name and email address):

Evidently others opted to not pursue that option.

> 1. In what technical area of the kernel are Linux and *BSD
> differ?
> 2. How does it differ? What are the technical reasoning
> behind the decisions?

They differ in most technical areas. Mainly as the *BSD kernels were
derived from 4.4-Lite, and Linux was derived, I believe, from Minux. The
difference grew since they were developed by differing groups of people.

Within the BSDs, the main focus of each one is different. To put it in
terms of sound bites, FreeBSD wants to make kick-ass servers, NetBSD wants
to support lots & lots of hardware, and OpenBSD is concerned all about
security. That doesn't mean that the others ignore those areas; all three
are interested in security, and being servers, and they all run on more
than just one platform.

There also is a lot of polination between BSDs. Things will show up in one
and then get ported to another.

> 3. Is there any group of developer from each project that
> review each other changes, and tries to make the best code
> out, or is the issues very system specific (something that
> work best on Linux might not be so on FreeBSD or NetBSD or
> OpenBSD)?

Sometimes changes will apply to all, and a comparable fix will happen to
each. This usually shows up in dealing with security advisories, but
happens in other places too. For the most part though, what the BSDs need
is different from what Linux needs, or at least the expertise doesn't
overlap.

> 4. Any chance of merging the very best part of each kernel?
> 5. Or is it possible to do so?

No, I don't forsee merging. der Mouse pointed out the GPL issue, which is
one where I think the BSD and Linux folks will just agree to disagree.

Take care,

Bill

