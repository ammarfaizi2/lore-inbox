Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTBXXB3>; Mon, 24 Feb 2003 18:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTBXXB2>; Mon, 24 Feb 2003 18:01:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32266 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262452AbTBXXB2>; Mon, 24 Feb 2003 18:01:28 -0500
Date: Tue, 25 Feb 2003 00:11:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp and S3 fixes
Message-ID: <20030224231140.GE7377@atrey.karlin.mff.cuni.cz>
References: <20030221094850.GA18896@elf.ucw.cz> <Pine.LNX.4.44.0302241450060.18519-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302241450060.18519-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  your patch causes
> 
> 	arch/i386/kernel/dmi_scan.c:482: warning: `reset_videobios_after_s3' defined but not used
> 	make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
> 	arch/i386/kernel/built-in.o: In function `reset_videomode_after_s3':
> 	arch/i386/kernel/built-in.o(.init.text+0x1e07): undefined reference to `acpi_video_flags'
> 	arch/i386/kernel/built-in.o: In function `reset_videobios_after_s3':
> 	arch/i386/kernel/built-in.o(.init.text+0x1e17): undefined reference to `acpi_video_flags'
> 	make: *** [.tmp_vmlinux1] Error 1
> 
> for me, with neither ACPI not SW_SUSPEND configured.
> 
> Don't call patches like this "trivial" if they haven't even been 
> properly tested. 

I wanted to mail you a fix but I see its already fixed in bk
tree. Sorry about that.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
