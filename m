Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTBGLFN>; Fri, 7 Feb 2003 06:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267817AbTBGLFM>; Fri, 7 Feb 2003 06:05:12 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267785AbTBGLEW>;
	Fri, 7 Feb 2003 06:04:22 -0500
Date: Fri, 7 Feb 2003 11:58:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: jt@hpl.hp.com, Mikael Pettersson <mikpe@csd.uu.se>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: two x86_64 fixes for 2.4.21-pre3
Message-ID: <20030207105818.GB750@elf.ucw.cz>
References: <15921.37163.139583.74988@harpo.it.uu.se> <20030124193721.GA24876@wotan.suse.de> <15926.60767.451098.218188@harpo.it.uu.se> <20030128212753.GA29191@wotan.suse.de> <15927.62893.336010.363817@harpo.it.uu.se> <20030129162824.GA4773@wotan.suse.de> <15934.49235.619101.789799@harpo.it.uu.se> <20030203194923.GA27997@bougret.hpl.hp.com> <20030203201255.GA32689@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203201255.GA32689@wotan.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	The source of Wireless Tools should be 64 bit clean (was
> > working on Alpha), and I don't think it's worth adding a whole pile of
> > cruft in the kernel when it's used by a few system utilities that you
> > can simply recompile. Personally, I expect every distribution to ship
> > the base system compiled natively.
> > 	With regards to this specific problem, just return an
> > error. The Wireless Tools should gracefully handle it and report to
> 
> That is currently done (-EINVAL), but the emulation layer logs an 
> warning.

Perhaps we need new error code -EEMULATION with message "not supported
within this emulation"?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
