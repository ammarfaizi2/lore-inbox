Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286075AbRLHXm5>; Sat, 8 Dec 2001 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286072AbRLHXmn>; Sat, 8 Dec 2001 18:42:43 -0500
Received: from mta02bw.bigpond.com ([139.134.6.34]:61413 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S286074AbRLHXl1>; Sat, 8 Dec 2001 18:41:27 -0500
Date: Sat, 8 Dec 2001 21:46:31 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5
Message-Id: <20011208214631.75573e9a.rusty@rustcorp.com.au>
In-Reply-To: <E16C8Zk-0003if-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.33.0112070033450.4486-100000@Appserv.suse.de>
	<E16C8Zk-0003if-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 00:09:12 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > Actually that one is  various Intel people not me 8)
> > 
> > Wouldn't it be better to see such things proven right in 2.5 first ?
> 
> o	2.5 isnt going to be usable for that kind of thing in the near future
> o	There is no code that is "new" for normal paths (in fact Marcelo
> 	wanted a change for the only "definitely harmless" one there was)

The sched.c change is also useless (ie. only harmful).  Anton and I looked at
adapting the scheduler for hyperthreading, but it looks like the recent 
changes have had the side effect of making hyperthreading + the current
scheduler "good enough".  If someone wants an in-depth analysis of (1) what
is required to make the "right" decision for hyperthread scheduling with the
current scheduler (much more than the current wedge) and (2) why it doesn't
really matter anyway, please ask.

Anton, can you put the dbench graphs somewhere public?

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
