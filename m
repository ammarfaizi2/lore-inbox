Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUBNWHe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUBNWHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 17:07:34 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:58255 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263787AbUBNWH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 17:07:27 -0500
Date: Sat, 14 Feb 2004 23:07:26 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dan Kegel <dank@kegel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
Message-ID: <20040214220726.GA13479@MAIL.13thfloor.at>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	linux-kernel@vger.kernel.org
References: <402E8D1A.4000106@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402E8D1A.4000106@kegel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 01:03:22PM -0800, Dan Kegel wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >I'm currently investigating the requirements/doability
> >of a kernel cross compiling test bed/setup, able to do
> >automated kernel builds for different architecture,
> >just to see if it compiles and later to verify if a 
> >given patch breaks that compile on any of the tested
> >archs ...
> 
> Great idea!
> 
> > I decided to use binutils 2.14.90.0.8, and gcc 3.3.2,
> >   but soon discovered that gcc-3.3.2 will not be able 
> >   to build a cross compiler for some archs like the
> >   alpha, ia64, powerpc and even i386 ;) without some
> >   modifications[2] but with some help, I got all headers
> >   fixed, except for the ia64, which still doesn't work
> 
> Wouldn't it be easier to use http://kegel.com/crosstool
> which already builds good toolchains for just about every
> CPU type?

yeah Dan, I thought about that, and I guess I'll
give that _another_ try soon, the reason I didn't
choose that path, simply was, that I didn't want
to compile the (g)libc, because I really do not 
need it at all (kernel does not use/require that)
and I didn't want to deal with that one too ...

btw, what archs did you verify? didn't find a 
'success' list or something like that, probably
missed it somehow, anyway, currently I managed
to compile binutils and gcc for:

 alpha, arm, cris, hppa/64, i386, ia64, m68k,
 mips/64, ppc/64, s390, sh/4, sparc/64, v850,
 x86_64 ...

TIA,
Herbert

> - Dan
> 
> -- 
> US citizens: if you're considering voting for Bush, look at these first:
> http://www.misleader.org/
> http://www.cbc.ca/news/background/arar/
> http://www.house.gov/reform/min/politicsandscience/
