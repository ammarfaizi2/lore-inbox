Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSLUJJo>; Sat, 21 Dec 2002 04:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSLUJJo>; Sat, 21 Dec 2002 04:09:44 -0500
Received: from tornado.reub.net ([203.29.67.170]:5047 "HELO tornado.reub.net")
	by vger.kernel.org with SMTP id <S266842AbSLUJJn>;
	Sat, 21 Dec 2002 04:09:43 -0500
Message-Id: <5.2.0.9.2.20021221201604.03a16110@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 21 Dec 2002 20:17:42 +1100
To: linux-kernel@vger.kernel.org
From: Reuben Farrelly <reuben-linux@reub.net>
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
In-Reply-To: <20021221090642.GD31070@charite.de>
References: <5.2.0.9.2.20021221191530.02ade850@tornado.reub.net>
 <20021221001334.GA7996@werewolf.able.es>
 <20021220114837.GC13591@charite.de>
 <20021220223754.GA10139@werewolf.able.es>
 <20021220225733.GE31070@charite.de>
 <20021221001334.GA7996@werewolf.able.es>
 <5.2.0.9.2.20021221191530.02ade850@tornado.reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Forwarded for the purposes of continuity, Robert is not on lkml]


>Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
>From: Robert Collins <robertc@squid-cache.org>
>To: Reuben Farrelly <reuben-linux@reub.net>
>Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
>X-Mailer: Ximian Evolution 1.0.8
>Date: 21 Dec 2002 20:12:21 +1100
>
>On Sat, 2002-12-21 at 20:06, Ralf Hildebrandt wrote:
> > * Reuben Farrelly <reuben-linux@reub.net>:
> >
> > > No, squid is not br0ken in this fashion.  If squid cannot be allocated
> > > enough memory by the system, it logs a message and _dies_.  Relevant 
> files
> > > to look at in your squid source are squid/lib/util.c for xcalloc() and
> > > xmalloc().
> >
> > Why can't squid allocate more than 1GB on a system with 2GB RAM?
>
>In general, it can.
>Folk run it with up to 2Gb with no special options on linux, all the
>time.
>
>Have you tried asking on the *right* list?
>Or running it under gdb?
>Or getting a stacktrace?
>
>SEGSIGV does *not* mean out of memory, you *may* have hit a genuine bug,
>but it *not* due to squid handling a failed malloc wrongly.
>
>Rob

