Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131517AbRCNUB1>; Wed, 14 Mar 2001 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRCNUBS>; Wed, 14 Mar 2001 15:01:18 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22540 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131517AbRCNUBG>; Wed, 14 Mar 2001 15:01:06 -0500
Date: Thu, 15 Mar 2001 00:13:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <20010314141944.A27572@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.33.0103150012140.21132-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Jamie Lokier wrote:

> > 2. load control, when the VM starts thrashing we can just
> >    suspend a few processes to make sure the system as a
> >    whole won't thrash to death
>
> Surely it would be easier, and more appropriate, to make the
> processes sleep when they next page fault.

This should work ...

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

