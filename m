Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316590AbSEUUhk>; Tue, 21 May 2002 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSEUUhj>; Tue, 21 May 2002 16:37:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:64665 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316590AbSEUUhi>;
	Tue, 21 May 2002 16:37:38 -0400
Date: Fri, 17 May 2002 00:00:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020517000033.F116@toy.ucw.cz>
In-Reply-To: <E179HWb-0000jY-00@wagner.rustcorp.com.au> <Pine.LNX.4.44.0205182210330.878-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> However, that apparently flies in the face of UNIX history and apparently
> some standard (whether it was POSIX or SuS or something else, I can't
> remember, but that discussion came up earlier..)

As far as I can remember, discussion was that standards *do* allow that.
I actually ran my system with -EFAULT -> SIGSEGV [it is one-liner!] and
it worked perfectly well.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

