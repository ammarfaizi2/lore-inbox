Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274673AbRIYWyR>; Tue, 25 Sep 2001 18:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274680AbRIYWyH>; Tue, 25 Sep 2001 18:54:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3601 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274673AbRIYWyE>; Tue, 25 Sep 2001 18:54:04 -0400
Date: Tue, 25 Sep 2001 19:54:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Olivier Sessink <olivier@lx.student.wau.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: weird memory related problems, negative memory usage or fake
 memory usage?
In-Reply-To: <20010926003626.L8350@athlon.random>
Message-ID: <Pine.LNX.4.33L.0109251952330.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Andrea Arcangeli wrote:
> On Mon, Sep 24, 2001 at 07:03:20PM -0300, Rik van Riel wrote:
> > On Mon, 24 Sep 2001, Olivier Sessink wrote:

> > >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
> > >  1262 root       5 -10 50764  -1M  1320 S <   2.7 99.9   0:01 XFree86
> >
> > It seems Andrea wasn't careful with the merge and
> > backed out some of the locking wrt mm->rss.
>
> thanks for forwarding this report, actually I just noticed this
> here and that's good so I can reproduce :)
>
> it is possible it is my mistake, but I don't think so, infact I
> don't recall to have changed rss stuff or locking around it.

Mmm, then it could also be one of the bugs which got
fixed in -ac but where Linus never reacted to the
patch, IIRC the RSS thing was indeed fixed around the
time where Linus was in the habbit of silently dropping
half of the patches sent to him...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

