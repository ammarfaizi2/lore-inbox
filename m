Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSFDT5N>; Tue, 4 Jun 2002 15:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFDTzR>; Tue, 4 Jun 2002 15:55:17 -0400
Received: from [195.39.17.254] ([195.39.17.254]:40095 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316662AbSFDTy3>;
	Tue, 4 Jun 2002 15:54:29 -0400
Date: Tue, 4 Jun 2002 14:09:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: Re: [patch] i386 "General Options" - begone [take 2]
Message-ID: <20020604140920.B36@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <200206031318.09634.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch (a minor update on one that I accidently left lkml out of the To:) 
> removes the "General Options" top level config menu from the i386 build for 
> 2.5.20. It didn't describe what it was doing, and it contained a broad 
> collection of mostly unrelated configuration options.
> To replace it, you now get:
> "Power management options (ACPI, APM)", which also includes software suspend.
> "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> "Executable file formats"

Good.

> While moving software suspend, I also took the chance to tweak the Config.help 
> entry.

Please don't tell people about sysrq-D, I'm going to kill that. OTOH convient
way is echo 4 > /proc/acpi/sleep -- that is if you have ACPI enabled.

Swsusp is required for suspend-to-ram, too. I plan to fix that somehow,
however.
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

