Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269723AbRHDAEq>; Fri, 3 Aug 2001 20:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269724AbRHDAEg>; Fri, 3 Aug 2001 20:04:36 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:44936 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S269723AbRHDAE2>;
	Fri, 3 Aug 2001 20:04:28 -0400
Message-ID: <3B6B3DE3.CEB608FD@randomlogic.com>
Date: Fri, 03 Aug 2001 17:12:19 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <3B691B85.368D1BD0@randomlogic.com> <3B6939BA.30001@fugmann.dhs.org> <3B693D6F.AD0DB931@randomlogic.com> <3B6A8CEC.1010401@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Peter Fugmann wrote:
> 
> Paul G. Allen wrote:
> 
> > Anders Peter Fugmann wrote:
> [SNIP]
> >>I have an UP system with the AMD761 chipset.
> >>
> >
> > The AMD762 has a different ID and is not recognized (the 761 is 7006,
> > and 762 is 700c), which throws a small wrench into things.
> 
> I'm not shure why. You stated that AGPGART worked with the
> try_unsopported=1 parameter (and that you had hacked the code to accept
> it anyways).

It's better (to me) to have it in the code than to have to add it at module load time. Also, I compiled agpgart into the kernel, not as a module.

> 
> >>
> >>(try look in NVIDIA_kernel-1.0-1251/os-registry.c for more parameters)
> >>
> >
> > I'll take a look, again after the project Database is rebuilt. (Without
> > "Understand for C++" I'd still be quite lost looking through all this
> > code!)
> 
> You do not need C experience to look at that code. It just states all
> possible module parameters in C form, and has a comment to them all.

Sorry for the confusion.

I have plenty of C/C++ experience, but anyone looking at 2M+ lines of sparsely commented source code and trying to get a quick understanding of how things work
needs help.

Understand for C++ is a C/C++ source code browser. It parses a C/C++ source tree and creates documentation that allows easy browsing of call trees, include
trees, declarations, global object usage, and more. It allowed me to quickly find the applicable code and see what was happening. I can even show you a complete
graphic of the entire kernel start sequence from (I hope I remember the function name here) start_kernel to nearly any function thereafter.

The only caveat is sometimes in order to create all this you have to tell Understand which directory to find a header/include file in, and if you're not sure
which is the correct one (in the case of multiple headers of the same name) you could get a little lost when looking at the resulting documentation.

In the case of the above - PCI IDs, AGP support, etc. - I have never looked at any kernel source before and I had no idea even where to start. After running it
through Understand, a couple clicks of a mouse and I can find nearl any object I want and know where it's used and why.


> 
> >
> >
> >>It works like a charm on my machine.
> >>
> >>Btw, if you want to make the NVidia module devfs aware please let me
> >>know and I'll send you a patch.
> >>
> >
> >
> > Hmmm, it might be nice.
> >

> 
> Ill create a patch for it this weekend.
> 

Thanks,

PGA

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043
