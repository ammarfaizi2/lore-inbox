Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSFCTEk>; Mon, 3 Jun 2002 15:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSFCTEj>; Mon, 3 Jun 2002 15:04:39 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2463 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317454AbSFCTEi>;
	Mon, 3 Jun 2002 15:04:38 -0400
Date: Mon, 3 Jun 2002 12:49:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] swsusp report
Message-ID: <20020603124913.B37@toy.ucw.cz>
In-Reply-To: <20020601134649.GA373@prester>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> 1) X server and GDM is running: when suspending everything works,
> 	but when I am logged in to X/Gnome suspend does not work.
> 	Usually after "echo 4 > /proc/acpi/sleep" the screen blanks and
> 	comes back after two or three seconds and then suspends. But when I
> 	am logged in into X/Gnome, the screen blanks, comes back and nothing
> 	happens afterwards. Only Alt-SysReq-B works.

I need kernel messages to debug this. ... ... Is NFS nvolved by chance?

> 2) When successfully suspending and resuming without being logged in into X,
> 	my console is a little strange because I use 80x30 text mode and
> 	after resume the lower 5 lines, so the difference between 80x30 and 
> 	80x25, are not used, there is text left from before suspend but
> 	after resume, the cursor is alway at maximum line 25 and not line
> 	30.

Use vga= instead of setfont.

> 3) Instead of poweroff after suspend my computer reboots.

There might be define to control this (not sure if it is already in .19,
IIRC its called TEST_SWSUSP).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

