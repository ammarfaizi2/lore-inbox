Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbSKQDMQ>; Sat, 16 Nov 2002 22:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbSKQDMQ>; Sat, 16 Nov 2002 22:12:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8462 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267440AbSKQDMP>; Sat, 16 Nov 2002 22:12:15 -0500
Date: Sat, 16 Nov 2002 19:19:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
In-Reply-To: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Nov 2002, Alan Cox wrote:
> 
> And in the real world you end up back with TCP. Been there, done that
> with network debugger tools before.

.. and we have another "been there, done that" that says UDP works fine.

I also dislike overdesign with a passion. I'll believe we have to go to
TCP when I see it - and even if that happens, I think we should do the UDP
case first just to avoid having a monster ("start off simple, and evolve"  
as opposed to "try to get it right the first time").

		Linus

