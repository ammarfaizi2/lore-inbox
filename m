Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTIHTBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTIHTBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:01:52 -0400
Received: from vega.digitel2002.hu ([213.163.0.181]:23439 "HELO lgb.hu")
	by vger.kernel.org with SMTP id S263500AbTIHTAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:00:30 -0400
Date: Mon, 8 Sep 2003 21:00:03 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: nasm over gas?
Message-ID: <20030908190003.GC26619@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
References: <tt0q.6Rc.17@gated-at.bofh.it> <tt0r.6Rc.19@gated-at.bofh.it> <tt0r.6Rc.21@gated-at.bofh.it> <tt0r.6Rc.23@gated-at.bofh.it> <tt0r.6Rc.25@gated-at.bofh.it> <tt0q.6Rc.15@gated-at.bofh.it> <tuIT.TW.7@gated-at.bofh.it> <3F5C9BDA.9080705@softhome.net> <Pine.LNX.4.51.0309081717520.12511@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.51.0309081717520.12511@dns.toxicfilms.tv>
X-Operating-System: vega Linux 2.6.0-test3 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 05:26:51PM +0200, Maciej Soltysiak wrote:
> >    I have a long standing dispute with one of my friend: once he has
> > said 'asm is dead - every one is using C/C++ now'.
> Stating that asm is dead is not realizing that it is really important in
> some niches. Niches which must be in asm to provide the best for the
> customers. This is and will be common in 'programming language wars'.
> 
> Dead technologies are not used. Asm is used, therefore Asm is not dead.
> This is the definition, and the sentence to counter 'asm is dead'.

Assembly can't be dead since it is used as an internal step to produce
machine runnable code eg by gcc. Also, assembly is a very good thing,
eg some coders can code 4K intro with phong shaded rotating 3D objects
etc ;-) But if you see, they spend even months to produce 4K machine
runnable code. No doubt: it's REALLY optimized for both of speed and
size, but you can't do this for commercial softwares, because it is not
portable (if you target more architectures for example), it's longer
to develope and also it's more difficult to maintain. Personally I'm
enjoying coding in asm, and I've done several bigger projects. However
today I would not do this in asm. Not because assembly sucks or whatever,
just because I've not enough free time to do BIG projects in assembly
then maintain it ... But several areas are open, eg my Enterprise-128
emulator being developed using assembly optimized parts and gains
several dozens of percent speed improvement. Of course these routines
are coded in C as well to be able to compile on non-x86 CPUs as well.
I beleive assembly can be very useful when eg a heavily used function
can be coded in assembly for being faster even if it means multiple
rewritings for several CPUs even in the x86 CPU familiy. Eg: if you
can produce more bandwidth by 50% even by coding much more time than in C,
you will be blessed. But it does not mean that the WHOLE system should
be written in assembly ...

> Pascal will be next I think. Or any other language that does not resist
> the trends. C/Java/Python - Those guys are surfing the wave of
> modern programming, and rapid development. Others like cobol, fortran,

C is a good midway between 'very high' level languages and assembly,
at least IMHO. But eg Java will be NEVER my friend, it's a nightmare
to waste system resources (I CAN'T get the idea why some people want
to write an MP3 player in Java for example. Maybe (s)he has got too fast
CPU ...)

- Gábor (larta'H)
