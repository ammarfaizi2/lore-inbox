Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265445AbSJaXCf>; Thu, 31 Oct 2002 18:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSJaXCf>; Thu, 31 Oct 2002 18:02:35 -0500
Received: from [195.39.17.254] ([195.39.17.254]:22532 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265445AbSJaXC3>;
	Thu, 31 Oct 2002 18:02:29 -0500
Date: Fri, 1 Nov 2002 00:08:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
Message-ID: <20021031230826.GA9168@elf.ucw.cz>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu> <20021031225729.GD4331@elf.ucw.cz> <1036103335.25512.40.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036103335.25512.40.camel@bip>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This seems like a pretty common situation to me, and current solutions
> > are not nice. [I guess ~/bin/ with --x and
> > ~/bin/my-secret-password-only-jarka-and-mj-knows/phonebook would solve
> > the problem, but...!]
> 
> Can't even this be spied from /proc/*/fd ?

Not sure... Its true that if users are not carefull (i.e. do 

cat ~/bin/my-secret-password-only-jarka-and-mj-knows/phonebook

it can be seen on ps -aux ;-).
							Pavel
-- 
When do you have heart between your knees?
