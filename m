Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbSJAR1T>; Tue, 1 Oct 2002 13:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbSJARYy>; Tue, 1 Oct 2002 13:24:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24220 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262499AbSJARYQ>; Tue, 1 Oct 2002 13:24:16 -0400
Date: Tue, 1 Oct 2002 14:29:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
In-Reply-To: <E17wQhL-0005vQ-00@starship>
Message-ID: <Pine.LNX.4.44L.0210011426050.653-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Daniel Phillips wrote:
> On Tuesday 01 October 2002 19:13, Rik van Riel wrote:
> > With one process that needs 150% of RAM as its working set,
> > there simply is no way to win.
>
> True, the object is merely to suck as little as possible.  Note that
> 2.4.xx trounces 2.5.xx rather soundly on the test in question.

Every page replacement system has a worst case, 2.5 is closer to
LRU than 2.4 and it's well possible that the randomisation 2.4
does means we don't trigger the worst case here.

I don't know for sure, but I have a feeling that EVERY algorithm
for page replacement can be tricked into performing worse than
random page replacement for some particular workload.  It might
even be provable ;)

> > > Try loading a high res photo in gimp and running any kind of interesting
> > > script-fu on it.  If it doesn't thrash, boot with half the memory and
> > > repeat.
> >
> > But, should just the gimp thrash, or should every process on the
> > machine thrash ?
>
> Gimp should thrash exactly as much as it needs to, to get its job
> done.  No competition, remember?

No competition ?  I know _I_ don't have a machine dedicated to
gimp and I like to be able to continue listening to mp3s while
the gimp is chewing on a large image...

cheers,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

