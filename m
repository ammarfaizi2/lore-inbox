Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261833AbTCTTXJ>; Thu, 20 Mar 2003 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261834AbTCTTXJ>; Thu, 20 Mar 2003 14:23:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261833AbTCTTXG>;
	Thu, 20 Mar 2003 14:23:06 -0500
Date: Thu, 20 Mar 2003 20:33:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
Message-ID: <20030320193315.GB312@elf.ucw.cz>
References: <20030319232157.GA13415@elf.ucw.cz.suse.lists.linux.kernel> <p7365qe5284.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7365qe5284.fsf@amdsimf.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- linux-test/include/linux/compat_ioctl.h	2003-03-20 00:08:12.000000000 +0100
> > +++ linux/include/linux/compat_ioctl.h	2003-03-19 23:36:24.000000000 +0100
> > @@ -0,0 +1,641 @@
> > +/* List here explicitly which ioctl's are known to have
> > + * compatible types passed or none at all...
> > + */
> > +/* Big T */
> > +COMPATIBLE_IOCTL(TCGETA)
> 
> Shouldn't you put the include files needed for all that in there
> too?

List of includes is *way* shorter than 600 lines of
COMPATIBLE_IOCTL. I prefer to keep it simple for now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
