Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286711AbRLVIMy>; Sat, 22 Dec 2001 03:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbRLVIMo>; Sat, 22 Dec 2001 03:12:44 -0500
Received: from ca-mnet244-12-43.monarch.net ([24.244.12.43]:61704 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286711AbRLVIM2>;
	Sat, 22 Dec 2001 03:12:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Dan Kegel <dkegel@ixiacom.com>
Subject: Re: Linux 2.4.17
Date: Sat, 22 Dec 2001 09:15:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112211744080.7492-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0112211744080.7492-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HhJg-0002Kz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 21, 2001 08:44 pm, Marcelo Tosatti wrote:
> On Fri, 21 Dec 2001, Dan Kegel wrote:
> 
> > Marcelo wrote:
> > 
> > > Well, 
> > > 
> > > Here it is... 
> > > 
> > > 
> > > final:
> > > 
> > > - Fix more loopback deadlocks                   (Andrea Arcangeli)
> > > - Make Alpha with Nautilus chipset and
> > >   Irongate chipset configuration compile
> > >   correctly                                     (Michal Jaegermann)
> > > 
> > > rc2: 
> > > 
> > > - Fix potential oops with via-rhine             (Andrew Morton)
> > > - sysvfs: mark inodes as bad in case of read 
> > > ...
> > 
> > Um, what happened to the idea of 'no changes between the last
> > release candidate and final'?
> 
> I haven't said that, did I? 
> 
> I said I would make -rc kernels which would not add any new _feature_.

I'll weigh in on this one, basically a "me too".  The only changelog entry I 
find unsettling is "Fix more loopback deadlocks" and all I have to say about 
it is: remember what happened when Al fixed the iput bug.  I'm not suggesting 
that there was no basic idiot testing - I'm practically certain you did some 
yourself, but it would have been oh-so-nice to have an rc3 that lived for at 
least a short time on the kernel list before going to final.

By the way, great job managing this first major point release (2.4.16 doesn't 
really count ;-).

--
Daniel
