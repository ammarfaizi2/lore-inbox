Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTBGShP>; Fri, 7 Feb 2003 13:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBGShP>; Fri, 7 Feb 2003 13:37:15 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:53990 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266297AbTBGShN>; Fri, 7 Feb 2003 13:37:13 -0500
Message-Id: <200302071846.h17Ikmjk003544@eeyore.valparaiso.cl>
To: b_adlakha@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance 
In-Reply-To: Your message of "Fri, 07 Feb 2003 03:31:50 MST."
             <courier.3E438B16.00000E1F@softhome.net> 
Date: Fri, 07 Feb 2003 19:46:48 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

b_adlakha@softhome.net said:
> Neil Booth writes: 
> > b_adlakha@softhome.net wrote:- 
> >> Maybe thats why its a 0.9* version, and the auther has stated on his site 
> >> that not all C98 features are implimented...but then even GCC doesn't 
> >> impliment them...

> > No, I said C89.  He's got a *long* way to go for that.  Forget C99. 

> > However, he does claim C89 compliance, which is quite disingenuous. 

> >> I checked tcc out, and its damn fast, much much much much faster than
> >> gcc. gcc is bloated and its slow even on my pentium 4 machine, let
> >> alone my 1.2 celeron. It takes 20 minutes to compile a new kernel on
> >> that, now if you're gonna test kernels/patches, you can wait 20
> >> minutes for every compile!

Come on, quit whining already. When I started out fooling around with egcs
and the kernel, it took 45 to 60 minutes to build a kernel for me. And the
kernel was a lot smaller, and the compiler much faster.

> > I agree.  I'm trying to fix it. 
> > 
> > GCC is larger for a reason: it does things properly.  It's easy to be
> > fast if you're willing to be wrong, and not emit warnings or errors, and
> > not implement half the standard.  And not optimize. 

> >> Even icc is much better than gcc, but its very perticular about code (and 
> >> its not gcc compatible as the intel site says)
> >> And its non-free also... 

Pour manpower and people who _know_ that _one_ CPU you are targeting in and
out into the project, it sure will get further along...

> > Only better in terms of compile speed.
> 
> Cool (you're trying to fix it), maybe you can modify tcc so it is optimized 
> for compiling linux (optimized for compiling speed and runtime speed for 
> linux).

Sorry, can pick just one. Either you compile very fast (because you don't
analyze the code you are compiling very much, i.e., generate lousy code) or
generate excelent code (that requires complex analysis, large data
structures to build and use, and takes time).

>         I think it'll be easier and quicker to just make it compile linux 
> properly first, then do the testing/fixing for other things, as they are so 
> many compilers for other things anyway...And maybe it can be called "Linux C 
> Compiler"? lol. 

"Easier and quicker" as in 5 or 6 years of hard work. Sure enough, come
back when you're done.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
