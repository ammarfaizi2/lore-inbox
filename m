Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKXQIT>; Sat, 24 Nov 2001 11:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKXQH7>; Sat, 24 Nov 2001 11:07:59 -0500
Received: from dsl-213-023-038-219.arcor-ip.net ([213.23.38.219]:26885 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S278795AbRKXQHu>;
	Sat, 24 Nov 2001 11:07:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Luigi Genoni <kernel@Expansa.sns.it>, Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Date: Sat, 24 Nov 2001 17:09:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: war <war@starband.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111241659120.6855-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0111241659120.6855-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167fN7-0002RA-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 24, 2001 05:01 pm, Luigi Genoni wrote:
> On Fri, 23 Nov 2001, Anton Altaparmakov wrote:
> > At 18:30 23/11/01, Daniel Phillips wrote:
> > >On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> > > > gcc-3x OTOH is not a good idea at the moment.
> > >
> > >Do you have any particular reason for saying that?
> >
> > I haven't done any measurements myself but from what I have read, gcc-3.x
> > produces significantly slower code than gcc-2.96. I know I should try
> > myself some time... but if that is indeed true that is a very good reason
> > to stick with gcc-2.96.
> 
> I did some serious bench.
> On all my codes, using eavilly floating point computation, binaries
> built with gcc 3.0.2 are about 5% slower that the ones built with 2.95.3
> on athlon processor with athlon optimizzations.
> On the other side, on sparclinux, same codes compiled with gcc 3.0.2 are
> really faster, about 20%, that with 2.95.3

Interesting, but not as interesting as knowing what the results are for 
non-fp code, since we are talking about kernel compilation.

--
Daniel
