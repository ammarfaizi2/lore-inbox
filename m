Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRJUJQh>; Sun, 21 Oct 2001 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRJUJQ1>; Sun, 21 Oct 2001 05:16:27 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:5131 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S275734AbRJUJQT>;
	Sun, 21 Oct 2001 05:16:19 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100316b7f84103696e@[192.168.239.101]>
In-Reply-To: <20011021105056.B17786@vega.digitel2002.hu>
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya>
 <20011021093728.A17786@vega.digitel2002.hu>
 <a05100314b7f8369cf7cd@[192.168.239.101]>
 <20011021105056.B17786@vega.digitel2002.hu>
Date: Sun, 21 Oct 2001 10:13:40 +0100
To: lgb@lgb.hu
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: The new X-Kernel !
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > And if they *do* understand it, from a dispassionate point of view,
>>  it does seem to make sense to put graphics drivers in the kernel -
>>  they're implemented as "device drivers" in every other desktop OS.
>>  Except MacOS X, where's it's an application layer like glibc, but
>>  nobody understand OS X yet beyond the hardest of developers.
>
>:) It would be interesting to learn more on it (if infomartion is available).
>afaik it's a unix like system in its core.

Take a look around Apple's site, particularly the developer section. 
There's documentation in spades if you can read PDFs.  Fact, that's 
one of the best things about Apple - they document nearly everything 
in public view.

>  > But they don't realise that XFree86 has an *enormous* amount of
>>  developer time behind it, which would need to be duplicated to make
>>  it work in kernel space with full backwards compatibility.  Oh, and
>>  did I mention this would all be for one platform - XFree86 is
>  > designed to run on many!  It would also bloat the kernel tremendously.
>
>Also it would be nice if frame buffer can support 3D hw accelerated 
>gfx functions.
>And so on. So probably a better interaction should be implemented between
>various gfx elements of a tipical Linux system. [I don't know GGI very well
>but AFAIK its goals are very interesting]

Come to think of it, the kernel already supports a fair amount of 
video hardware, through framebuffer.  I don't know how capable that 
is, though, beyond displaying and scrolling text in various 
resolutions, and as a place for XFree86 to fall back to.  If fbdev is 
accelerated, some kind of userspace utility and kernel-space cleanup 
would potentially allow fully-accelerated (including 3D?) graphics, 
with much of the hard work in kernel space.  Or is fbdev just a dumb 
framebuffer and I'm totally off track?

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
