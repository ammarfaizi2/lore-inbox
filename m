Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288727AbSADTZB>; Fri, 4 Jan 2002 14:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288728AbSADTYw>; Fri, 4 Jan 2002 14:24:52 -0500
Received: from mustard.heime.net ([194.234.65.222]:58035 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288727AbSADTYg>; Fri, 4 Jan 2002 14:24:36 -0500
Date: Fri, 4 Jan 2002 20:24:30 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Craig Knox <crg@monster.gotadsl.co.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <1010169142.2030.37.camel@crgs.lowerrd.prv>
Message-ID: <Pine.LNX.4.30.0201042022330.30434-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Jan 2002, Craig Knox wrote:

>
> > do you know how I can fix it?
>
> Whoops sorry for that blank reply.
> I downloaded the source and it compiles and has no unresolved symbols.
> (version 3.6.8).
>
> Do you do a "make clean dep" when rebuilding your kernel.  Does
> /usr/include/linux point to /usr/src/linux/include/linux?
>

Yes.
The default Mandrake 8.1 installation had a separate /usr/include/linux,
but I renamed it and made a symlink.

I just did a make dep clean bzImage modules modules_install, installed the
new kernel in lilo rebooted, recompiled the e1000 driver, but still the
same problem.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

