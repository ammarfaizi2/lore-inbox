Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317800AbSFMTMJ>; Thu, 13 Jun 2002 15:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317801AbSFMTMJ>; Thu, 13 Jun 2002 15:12:09 -0400
Received: from [195.39.17.254] ([195.39.17.254]:39843 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317800AbSFMTMH>;
	Thu, 13 Jun 2002 15:12:07 -0400
Date: Wed, 12 Jun 2002 17:17:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020612171708.B87@toy.ucw.cz>
In-Reply-To: <3D059D5E.C9F9F659@zip.com.au> <11378.1023779257@kao2.melbourne.sgi.com> <3D05A6A1.328B7FDE@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >It is specifically referring to updates via mmap!  "a write reference
> > >to the mapped region".  This is the mmap documentation.
> > 
> > I saw "write reference" and my brain translated that to "write()".  I
> > blame the long weekend.
> 
> That'll be a left-brain/write-brain thing.
> 
> I think it's too late to fix this in 2.4.  If we did, a person
> could develop and test an application on 2.4.21, ship it, then
> find that it fails on millions of 2.4.17 machines.

It is a bug, so it should be fixed. If someone develops on FreeBSD then
he'll be surprised it does not work on Linux... Stable should mean "only
bugfixes" and this certainly looks like a bug.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

