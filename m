Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318020AbSIJS7S>; Tue, 10 Sep 2002 14:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318022AbSIJS7S>; Tue, 10 Sep 2002 14:59:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63505 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318020AbSIJS7Q>; Tue, 10 Sep 2002 14:59:16 -0400
Date: Tue, 10 Sep 2002 15:16:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Oleg Drokin <green@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k
 at a time)
In-Reply-To: <20020910190950.A1064@namesys.com>
Message-ID: <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 Sep 2002, Oleg Drokin wrote:

> Hello!
>
> On Tue, Sep 10, 2002 at 11:09:38AM -0300, Marcelo Tosatti wrote:
> > >   This patch should only go in if 2.4.20 is 3 weeks or more away,
> > > otherwise it should wait for the next pre1.
> > > It passes all of our testing, but it is the kind of code that is more
> > > likely than most to have elusive lurking bugs.  It cannot be tested in
> > > 2.5 first because 2.5 is too broken at this particular moment.  For the
> > > lkml readers let me say that it also should not go onto any distros
> > > without three weeks of testing.;-)
> > So lets wait for 2.4.21pre for this one.
> > We already have enough stuff to be tested on 2.4.20-pre for reiserfs.
>
> Please pick up at least the fixes from
> bk://thebsh.namesys.com/bk/reiser3-linux-2.4
> I am removed everything related to reiserfs_file_write from there now, so you
> can just do a pull.

Huh, now that I released -pre6 _with_ this stuff by accident its too late.
Silly me.

Can you make me a tree which backouts the big write code please?

Will be releasing a -pre7 shortly due to that.

