Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSGLN23>; Fri, 12 Jul 2002 09:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSGLN22>; Fri, 12 Jul 2002 09:28:28 -0400
Received: from mark.mielke.cc ([216.209.85.42]:13583 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S316390AbSGLN20>;
	Fri, 12 Jul 2002 09:28:26 -0400
Date: Fri, 12 Jul 2002 09:24:42 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Christian Ludwig <cl81@gmx.net>
Cc: Daniel Phillips <phillips@arcor.de>, Ville Herva <vherva@niksula.hut.fi>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: bzip2 support against 2.4.18
Message-ID: <20020712092442.A26797@mark.mielke.cc>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi> <002601c228ab$86b235e0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship> <000901c2296e$7cab2ed0$1c6fa8c0@hyper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000901c2296e$7cab2ed0$1c6fa8c0@hyper>; from cl81@gmx.net on Fri, Jul 12, 2002 at 08:36:41AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 08:36:41AM +0200, Christian Ludwig wrote:
> On 11.07.2001 - 19:21 Daniel Phillips wrote:
> > How about bz2Image, or, more natural in my mind, bz2linux.
> bzImage stands for "big zipped Image". Zipped, in this case, means that it
> is gzipped. Perhaps Linus never wants to support other compression formats
> for the kernel.

> Sure "bz2bzImage" is a bit ugly. I personally would prefer bzImage.bz2,
> although it is some kind of self-extracting executable, thus *.bz2 is also
> not correct. But it would imply better which sort of compression you are
> using. But that also means that the standard kernel has to be called
> "bzImage.gz". I did not want to mess up the standard names...

I would suggest keeping bzImage as the actual kernel name, and the
compression format to be a CONFIG parameter. This leaves all the
installation notes correct. As the executable is self-extracting,
there is no need for the type to be specified outside of the image.

> But the question is: who is responsible for all those naming conventions?
> Does anyone has an idea?

Not me... probably Linus... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

