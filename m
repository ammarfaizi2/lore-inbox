Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUBYKhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUBYKhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:37:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34694 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261237AbUBYKhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:37:04 -0500
Date: Wed, 25 Feb 2004 11:37:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Re: kgdb: rename i386-stub.c to kgdb.c
Message-ID: <20040225103703.GB6206@atrey.karlin.mff.cuni.cz>
References: <20040224130650.GA9012@elf.ucw.cz> <200402251303.50102.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402251303.50102.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > kgdb uses really confusing names for arch-dependend parts. This fixes
> > it. Okay to commit?
> 
> Why is arch/$x/kernel/$x-stub.c confusing? The name $x-stub.c is indicative of 
> architecture dependent code in it. Err, well so is the path.


Well, looking at i386-stub.c, how do you know it is kgdb-related?

> PPC and sparc stubs in present vanilla kernel use this naming convention. 
> That's why I adopted it.
> 
> I find kernel/kgdbstub.c, arch/$x/kernel/$x-stub.c more consistent compared to 
> kernel/kgdbstub.c, arch/$x/kernel/kgdb.c

I actually made it kernel/kgdb.c and arch/*/kernel/kgdb.c. I believe
there's no point where one could be confused....
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
