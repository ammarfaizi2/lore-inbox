Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTBDTT5>; Tue, 4 Feb 2003 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTBDTT5>; Tue, 4 Feb 2003 14:19:57 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7428 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267433AbTBDTT4>;
	Tue, 4 Feb 2003 14:19:56 -0500
Date: Tue, 4 Feb 2003 20:28:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Message-ID: <20030204192853.GA614@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz> <20030203073028.B4C2920BD9@dungeon.inka.de> <20030203125449.GB480@elf.ucw.cz> <1044313953.28406.44.camel@imladris.demon.co.uk> <20030204112406.GB737@atrey.karlin.mff.cuni.cz> <1044358231.3291.10.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044358231.3291.10.camel@passion.cambridge.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, if their translation layer at least *worked*, I'd be happy with
> > it.
> 
> Would you? You fill up your FAT or EXT2 file system, then delete all
> your files. There are lots and lots of sectors with now-unused data.
> 
> Then start filling it up again. 
> 
> To accommodate your writes, the underlying translation layer is busily
> garbage-collecting all those blocks which are _unused_, copying them
> from one part of the flash to another to collect 'fresh' copies of data
> together while reclaiming space from 'obsoleted' copies of changed
> sectors.
> 
> Or you manage to find a vendor who sells reliable cards, hence decide
> it's actually usable for real medium-term storage and start using
> EXT3

Well, I've got old 20-mb PCMCIA, and that worked for me for >2
years. Now I've apacer 256MB CF, and it died within a *month*. I
returned it and the "new" one died within *week*. Ouch.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
