Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSEMKeo>; Mon, 13 May 2002 06:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312426AbSEMKen>; Mon, 13 May 2002 06:34:43 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43278 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S312414AbSEMKem>; Mon, 13 May 2002 06:34:42 -0400
Date: Sun, 12 May 2002 18:14:01 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Bill Davidsen <davidsen@tmr.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <87bsbl9ogw.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.44L.0205121812500.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Zlatko Calusic wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> >
> > And should we measure read() waits as well as page faults or
> > just page faults ?
>
> Definitely both.

OK, I'll look at a way to implement these stats so that
every IO wait counts as iowait time ... preferably in a
way that doesn't touch the code in too many places ;)

> Somewhere on the web was a nice document explaining
> how Solaris measures iowait%, I read it few years ago and it was a
> great stuff (quite nice explanation).
>
> I'll try to find it, as it could be helpful.

Please, it would be useful to get our info compatible with
theirs so sysadmins can read their statistics the same on
both systems.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

