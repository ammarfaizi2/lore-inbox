Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269018AbRHMAVe>; Sun, 12 Aug 2001 20:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHMAVY>; Sun, 12 Aug 2001 20:21:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:4369 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269018AbRHMAVN>;
	Sun, 12 Aug 2001 20:21:13 -0400
Date: Sun, 12 Aug 2001 21:21:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
In-Reply-To: <9l70hc$1sd$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108122112090.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Linus Torvalds wrote:

> Word of warning: there are some loads on which 2.4.7 will simply lock
> up.  If you don't want to take all the new code, at least take the
> changes to fs/buffer.c and refill_buffer() or whatever.

I'll do my best to merge some of the obviously correct
pieces of VM code from -linus to -ac.

> That said, me and Marcelo are still working on making sure it's good
> under _all_ loads..

I wonder how much you'd be willing to give up in the
common case in order to prevent the system from falling
over under strange loads. Hypothetically speaking, that
is, I don't really have anything in mind yet ;)

cheers,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

