Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSFJVHN>; Mon, 10 Jun 2002 17:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSFJVFg>; Mon, 10 Jun 2002 17:05:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35333 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316300AbSFJVCJ>; Mon, 10 Jun 2002 17:02:09 -0400
Date: Mon, 10 Jun 2002 16:57:13 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
In-Reply-To: <Pine.LNX.4.10.10206081305390.1190-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1020610164828.23851A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002, Andre Hedrick wrote:

> 
> Because there is an entire set of new calls to deal with cfa or flash.
> It really takes a new subdriver.

Could you clarifiy that to either (a) "the kernel is now broken
completely for CF," (b) "use the non-kernel 3.1.33 pcmcia," or (c) "use
XXX." It's not clear to me if you are stating that CF no longer works at
all, not longer works with taskfile, no longer works but pcmcia separate
modules do, or that I need some other software "new subdriver" not in the
kernel or pcmcia package.

I'm not matching any of those to uni laptops working with kernel plus OLD
pcmcia support for pcmcia in kernel, and SMP not working with any
combination of recent kernel (plain, -jam, -ac, -aa, with patches, etc)
and any pcmcia.
 
> On Tue, 4 Jun 2002, Bill Davidsen wrote:
> 
> > On Wed, 29 May 2002, Nick Evgeniev wrote:

> > > I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
> > > filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
> > > little bit better though every 5-8 hours I've got ide errors in log (at
> > > least it didn't crash my reiserfs volumes yet):
> > 
> > I see a lot of the 0x58 with taskfile enabled, are you doing that? I even
> > see it mounting an "IDE" compact flash! I ran out of time to try w/o
> > taskfile_io.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


