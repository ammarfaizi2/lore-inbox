Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCHSVp>; Thu, 8 Mar 2001 13:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCHSVg>; Thu, 8 Mar 2001 13:21:36 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:34568 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129393AbRCHSVV>; Thu, 8 Mar 2001 13:21:21 -0500
Date: Thu, 8 Mar 2001 12:14:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Microsoft begining to open source Windows 2000?
Message-ID: <20010308121431.A9687@vger.timpanogas.org>
In-Reply-To: <5.0.2.1.2.20010308162515.00a63a80@pop.cus.cam.ac.uk> <Pine.LNX.4.30.0103081733420.13093-100000@dax.joh.cam.ac.uk > <5.0.2.1.2.20010308174629.00a89ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <5.0.2.1.2.20010308174629.00a89ec0@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Thu, Mar 08, 2001 at 05:53:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 05:53:08PM +0000, Anton Altaparmakov wrote:
> >
> >They do already license the source to a few trusted companies (Executive
> >Software used to ship modified NTFS drivers for NT 3.51 as part of
> >Diskeeper, IIRC). They are inching ever so slowly towards letting human
> >beings (cf MS drones) read their code...

Their code is tough to read due to the use of C++ constructs all through 
their architecture.  You can issue a request to some kernel component of 
NT only to have it raise a software exception that shows up somewhere else
in the kernel code.  Since they use structured excpetion handling all 
over the place, it takes a long time to make sense of just what is 
going on in large sections of their kernel.  Their architecture is 
much more flexible than Linux, but you pay the price in increased 
complexity.  The NWFS file system on W2K was an absolute nightmare
to write and debug, and I could not have done it without their source
code and David from MS helping.  

I'm more suprised they are even showing to customers.  It's so damn 
complex, most of the people they give it to won't be able to make
heads or tails of it.  Linux is a lot easier to read and follow.  The
licence they disclose it under is very strict.  

Giving a W2K customer the source to W2K isn't going to do a single one
of them any good, other than to watch some automated makefiles build 
stuff and maybe boost the customer's egos.  An average W2K customer 
lookinh at the W2K sources would be like Captain Kirk from Star Trek 
forgetting his tricorder on Rigel 7 or something -- in 100 years of so,
the natives might figure our how to make it start a fire or something.
It takes years to understand the subtle behaviors in W2K kernel 
programming, and it doesn't have the mongolian horde following of 
Linux developers.  

MS releasing W2K code to customers is pretty much a non-event in terms
of it causing some meaningful "linux-like explosion" of W2K development.

Jeff 




