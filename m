Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285747AbSAZRwR>; Sat, 26 Jan 2002 12:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSAZRv6>; Sat, 26 Jan 2002 12:51:58 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:59270 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S285747AbSAZRvy>; Sat, 26 Jan 2002 12:51:54 -0500
Date: Sat, 26 Jan 2002 17:48:00 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Martin Eriksson <nitrax@giron.wox.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126174800.D6724@kushida.apsleyroad.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com> <20020126034106.F5730@kushida.apsleyroad.org> <012d01c1a687$faa11120$0201a8c0@HOMER> <3C52DD96.183322F9@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C52DD96.183322F9@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Jan 26, 2002 at 11:47:18AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> > Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just got a
> > ~1% smaller vmlinux and a ~3% smaller bzImage. Maybe the size optimizations
> > doesn't show on these files? Internal data structures that are much bigger
> > than "real" code?
> 
> That doesn't tell us much unless you benchmark any speed
> improvements/degradations noticed.  Hidden in that 1% may be more
> favorable I-cache usage, better register usage... who knows.
> 
> It would also be interesting to compile key files like kernel/sched.c or
> mm/vmscan.c in assembly using O2 and Os, and compare the output with
> diff -u.

It'd be good to know why it's not achieving the quoted 30% space saving
that other compilers manage for normal code, unless it's myth of course.

-- Jamie
