Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267651AbTAQTyt>; Fri, 17 Jan 2003 14:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267652AbTAQTyt>; Fri, 17 Jan 2003 14:54:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2564 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267651AbTAQTys>;
	Fri, 17 Jan 2003 14:54:48 -0500
Date: Fri, 10 Jan 2003 15:30:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, venom@sns.it,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: Honest does not pay here ...
Message-ID: <20030110143018.GA193@elf.ucw.cz>
References: <20030107232820.GB24664@merlin.emma.line.org> <Pine.LNX.4.43.0301080059460.24706-100000@cibs9.sns.it> <20030108003050.GF17310@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108003050.GF17310@work.bitmover.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In very semplicistic words:
> > In 2.5/2.6 kernels, non GPL modules have a big
> > penalty, because they cannot create their own queue, but have to use a default
> > one.
> 
> I may be showing my ignorance here (won't be the first time) but this makes
> me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> drivers which ran in kernel mode but in the context of a process and had
> to talk to the real kernel via pipes or whatever.  It's a fair amount of
> plumbing but could have the advantage of being a more stable interface
> for the drivers. 

You don't need kernel mode to touch hw.

> If you think about it, drivers are more or less open/close/read/write/ioctl.
> They need kernel privileges to do their thing but don't need (and shouldn't
> have) access to all the guts of the kernel.
> 
> Can any well traveled driver people see this working or is it nuts?

Well, nbd was originally created just for that.

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
