Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267487AbTALUKk>; Sun, 12 Jan 2003 15:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267490AbTALUKj>; Sun, 12 Jan 2003 15:10:39 -0500
Received: from mail5.home.nl ([213.51.128.16]:5281 "EHLO mail5-sh.home.nl")
	by vger.kernel.org with ESMTP id <S267487AbTALUKe>;
	Sun, 12 Jan 2003 15:10:34 -0500
Subject: Re: [PATCH] add explicit Pentium II support
From: Luuk van der Duim <l.a.van.der.duim@student.rug.nl>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042402432.834.70.camel@phantasy>
References: <Pine.LNX.4.44.0301121125370.14031-100000@home.transmeta.com>
	 <1042402432.834.70.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1042406417.8427.9.camel@cc75757-a.groni1.gr.home.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 12 Jan 2003 22:20:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 21:13, Robert Love wrote:
> On Sun, 2003-01-12 at 14:26, Linus Torvalds wrote:
> 
> > The thing I reacted to was that the P4 entry should include the
> > P4-based celerons. I have no idea what those are called, though.
> > 
> > Anyway, applied.
> 
> I was thinking the same thing, but the lame name of the chips held me
> back - the new Celerons are also called "Celerons".
> 
> Regardless, I updated the comments and I call the new Celerons "P4-based
> Celerons" which should be descriptive enough.
> 
> Patch is against current BK.
> 
> 	Robert Love
> 
>  arch/i386/Kconfig |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
> 
> 
> diff -urN linux-2.5.56/arch/i386/Kconfig linux/arch/i386/Kconfig
> --- linux-2.5.56/arch/i386/Kconfig	2003-01-12 15:05:16.000000000 -0500
> +++ linux/arch/i386/Kconfig	2003-01-12 15:10:45.000000000 -0500
> @@ -120,7 +120,7 @@
>  	  - "Pentium-Pro" for the Intel Pentium Pro.
>  	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
>  	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
> -	  - "Pentium-4" for the Intel Pentium 4.
> +	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.

Aren't those called Willamette based Celerons?

-- 
Luuk van der Duim 

