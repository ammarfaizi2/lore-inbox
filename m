Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULFR3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULFR3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbULFR3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:29:04 -0500
Received: from alog0305.analogic.com ([208.224.222.81]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261580AbULFR25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:28:57 -0500
Date: Mon, 6 Dec 2004 12:27:28 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Imanpreet Singh Arora <imanpreet@gmail.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: What if? 
In-Reply-To: <200412052243.iB5Mh5SG006136@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0412061223010.18932@chaos.analogic.com>
References: <200412052243.iB5Mh5SG006136@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2004, Horst von Brand wrote:

> Kyle Moffett <mrmacman_g4@mac.com> said:
>> On Dec 04, 2004, at 19:23, Horst von Brand wrote:
>>> ... And pointless, you'd just get Linux as it stands
>>> today, and loose many current developers (due to unfamiliarity with
>>> C++).
>
>> Personally, the reason _I_ hate C++ is that I got tired of having to
>> learn the obtuse combinations of symbols and excess keywords necessary to
>> bludgeon my favorite refcount and memory management systems into the C++
>> objects.  It just wasn't worth the effort when I could write equivalent,
>> better, and easier to read code in C.
>
> C++ is sufficiently not C that for such it is probably best to just
> redesign the systems. Well done it is probably more elegant than C, but to
> get there is a _lot_ of work.
> -- 
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

There is another problem. The kernel requires a procedural language
to communicate with hardware. Interface with hardware is all about
the step-by-step methods necessary to make hardware run. C++ tries
to isolate one from the actual methods involved. That's what it
was designed for.

One would need to use "extensions" just to get text to the screen.
'C' being an "smart" assembler, is nearly ideal for kernel
development.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
