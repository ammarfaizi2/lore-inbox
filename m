Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273163AbRI3I7v>; Sun, 30 Sep 2001 04:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRI3I7c>; Sun, 30 Sep 2001 04:59:32 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:6417 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP
	id <S273144AbRI3I7X>; Sun, 30 Sep 2001 04:59:23 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: safemode <safemode@speakeasy.net>
To: lgb@lgb.hu, Luigi Genoni <kernel@Expansa.sns.it>
Subject: Re: 2 GB file limitation
Date: Sun, 30 Sep 2001 04:59:49 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109290816480.10053-100000@boston.corp.fedex.com> <Pine.LNX.4.33.0109291549180.30595-100000@Expansa.sns.it> <20010930102342.A13042@vega.digitel2002.hu>
In-Reply-To: <20010930102342.A13042@vega.digitel2002.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010930085931Z273144-760+18659@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 September 2001 04:23, Gábor Lénárt wrote:
> On Sat, Sep 29, 2001 at 03:51:53PM +0200, Luigi Genoni wrote:
> > > > ?? slackware 8 has large file support (I've been useing it for a
> > > > while now)
> > >
> > > I think you can get >2GB support if you've Gcc 3.0. Even with the
> > > latest

It's already been posted that the compiler used isn't the issue. You dont 
have to recompile libc with gcc 3.x to get large file support, you just 
enable the non-standard option and compile libc. 

> > ???
> > I am using it and I am using gcc 2.95.3 for normal things,
> > and to compiled my kernel and my libc, because gcc
> > 3.0.1 produces slower binaries on my Athlons (yes, with athlon
> > optimizzations turned on), at less for my programs, and it is better to
> > avoid it for glibc compilation because of back compatibility issues.
>
> Yes, gcc3 is (well at least NOW) a piece of shit. It produces BIGGER and
> SLOWER binaries ... Checked on: Athlon, AMD K6-2.
> With the same gcc command line ...

gcc 3.0.2 produces lame binaries that are 45 seconds faster encoding 
74minutes of audio than the gcc 2.95.4 binaries with the same cflags.   
gcc 2.95.4 produces a binary of 39432 bytes when gcc 3.0.2 with the same 
flags on the same source produces a binary of 37452 bytes.  I then tested it 
with lame.  gcc 2.95.4 produced a binary of 245664 bytes and 3.0.2 produced 
one of 238016 bytes.  Same exact cflags and settings. 
So basically my testing absolutely contradicts your statement.  So who is 
right? 

gcc performance all depends on the code being used, no matter what version 
and both completely on the CFLAGS being used.  Which is why compileable 
benchmarks are so unreliable etc etc.  So enough of the compiler trashing and 
just use whatever makes you happy.  Recompile the entire system with 3.x if 
you want. The backwards incompatibility is not something new to 3.x, it's 
something indicative to gcc throughout it's history.  
