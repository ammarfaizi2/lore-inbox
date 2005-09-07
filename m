Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVIGK6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVIGK6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVIGK6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 06:58:43 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:16798 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S932073AbVIGK6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 06:58:42 -0400
Date: Wed, 7 Sep 2005 12:58:36 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Valdis.Kletnieks@vt.edu
Cc: Jesper Juhl <jesper.juhl@gmail.com>, "Budde, Marco" <budde@telos.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: <200509071011.j87ABcWT018168@turing-police.cc.vt.edu>
Message-Id: <Pine.OSF.4.05.10509071245490.21532-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Sep 2005 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 07 Sep 2005 11:21:42 +0200, Esben Nielsen said:
> 
> > I use a RTOS written in plain C but where you can easily use C++ in kernel
> > space (there is no user-space :-). We use gcc by the way.
> 
> This isn't RTOS, in case you haven't noticed. ;)
Well, with Ingo's preempt-RT patch it is becomming a RT-OS, but that is
not the issue here.

> 
> > It has been done for Linux as well 
> > (http://netlab.ru.is/pronto/pronto_code.shtml). Why can't this kind of
> > stuff be merged into the kernel? Why is there no efford to do so??
> 
> Quoting http://netlab.ru.is/exception/LinuxCXX.shtml:
> 
> "The code is installed by applying a patch to the Linux kernel and enables the
> full use of C++ using the GNU g++ compiler. Programmers that have used C++ in
                                                                    ^^^^  

> Linux kernel modules have primarily been using classes and virtual functions,
> but not global constructors. dynamic type checking and exceptions. Using even
> this small part of C++ requires each programmer to write some supporting
> routines. Using the rest of C++ includes porting the C++ ABI that accompanies
> GNU g++ to the Linux kernel, and to enable global constructors and destructors."
> 
> So let's see - no constructors, no type checking, no exceptions, and using
> virtual functions requires the programmer to write the glue code that
> programmers want to use C++ to *avoid* writing.  Sounds like "We stripped out
> all the reasons programmers want to use C++ just so we can say we use C++ in
> the kernel".
> 
> So, other than wank value, what *actual* advantages are there to using this
> limited subset of C++ in the kernel?
> 

If you cared to read the whole page you will notice that they talk about
the _past_. They have as I understand the page, they claim to have _fixed_
the problems.

Esben

