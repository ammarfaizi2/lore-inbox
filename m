Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316854AbSEWQBq>; Thu, 23 May 2002 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSEWQBp>; Thu, 23 May 2002 12:01:45 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:34063 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316854AbSEWQBo>; Thu, 23 May 2002 12:01:44 -0400
Date: Thu, 23 May 2002 18:01:36 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kb25 manual [was Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers in the kernel?]
Message-ID: <20020523160136.GC24260@louise.pinerecords.com>
In-Reply-To: <20020523154252.GA24260@louise.pinerecords.com> <Pine.LNX.4.33L2.0205230850080.4119-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 19:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | > BTW> one of the reasons I never bothered myself with kbuild-2.5
> | > is for example that nio matter how frequently Keith
> | > is advertising it - every time I go there to have a look at it
> | > at sf what I find is a scatter heap of .tar.gz. The documentation
> | > about how to install it makes me nervous, since I would
> | > rather just expect a diff and a README how to use it, so I never
> | > look after it.
> |
> | Duh... All you need is the core package (diff #1), the architecture
> | independent modifications package (diff #2) and finally diff #3 that
> | adds the arch-specific stuff. Everything's in a single list on sf.
> |
> | then just do s/t like
> | cd /usr/src/linux-2.4.19-pre8 && zcat \
> | 	../kbuild-2.5-core-14.gz \
> | 	../kbuild-2.5-common-2.4.19-pre8-1.gz \
> | 	../kbuild-2.5-i386-2.4.19-pre8-1.gz \
> | 	| patch -sp1
> |
> | and read the comprehensive manual in Documentation/kbuild/
> |
> | What's there to be nervous about?
> 
> so there should just be a short, simple readme about how to
> install and use it -- not one that is 2400 lines long.
> Other than that, I like it.

How about submitting one to Keith yourself then? :)

No really, I don't think there's a problem with the manual.
If you just want to learn how to compile a kernel, you can
skim thru the first section of the file in under 30 seconds.

> Other than that, I like it.

Who doesn't. I mean, apart from Wayne Brown who hates to have
to remember to issue simpler commands. ;)


T.
