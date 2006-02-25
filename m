Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWBYAUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWBYAUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWBYAUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:20:32 -0500
Received: from kanga.kvack.org ([66.96.29.28]:24745 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932641AbWBYAUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:20:31 -0500
Date: Fri, 24 Feb 2006 19:14:59 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound problems]
Message-ID: <20060225001459.GC9655@kvack.org>
References: <20060223205309.GA2045@elf.ucw.cz> <s5h1wxtdmri.wl%tiwai@suse.de> <20060224161631.GB1925@elf.ucw.cz> <20060224234050.GA1644@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224234050.GA1644@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 12:40:50AM +0100, Pavel Machek wrote:
>  0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
>                       Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
>  1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
>                       USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed
> root@amd:~#
> 
> (usb soundcard clicks when I launch mpg123, but that's it.)
> 
> Any ideas?

I had problems with the ac97 driver and newer kernels until toggling Mute 
on the headphone sense channel.  Alsa has too many bells and whistles that 
need to be properly incanted for machines to emit sound.  Just try futzing 
with the channels in alsamixer.  Otoh, that's a good way to end up with a 
config that doesn't work, too...

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
