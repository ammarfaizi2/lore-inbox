Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319191AbSIJPFL>; Tue, 10 Sep 2002 11:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSIJPFL>; Tue, 10 Sep 2002 11:05:11 -0400
Received: from angband.namesys.com ([212.16.7.85]:9856 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S319191AbSIJPFJ>; Tue, 10 Sep 2002 11:05:09 -0400
Date: Tue, 10 Sep 2002 19:09:50 +0400
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-ID: <20020910190950.A1064@namesys.com>
References: <3D7DF05E.7030903@namesys.com> <Pine.LNX.4.44.0209101108590.16288-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101108590.16288-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 11:09:38AM -0300, Marcelo Tosatti wrote:
> >   This patch should only go in if 2.4.20 is 3 weeks or more away,
> > otherwise it should wait for the next pre1.
> > It passes all of our testing, but it is the kind of code that is more
> > likely than most to have elusive lurking bugs.  It cannot be tested in
> > 2.5 first because 2.5 is too broken at this particular moment.  For the
> > lkml readers let me say that it also should not go onto any distros
> > without three weeks of testing.;-)
> So lets wait for 2.4.21pre for this one.
> We already have enough stuff to be tested on 2.4.20-pre for reiserfs.

Please pick up at least the fixes from
bk://thebsh.namesys.com/bk/reiser3-linux-2.4
I am removed everything related to reiserfs_file_write from there now, so you
can just do a pull.

Thank you.

Bye,
    Oleg
