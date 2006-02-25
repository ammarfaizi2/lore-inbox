Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWBYAsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWBYAsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWBYAsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:48:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15275 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932654AbWBYAsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:48:52 -0500
Date: Sat, 25 Feb 2006 01:48:33 +0100
From: Pavel Machek <pavel@suse.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound problems]
Message-ID: <20060225004833.GG1930@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de> <20060224161631.GB1925@elf.ucw.cz> <20060224234050.GA1644@elf.ucw.cz> <20060225001459.GC9655@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060225001459.GC9655@kvack.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 24-02-06 19:14:59, Benjamin LaHaise wrote:
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

Could we get some alsa-produce-sound script? On emu10k, there's 30+
options in mixer to set, and default setting is useless :-(.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
