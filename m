Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWBYLfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWBYLfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 06:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWBYLfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 06:35:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62921 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030226AbWBYLfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 06:35:54 -0500
Date: Sat, 25 Feb 2006 12:35:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound problems]
Message-ID: <20060225113533.GB2782@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de> <20060224161631.GB1925@elf.ucw.cz> <20060224234050.GA1644@elf.ucw.cz> <20060224181137.52d6da79.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224181137.52d6da79.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now, I tried to break the curse by connecting usb sound card to
> > another machine... but guess what, still no sound. Connected to second
> > machine:
> > 
> > root@amd:~# cat /proc/asound/cards
> >  0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
> >                       Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
> >  1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
> >                       USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed
> > root@amd:~#
> > 
> > (usb soundcard clicks when I launch mpg123, but that's it.)
> > 
> > Any ideas?
> 
> Maybe you went deaf?

Heh :-), it more looks like ALSA went mute. That, or I got very good
at reading words from people's faces. [Actually, not, "ICH4 - Intel
82801DB-ICH4" still works okay.]

> Are any of the above regressions, or has it always been like that?

I have not tested those cards in *very* long time, so I don't think it
should be counted as regressions.
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
