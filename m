Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTATTuF>; Mon, 20 Jan 2003 14:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTATTkI>; Mon, 20 Jan 2003 14:40:08 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10756 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266854AbTATTjv>;
	Mon, 20 Jan 2003 14:39:51 -0500
Date: Sun, 19 Jan 2003 17:05:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030119160515.GA1945@elf.ucw.cz>
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <m3iswv27o3.fsf@averell.firstfloor.org> <1042295999.2517.10.camel@irongate.swansea.linux.org.uk> <20030111140602.GA20221@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111140602.GA20221@averell>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   - Flaws in error recovery paths in certain situations
> >   - Lots of random oopses on boot/remove that were apparently
> >     introduced by the kobject/sysfs people and need chasing
> >     down. (There are some non sysfs ones mostly fixed)
> 
> I guess the kobject/sysfs stuff could be ripped out if it doesn't
> work - it is probably not a "must have" feature.

sysfs is  needed to properly flush caches on powerdown and for
S3/S4 suspend/resume to work.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
