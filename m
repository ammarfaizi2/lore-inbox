Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278928AbRKXRcv>; Sat, 24 Nov 2001 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278927AbRKXRcc>; Sat, 24 Nov 2001 12:32:32 -0500
Received: from Expansa.sns.it ([192.167.206.189]:24068 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278911AbRKXRcV>;
	Sat, 24 Nov 2001 12:32:21 -0500
Date: Sat, 24 Nov 2001 18:32:12 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Which gcc version?
In-Reply-To: <E167fN7-0002RA-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0111241831000.547-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Daniel Phillips wrote:

> On November 24, 2001 05:01 pm, Luigi Genoni wrote:
> > On Fri, 23 Nov 2001, Anton Altaparmakov wrote:
> > > At 18:30 23/11/01, Daniel Phillips wrote:
> > > >On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> > > > > gcc-3x OTOH is not a good idea at the moment.
> > > >
> > > >Do you have any particular reason for saying that?
> > >
> > > I haven't done any measurements myself but from what I have read, gcc-3.x
> > > produces significantly slower code than gcc-2.96. I know I should try
> > > myself some time... but if that is indeed true that is a very good reason
> > > to stick with gcc-2.96.
> >
> > I did some serious bench.
> > On all my codes, using eavilly floating point computation, binaries
> > built with gcc 3.0.2 are about 5% slower that the ones built with 2.95.3
> > on athlon processor with athlon optimizzations.
> > On the other side, on sparclinux, same codes compiled with gcc 3.0.2 are
> > really faster, about 20%, that with 2.95.3
>
> Interesting, but not as interesting as knowing what the results are for
> non-fp code, since we are talking about kernel compilation.
>
on sparc64 nor gcc 2.95.3 nor 3.0.2 can be used to compile the kernel, at
less for what i know, you have to stay with egcs 64 bit compiler.

