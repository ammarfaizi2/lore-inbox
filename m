Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSE1UlU>; Tue, 28 May 2002 16:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316910AbSE1UlT>; Tue, 28 May 2002 16:41:19 -0400
Received: from [195.39.17.254] ([195.39.17.254]:57756 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316903AbSE1UlI>;
	Tue, 28 May 2002 16:41:08 -0400
Date: Mon, 27 May 2002 14:01:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: fchabaud@free.fr
Cc: matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
Message-ID: <20020527140111.G35@toy.ucw.cz>
In-Reply-To: <20020524011322.GA6612@merlin.emma.line.org> <200205250800.g4P80F124063@colombe.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
> > is blocked?"
> > 
> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
> > "Probem while suspending", then some "Resume" and finally the panic.
> > 
> > It may be worth noting that one swap partition is on a SCSI drive, and
> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
> > motors were stopped.
> > 
> 
> AFAIK swap partition under SCSI is not supported for the moment.

 can you elaborate? swsusp ddoes not careif it is scsi on ide and I had it
running on usb-storage device at one point.
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

