Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318184AbSHPX1E>; Fri, 16 Aug 2002 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSHPX1E>; Fri, 16 Aug 2002 19:27:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318184AbSHPX1E>; Fri, 16 Aug 2002 19:27:04 -0400
Date: Fri, 16 Aug 2002 16:34:14 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE?
In-Reply-To: <200208170058.39227.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0208161622240.1674-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Marc-Christian Petersen wrote:
> 
> I am beside my self with laughing, sorry :P
> 
> I really can imagine what are you dreaming of. Like:

Actually, you apparently can't.

I'm dreaming of an IDE maintainer that people (including, very much, me)
can work with. I don't know why, but IDE has pretty much since day one
been a fairly problematic area, and has caused a lot more maintainer
headache than the rest of the kernel put together..

There's been one fairly smooth IDE transition (the original transition
from hd.c to ide.c), and calling even that "smooth" is pretty much all
hindsight - at the time people thought it was horribly stupid to not allow
big controversial changes to hd.c, and the resulting code duplication was
considered a disaster.

Right now it looks like Alan is at least for the moment willing to work on
the IDE code, which is obviously great. I just wonder how long he'll stand
it (he's maintained various IDE buglists etc issues for years, so we can
hope).

			Linus

