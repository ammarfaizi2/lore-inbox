Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRHWUxx>; Thu, 23 Aug 2001 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRHWUxn>; Thu, 23 Aug 2001 16:53:43 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28043
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S270314AbRHWUxc>; Thu, 23 Aug 2001 16:53:32 -0400
Date: Thu, 23 Aug 2001 13:53:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2)
Message-ID: <20010823135318.Z14302@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E15a1IJ-000KjA-00@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15a1IJ-000KjA-00@f10.mail.ru>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 12:41:39AM +0400, Samium Gromoff wrote:

>    1. I heard a lot of arguments why _not_ to include
>   python. Also alot of arguments why _ignore_ the arguments
>   to _not_ include python.
>     BUT! No arguments why to _include_ it...
>   kinda disbalance as i see.

The main reason to include it, is that that's what it was done in.
If you go back and read the archives, ESR goes over why all sorts of
other languages wouldn't work as easily.

>   2. Those who tells that playing with 21M large kernel
>  isnt any better than playing with kernel PLUS 20M
>  python are, politely saying, definitely not right.

That wasn't my point at all.  My point was that if you're somehow
transfering the 21mb source .tar.bz2'ed, you can also stand to transport
the 4mb of python 2.0.1 source, tar.gz'ed over as well.  In other words,
having to bring python over any of the methods that Jes mentioned isn't
any more painful than the kernel source.  It's roughly the size of a couple
of vmlinux'es.

>   3. i ALREADY cannot tolerate how current config
>  heartbrakingly slow crawls on my p166. No, do not ask
>  me why is it so. just think: we have 3k strings, 3k
>  deps, and asketic ncurses interface. So WHY is it so
>  slow? And you think python-powered config engine 
>  will be at least _approachingly_ tolerable on an
>  386??? Nah. It wont.

Have you tried cml2 on your p166?  ESR went and did much speed tweaking of
the code about 6 months ago it seems like and managed to please some of the
people using a low-end pentium.  Building a kernel on a 386 isn't approcaching
tolerable right now anyhow.  Someone pointed out today or yesterday it takes
~10 days.

>  What we win in the true C way: 
>       speed, size

Speed is arguable.  On my p2/333s I didn't notice much of a difference.
On a lower end, yes, you might notice a bit of a slowdown.  But I'm also
one of those people who doesn't plan on running 2.4 on my p100 laptop,
let alone 2.6.

>  What we lose --------=-------:
>       maintainability?????? (i`ll believe if esr will tell so...)

Python is no harder to maintain then C.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
