Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbSLRSeK>; Wed, 18 Dec 2002 13:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267336AbSLRSeK>; Wed, 18 Dec 2002 13:34:10 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:27145 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S267335AbSLRSeJ>; Wed, 18 Dec 2002 13:34:09 -0500
Message-Id: <200212181841.gBIIfd0I008213@pincoya.inf.utfsm.cl>
To: Dave Jones <davej@codemonkey.org.uk>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance 
In-Reply-To: Message from Dave Jones <davej@codemonkey.org.uk> 
   of "Wed, 18 Dec 2002 16:41:19 -0000." <20021218164119.GC27695@suse.de> 
Date: Wed, 18 Dec 2002 15:41:39 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> said:
> On Wed, Dec 18, 2002 at 10:40:24AM -0300, Horst von Brand wrote:
>  > [Extremely interesting new syscall mechanism tread elided]
>  > 
>  > What happened to "feature freeze"?

> *bites lip* it's fairly low impact *duck*.
> Given the wins seem to be fairly impressive across the board, spending
> a few days on getting this right isn't going to push 2.6 back any
> noticable amount of time.

Ever hear Larry McVoy's [I think, please correct me if wrong] standard
rant of how $UNIX_FROM_BIG_VENDOR sucks, one "almost unnoticeable
performance impact" feature at a time? 

Similarly, Fred Brooks tells in "The Mythical Man Month" how schedules
don't slip by months, they slip a day at a time...

> This stuff is mostly of the case "it either works, or it doesn't".
> And right now, corner cases like apm aside, it seems to be holding up
> so far. This isn't as far reaching as it sounds. There are still
> drivers being turned upside down which are changing things in a
> lot bigger ways than this[1]
> 
> 		Dave
> 
> [1] Myself being one of the guilty parties there, wrt agp.

Fixing a broken feature is in for me. Adding new features is supposed to be
out until 2.7 opens.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
