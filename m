Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSGJThy>; Wed, 10 Jul 2002 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSGJThr>; Wed, 10 Jul 2002 15:37:47 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:41969 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S317587AbSGJThJ>; Wed, 10 Jul 2002 15:37:09 -0400
Date: Wed, 10 Jul 2002 02:20:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Russell King <rmk@arm.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] /proc/cpuinfo output from some arch
Message-ID: <20020710002017.GA540@elf.ucw.cz>
References: <20020707002006.B5242@flint.arm.linux.org.uk> <200207070030.g670UbT166497@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207070030.g670UbT166497@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> >> /proc/cpuinfo was *definitely* meant to be parsed by programs.
> >> Unfortunately, lots of architectures seems to have completely missed
> >> that fact.
> >
> > Sigh, its a shame such things aren't documented somewhere in the
> > kernel tarball.
> 
> Ah, but you're supposed to remember the history!
> The colons were added to make parsing easier.
> I think that was done after somebody added spaces
> on the left, and lots of app developers screamed
> that the format had become hopeless.
> 
> Right now I'm looking to get the temperature,
> clock speed, and voltage. I get the first two
> on PowerPC hardware, but it's not obvious what
> mess an SMP system would spit out.


I thought that cpuinfo was ment to be non-chaning after boot? 

Perhaps we want /proc/cpu/0/temperature containing single int?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
