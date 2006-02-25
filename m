Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWBYA3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWBYA3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbWBYA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:29:44 -0500
Received: from xenotime.net ([66.160.160.81]:47767 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964825AbWBYA3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:29:43 -0500
Date: Fri, 24 Feb 2006 16:29:40 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Pavel Machek <pavel@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound
 problems]
In-Reply-To: <20060225001459.GC9655@kvack.org>
Message-ID: <Pine.LNX.4.58.0602241628400.7894@shark.he.net>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de>
 <20060224161631.GB1925@elf.ucw.cz> <20060224234050.GA1644@elf.ucw.cz>
 <20060225001459.GC9655@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> On Sat, Feb 25, 2006 at 12:40:50AM +0100, Pavel Machek wrote:
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
> I had problems with the ac97 driver and newer kernels until toggling Mute
> on the headphone sense channel.  Alsa has too many bells and whistles that
> need to be properly incanted for machines to emit sound.  Just try futzing
> with the channels in alsamixer.  Otoh, that's a good way to end up with a
> config that doesn't work, too...

There are also a few machines that have microphone in/headphone out
switched/swapped.  There was a ALSA patch around for that.  :(

-- 
~Randy
