Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSKJLn1>; Sun, 10 Nov 2002 06:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264819AbSKJLmb>; Sun, 10 Nov 2002 06:42:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3588 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264818AbSKJLlf>;
	Sun, 10 Nov 2002 06:41:35 -0500
Date: Thu, 7 Nov 2002 18:19:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Egger <degger@fhm.edu>
Cc: reiser@namesys.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021107171949.GA773@elf.ucw.cz>
References: <15816.20406.532821.177470@wombat.chubb.wattle.id.au> <3DC87154.1030601@namesys.com> <1036592716.2654.14.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036592716.2654.14.camel@sonja.de.interearth.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There is also a longer PhD thesis by her.  10 minutes is about as much 
> > work as I personally am willing to lose and try to remember.  Avoiding 
> > 75% of writes instead of 20% is a substantial performance gain worth 
> > paying a cost for.  Unfortunately it is not easy to say if it is worth 
> > that much cost, but I suspect it is.  An approach we are exploring is 
> > for blocks to reach disk earlier than that if the device is not 
> > congested, on the grounds that if not much IO is occuring, then 
> > performance is not important.
> 
> Assuming your 10 minutes are just a default and tunable by sysctl I
> hardly can see any problems at all. Paranoid people can set it to 
> make any tradeoff between performance and speed they'd like including
> setting it to 0, no?

It has traditionaly been 30 seconds, so I'd suggest default stays.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
