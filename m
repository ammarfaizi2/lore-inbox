Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131389AbRCHNqu>; Thu, 8 Mar 2001 08:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131388AbRCHNqb>; Thu, 8 Mar 2001 08:46:31 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43503 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131387AbRCHNqY>; Thu, 8 Mar 2001 08:46:24 -0500
Date: Thu, 8 Mar 2001 10:44:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Boris Dragovic <lynx@falcon.etf.bg.ac.yu>
cc: Oswald Buddenhagen <ob6@inf.tu-dresden.de>, <linux-kernel@vger.kernel.org>
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.20.0103081427040.3785-100000@falcon.etf.bg.ac.yu>
Message-ID: <Pine.LNX.4.33.0103081043550.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Boris Dragovic wrote:

> > did "these" apply only to the tasks, that actually hold a lock?
> > if not, then i don't like this idea, as it gives the processes
> > time for the only reason, that it _might_ hold a lock. this basically
> > undermines the idea of static classes. in this case, we could actually
> > just make the "nice" scale incredibly large and possibly nonlinear,
> > as mark suggested.
>
> would it be possible to subqueue tasks that are holding a lock
> so that they get some guaranteed amount of cpu and just leave
> other to be executed when processor really idle?

Of course. Now we just need the code to determine when a task
is holding some kernel-side lock  ;)

regrads,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

