Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSCRT4O>; Mon, 18 Mar 2002 14:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCRT4E>; Mon, 18 Mar 2002 14:56:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:34178 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S292594AbSCRTz7>;
	Mon, 18 Mar 2002 14:55:59 -0500
Date: Mon, 18 Mar 2002 20:20:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Olivier Galibert <galibert@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020318192004.GB194@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203111829550.1153-100000@home.transmeta.com> <3C8D69E3.3080908@mandrakesoft.com> <20020311223439.A2434@zalem.nrockv01.md.comcast.net> <3C8D8061.4030503@mandrakesoft.com> <20020314141342.B37@toy.ucw.cz> <3C91D571.5070806@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Under more restricted domains, root cannot bit-bang the interface. 
> >>s/CAP_SYS_RAWIO/CAP_DEVICE_CMD/ for the raw cmd ioctl interface.  Have 
> >>
> >
> >Nobody uses capabilities these days, right?
> 
> Actually, the NSA and HP secure linux products do, at the very least. 
> And there is some ELF capabilities project out there IIRC, but I dunno 
> if anybody's using it.

I did ELF capabilities ;-). And no, I do not think I had many users.

> commands.  With the proper sequencing, you can even do power management 
> of the drives in userspace.  You don't want to do system suspend/resume 
> that way, but you can certainly have a userspace policy daemon running, 
> that powers-down and powers-up the drives, etc.

See noflushd, Hdparm is able to powersave disks well, already, and it
was in 2.2.X, too.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
