Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315725AbSE2XWk>; Wed, 29 May 2002 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSE2XWj>; Wed, 29 May 2002 19:22:39 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:7323 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315725AbSE2XWi>; Wed, 29 May 2002 19:22:38 -0400
Date: Wed, 29 May 2002 16:22:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - What's up with the kernel build?
Message-ID: <20020529232228.GX5997@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0205291519270.9971-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 03:22:52PM -0500, Kai Germaschewski wrote:

> >>> It's possible with only small changes to provide a quiet mode now,
> >>> which would not print the entire command lines but only
> >>>
> >>>	  Descending into drivers/isdn/kcapi
> >>>	  Compiling kcapi.o
> >>>	  Compiling capiutil.o
> >>>	  Linking kernelcapi.o
> >>>	  ...
> >>>
> >>> Is that considered useful?

I don't think so.  If you're on a slow connection or something, redirect
stdout to a log and watch stderr.  If you just want something prettier,
and this is easy, I don't think this is a bad thing.  I don't think it
should be the default tho either. :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
