Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293525AbSCFNqb>; Wed, 6 Mar 2002 08:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293552AbSCFNqS>; Wed, 6 Mar 2002 08:46:18 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:24324 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S293525AbSCFNpH>;
	Wed, 6 Mar 2002 08:45:07 -0500
Date: Tue, 5 Mar 2002 21:47:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, Rakesh Kumar Banka <Rakesh@asu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Monolithic Vs. Microkernel
Message-ID: <20020305204737.GC318@elf.ucw.cz>
In-Reply-To: <20020304144923.A96@toy.ucw.cz> <Pine.GSO.4.21.0203051533160.18755-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0203051533160.18755-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not *all* of them. On vsta, you could do
> > 
> > ( killall keyboard; sleep 1; keyboard ) &
> > 
> > to change your keymap. On linux you need special tools for managing
> > modules and are not protected from module bugs. Try developing filesystem
> > on production box.... You can do that on u-kernels.
> 
> Userland filesystems != microkernel.

Yep, but microkernel => userland filesystems ;-). Anyway, they *can*
do things linux can't do (or linux has hard time with), like
partitioning physical machine into few logical ones, filesystems in
userland, ability to debug drivers on production machines, etc.

I like those features, but I'm not sure if costs introduced by
u-kernels are worth it.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
