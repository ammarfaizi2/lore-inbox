Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBENp3>; Wed, 5 Feb 2003 08:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTBENp3>; Wed, 5 Feb 2003 08:45:29 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261292AbTBENp1>;
	Wed, 5 Feb 2003 08:45:27 -0500
Date: Wed, 5 Feb 2003 00:27:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Message-ID: <20030204232729.GD128@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz> <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302040056.02287.roger.larsson@skelleftea.mail.telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had compactflash from Apacer (256MB), and it started corrupting data
> > in few months, eventually becoming useless and being given back for
> > repair. They gave me another one and it is just starting to corrupt
> > data.
> > 
> > First time I repartitioned it; now I only did mke2fs, and data
> > corruption can be seen by something as simple as
> > 
> > cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.
> > 
> > [Fails 1 in 5 tries].
> 
> That is very bad... I wonder if you do something that the CF does
> not like - like power off while writing (can actually destroy the
> disk - read in some newsgroup)

I don't think I did anything bad :-(. That "1 in 5 tries bad" was on
the running system, with no reboots, powerdowns, etc.

It is possible that zaurus went into powersave mode, but I've
certainly seen corruption without powersave, too.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
