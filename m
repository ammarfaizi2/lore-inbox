Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRJUIg3>; Sun, 21 Oct 2001 04:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275720AbRJUIgT>; Sun, 21 Oct 2001 04:36:19 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:52231 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S275693AbRJUIgF>;
	Sun, 21 Oct 2001 04:36:05 -0400
Envelope-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Message-Id: <a05100314b7f8369cf7cd@[192.168.239.101]>
In-Reply-To: <20011021093728.A17786@vega.digitel2002.hu>
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya>
 <20011021093728.A17786@vega.digitel2002.hu>
Date: Sun, 21 Oct 2001 09:33:34 +0100
To: lgb@lgb.hu
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: The new X-Kernel !
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Boots up with X, that means.
>
>I've never understood why people want X, StarOffice (OpenOffice) etc to be
>moved into kernel space :) IMHO it's strictly user space issue. You can
>start X or gdm/xdm/kdm from a boot script and so on. No kernel modification
>is needed for this.

Probably because they don't know the difference between kernel and 
user space.  Kinda understandable when you come from a Mac or Windows 
background, where (in the former) there is no distinction or (in the 
latter) it's so blurred as to make little difference.

And if they *do* understand it, from a dispassionate point of view, 
it does seem to make sense to put graphics drivers in the kernel - 
they're implemented as "device drivers" in every other desktop OS. 
Except MacOS X, where's it's an application layer like glibc, but 
nobody understand OS X yet beyond the hardest of developers.

But they don't realise that XFree86 has an *enormous* amount of 
developer time behind it, which would need to be duplicated to make 
it work in kernel space with full backwards compatibility.  Oh, and 
did I mention this would all be for one platform - XFree86 is 
designed to run on many!  It would also bloat the kernel tremendously.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
