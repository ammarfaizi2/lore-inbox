Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBXXpz>; Mon, 24 Feb 2003 18:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBXXpz>; Mon, 24 Feb 2003 18:45:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41991 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264699AbTBXXpx>; Mon, 24 Feb 2003 18:45:53 -0500
Date: Mon, 24 Feb 2003 15:51:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andreas Schwab <schwab@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <1046133600.2216.12.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302241549140.1282-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Feb 2003, Alan Cox wrote:
> 
> gcc-3.3 doesnt exist yet. Maybe it wont do that now 8)

Right now there are some other problems with gcc-3.3 too, ie the inlining
is apparently broken enough that we'll either have to start using
__attribute__((force_inline)) or we'd better hope that the gcc people
decide to take the "inline" keyword more seriously (it's being discussed
on the gcc lists, so we'll see)

But yes, these are all obviously with "early versions", and it may be that 
it changes before the real release.

		Linus

