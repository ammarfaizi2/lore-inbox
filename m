Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDNPHV>; Sat, 14 Apr 2001 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDNPHL>; Sat, 14 Apr 2001 11:07:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57610 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132387AbRDNPGy>; Sat, 14 Apr 2001 11:06:54 -0400
Date: Sat, 14 Apr 2001 12:06:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <Pine.LNX.4.31.0104140136520.25138-100000@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104141205500.5240-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, Linus Torvalds wrote:
> On Sat, 14 Apr 2001, Adam J. Richter wrote:
> >
> > [...]
> > >If it turns out to be beneficial to run the child first (you
> > >can measure this), why not leave everything the same as it is
> > >now but have do_fork() "switch threads" internally ?
> >
> > 	That is an elegant idea.
>
> I doubt it. It sounds like one of those "cool value" ideas that
> are actually really stupid except they sound cool because you
> have to think about the twists and turns.

You're right.  Time to put a "don't try to think of cool ideas
after going out at night" sign on the wall ;)

cheers,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

