Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265453AbTFVS5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbTFVS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:57:47 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:55243 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S265453AbTFVS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:57:46 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: GCC speed (was [PATCH] Isapnp warning)
Date: Sun, 22 Jun 2003 21:12:45 +0200
User-Agent: KMail/1.5.2
Cc: acme@conectiva.com.br, cw@f00f.org, torvalds@transmeta.com,
       geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk, perex@suse.cz,
       linux-kernel@vger.kernel.org
References: <20030621125111.0bb3dc1c.akpm@digeo.com> <200306221522.29653.phillips@arcor.de> <20030622103251.158691c3.akpm@digeo.com>
In-Reply-To: <20030622103251.158691c3.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306222112.45115.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 June 2003 19:32, Andrew Morton wrote:
> Daniel Phillips <phillips@arcor.de> wrote:
> > As for compilation speed, yes, that sucks.  I doubt there's any rational
> >  reason for it, but I also agree with the idea that correctness and
> > binary code performance should come first, then the compilation speed
> > issue should be addressed.
>
> No.  Compilation inefficiency directly harms programmer efficiency and the
> quality and volume of code the programmer produces.  These are surely the
> most important things by which a toolchain's usefulness should be judged.
>
> I compile with -O1 all the time and couldn't care the teeniest little bit
> about the performance of the generated code - it just doesn't matter.

True, and then gdb works much better as well.  I was really thinking about 
production quality.  Well, I want to have it all, I wonder if the gcc crew 
could come up with a compile speed optimization switch, which produces sucky 
code but does it in record time.

There are many other ways of improving kernel build speed of course.  One of 
the best was to use Keith Owen's kbuild 2.5, which did an impressive job of 
speeding the build up, especially the incremental stuff that matters most to 
developers.  But alas, it died on the horns of politics.

> Compilation inefficiency is the most serious thing wrong with gcc.

If that's the case then it's a good sign I think.

Regards,

Daniel

