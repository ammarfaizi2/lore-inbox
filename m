Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278685AbRKXQCj>; Sat, 24 Nov 2001 11:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278795AbRKXQC3>; Sat, 24 Nov 2001 11:02:29 -0500
Received: from Expansa.sns.it ([192.167.206.189]:45069 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278685AbRKXQCQ>;
	Sat, 24 Nov 2001 11:02:16 -0500
Date: Sat, 24 Nov 2001 17:01:55 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Daniel Phillips <phillips@bonn-fries.net>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Which gcc version?
In-Reply-To: <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0111241659120.6855-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Nov 2001, Anton Altaparmakov wrote:

> At 18:30 23/11/01, Daniel Phillips wrote:
> >On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> > > At 13:51 23/11/01, war wrote:
> > > >You should use gcc-2.95.3.
> > >
> > > That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
> > >
> > > gcc-3x OTOH is not a good idea at the moment.
> >
> >Do you have any particular reason for saying that?
>
> I haven't done any measurements myself but from what I have read, gcc-3.x
> produces significantly slower code than gcc-2.96. I know I should try
> myself some time... but if that is indeed true that is a very good reason
> to stick with gcc-2.96.
>
I did some serious bench.
On all my codes, using eavilly floating point computation, binaries
built with gcc 3.0.2 are about 5% slower that the ones built with 2.95.3
on athlon processor with athlon optimizzations.
On the other side, on sparclinux, same codes compiled with gcc 3.0.2 are
really faster, about 20%, that with 2.95.3

Luigi


