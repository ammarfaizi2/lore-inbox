Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJQRVi>; Thu, 17 Oct 2002 13:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261588AbSJQRVi>; Thu, 17 Oct 2002 13:21:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261556AbSJQRRH>; Thu, 17 Oct 2002 13:17:07 -0400
Date: Thu, 17 Oct 2002 10:25:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Crispin Cowan <crispin@wirex.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210171015440.7066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Oct 2002, Linus Torvalds wrote:
> 
> If people think they can avoid the GPL by using function pointers, they 
> are WRONG. And they have always been wrong.

Side note: it should be noted that legally the GPLONLY note is nothing but 
a strong hint and has nothing to do with the license (and only matters 
for the _enforcement_ of said license). The fact is:

 - the kernel copyright requires the GPL for derived works anyway.

 - if a company feels confident that they can prove in court that their
   module is not a derived work, the GPL doesn't matter _anyway_, 
   since a copyright license at that point is meaningless and wouldn't
   cover the work regardless of whether we say it is GPLONLY or not.

   (In other words: for provably non-derived works, whatever kernel 
   license we choose is totally irrelevant)

So the GPLONLY is really a big red warning flag: "Danger, Will Robinson". 

It doesn't have any real legal effect on th emeaning of the license
itself, except in the sense that it's another way to inform users about
the copyright license (think of it as a "click through" issue - GPLONLY
forces you to "click through" the fact that the kernel is under the GPL
and thus derived works have to be too).

Clearly "click through" _has_ been considered a legally meaningful thing,
in that it voids the argument that somebody wasn't aware of the license.
It doesn't change what you can or cannot do, but it has some meaning for
whether it could be wilful infringement or just honest mistake.

		Linus

