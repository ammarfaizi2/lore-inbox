Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSBKMxW>; Mon, 11 Feb 2002 07:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBKMxM>; Mon, 11 Feb 2002 07:53:12 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54800 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288960AbSBKMw4>; Mon, 11 Feb 2002 07:52:56 -0500
Date: Mon, 11 Feb 2002 13:52:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020211125243.GB32599@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020208001831.A200@steel> <20020208003653.A28235@suse.de> <20020209222358.GA1589@elf.ucw.cz> <20020211125902.B3342@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211125902.B3342@steel>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What does the "Bank 4: b200000000040151" mean?
> If that is a memory, can anyone help to find out which slot it is?
> (memtest86 haven't found anything, btw, i doubt that counts)
> -alex
> 
> P.S. if someone going to change the message about machine check,
> could you please avoid lame descriptions? Like "(hardware problem!)"?
> I sure the majority are experienced enough to understand what the
> words "Machine Check" mean.

Ugh? If you understand that its hardware problem, why did you bother
contacting l-k? l-k is certainly not interested in debugging hardware
problems....

...and... It is not exactly easy to see that Machine check means
hardware problem...

								Pavel

> > >  > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
> > >  > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
> > >  > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt
> > > 
> > >  Machine checks are indicative of hardware fault.
> > >  Overclocking, inadequate cooling and bad memory are the usual
> > > causes.
> > 
> > Maybe you should print something like
> > 
> > Machine Check Exception: .... (hardware problem!)
> > 
> > so that we get less reports like this?

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
