Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbSIYS7i>; Wed, 25 Sep 2002 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbSIYS7h>; Wed, 25 Sep 2002 14:59:37 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:21635 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262058AbSIYS7h>; Wed, 25 Sep 2002 14:59:37 -0400
Date: Wed, 25 Sep 2002 16:04:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mark Mielke <mark@mark.mielke.cc>
cc: Mark Veltzer <mark@veltzer.org>, Peter Svensson <petersv@psv.nu>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Offtopic: (was Re: [ANNOUNCE] Native POSIX Thread Library 0.1)
In-Reply-To: <20020925145727.B14820@mark.mielke.cc>
Message-ID: <Pine.LNX.4.44L.0209251602170.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Mark Mielke wrote:

> I missed this one. Does this mean that fork() bombs will have limited
> effect on root? :-)

Indeed. A user can easily run 100 while(1) {} loops, but to the
other users in the system it'll feel just like 1 loop...

> I definately want this, even on my home machine. I've always found it
> to be a sort of fatal flaw that per-user resource scheduling did not
> exist on the platforms of my choice.

It has existed since 2.2.14 or so ;)

I just didn't get around to forward-porting it to newer 2.4
kernels, until last weekend.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

