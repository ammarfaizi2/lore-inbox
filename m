Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSE2XHC>; Wed, 29 May 2002 19:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315693AbSE2XHB>; Wed, 29 May 2002 19:07:01 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:35589 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312558AbSE2XHA>; Wed, 29 May 2002 19:07:00 -0400
Date: Thu, 30 May 2002 01:06:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-ID: <20020529230657.GB2851@louise.pinerecords.com>
In-Reply-To: <3CF540F8.6000802@mandrakesoft.com> <Pine.LNX.4.44.0205291827130.23147-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9/sparc SMP
X-Uptime: 3:14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> > he wanted an evolution to a new build system... not an unreasonable 
> > request to at least consider.  Despite Keith's quality of code (again -- 
> > I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> > very "take it or leave it dammit".  Not the best way to win friends and 
> > influence people.
> > 
> > If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
> > work with Kai to integrate it into 2.5.x.
> 
> When I suggested to Keith he push kbuild25 the way Linus likes, he (Keith) 
> considered that was a "stupid comment" and that he'd ignore stupid comments.

What remains to be answered is, how does one split a system of a myriad of
build rule files into a reasonable amount of small patches.

Of course, you could have hundreds of patches each consisting of a single
Makefile.in, but how would that make the reviewing/integrating easier? In
the end you'd end up reading the same input, only you'd complement it by
frequently pressing your favorite show-me-the-next-mail key.

The solution here is not to create "artificial splitting," but rather spare
the good ol' system for the time being and have kbuild25 coexist with it until
all build issues are resolved and everything works acceptably -- and that's
what has been offered. 2.5 is certain to span a long enough period for such
treatment, and Keith will be so kind as to keep updating his work.

Alright I really didn't want to get involved in another kbuild thread but
couldn't help it. Sorry.


T.
