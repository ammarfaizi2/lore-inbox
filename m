Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRLULqE>; Fri, 21 Dec 2001 06:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279778AbRLULpz>; Fri, 21 Dec 2001 06:45:55 -0500
Received: from hal.grips.com ([62.144.214.40]:43235 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S279307AbRLULpi>;
	Fri, 21 Dec 2001 06:45:38 -0500
Message-Id: <200112211144.fBLBivK06638@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: Dan Kegel <dank@kegel.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: aio
Date: Fri, 21 Dec 2001 12:44:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20011219171631.A544@burn.ucsd.edu> <20011219.184527.31638196.davem@redhat.com> <3C220ED2.F5B01AD4@kegel.com>
In-Reply-To: <3C220ED2.F5B01AD4@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 December 2001 17:16, Dan Kegel wrote:
> "David S. Miller" wrote:
> > If AIO was so relevant+sexy we'd be having threads of discussion about
> > the AIO implementation instead of threads about how relevant it is or
> > is not for the general populace.  Wouldn't you concur?  :-)
> >
> > The people doing Java server applets are such a small fraction of the
> > Linux user community.
>
> reason AIO is important is to make it easier to port code from NT.
>
> but I firmly believe that some form of AIO is vital.
>
> - Dan

>From the aio-0.3.1/README
section Current State

  IPv4 TCP and UDP (rx only) sockets.

It is simply too early for sexy discussions. For me, the most appealing part 
of AIO is the socket handling. It seems a little bit broken in the current 
glibc emulation/implementation.
Recv and send operations are ordered when used on the same socket handle.
Thus a recv must be finished before a subsequent send will happen.
Good idea for files, bad for sockets.

SGI's implementation kaio, which works perfect for me, is widespread ignored 
and sufferes from the unreserved syscall problem like Ben's aio. I am sure 
there is a reason for ignoring SGI-kaio, i just do not remember.

With the current state of the different implementations it is difficult to 
have sex about or use them.
But i would really like tooooooooooooooooooo.

Gerold

-
The one-sig-perfd patch did not get much attention either.
No one seems to use sockets these days.
