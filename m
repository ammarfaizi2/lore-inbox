Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSJJKni>; Thu, 10 Oct 2002 06:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSJJKnh>; Thu, 10 Oct 2002 06:43:37 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:35293 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S263333AbSJJKnh>; Thu, 10 Oct 2002 06:43:37 -0400
Date: Thu, 10 Oct 2002 12:49:19 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41-mm1 panics on boot, 2.5.41-vanilla OK
Message-ID: <20021010124918.A1287@cistron.nl>
References: <ao1orf$m2l$1@ncc1701.cistron.net> <3DA47455.6F78E6F1@digeo.com> <20021009224436.A24150@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021009224436.A24150@cistron.nl>; from miquels@cistron.nl on Wed, Oct 09, 2002 at 10:44:36PM +0200
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Miquel van Smoorenburg:
> According to Andrew Morton:
> > Does this fix it?
> > 
> > --- 2.5.41/mm/slab.c~slab-split-10-list_for_each_fix	Tue Oct  8 15:40:52 2002
> > +++ 2.5.41-akpm/mm/slab.c	Tue Oct  8 15:40:52 2002
> 
> Yes, it does fix it.
>
> I'll let you know if tonights expire finishes in 15 minutes
> instead of 15 hours ...

Right, last night the server crashed when running 'expire' (that's
the news server's database update/purge) without anything in the
logs.

The time it ran before that it had significantly less throughput
than 2.4.19 has.

I'd love to tinker with this some more, reproduce the crash,
finetune the throughput, but it is a production server and
I can't keep on letting it crash during the night.

Maybe I'll try once more next week, with a telnet to the
console server in a 'screen' session so I can capture the
panic. Right now I have to lay low for a while, hiding
from my collegues ;)

Mike.
