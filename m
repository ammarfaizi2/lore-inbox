Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTCCP7Y>; Mon, 3 Mar 2003 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbTCCP7Y>; Mon, 3 Mar 2003 10:59:24 -0500
Received: from mail.gmx.de ([213.165.64.20]:14953 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266367AbTCCP7V>;
	Mon, 3 Mar 2003 10:59:21 -0500
Date: Mon, 3 Mar 2003 17:09:46 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, linux-kernel@vger.kernel.org
Subject: Re: Alsa, Kernel OSS
Message-Id: <20030303170946.74affcbb.gigerstyle@gmx.ch>
In-Reply-To: <s5hptp8jwqc.wl@alsa2.suse.de>
References: <20030301231746.1cdf1b42.gigerstyle@gmx.ch>
	<s5hptp8jwqc.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On Mon, 03 Mar 2003 16:28:11 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 1 Mar 2003 23:17:46 +0100,
> Marc Giger wrote:
> > 
> > Hi Jaroslav, Hi everyone,
> > 
> > I have the following problem with Kernel 2.4.20 and the alsa
> > 0.9.0_rc6 / rc7 drivers: 
> > 
> > When I try to load the snd-intel8x0 driver I get the message that no
> > such device is installed. But when I first load the kernel i810_audio
> > driver and then unload it again, I can load the snd-intel8x0 without
> > any problems.... 
> 
> this might be due to the detection of modem codec.
> if so, this was fixed on the ALSA cvs.  please try ALSA cvs version or
> wait for the next ALSA patchset...

Ok, I will wait..

> 
> 
> > This happened not with 2.4.19 and alsa < 0.9.0_rc6..
> > 
> > Another question:
> > 
> > Why can't I play more than one sources on the same time with such a
> > card? All programs which would access /dev/dsp blocks until the other
> > programs frees the device... It isn't very useful. 
> > 
> > I have no such problems with multiple sources as example on my
> > SBLive or on my yamaha sound card with the snd-ymfpci driver. 
> > 
> > Do I miss some settings?
> 
> no, it's the hardware limitation.

Ok, I see..cheap hardware..

But multiple sources on window$ works..
In this case, windows mixes the sources in software - right?
Is it a big "problem" to do this also in Linux?
This would be an interesting work for me:-)
Perhaps a program as interface between userspace and alsa-driver? Or better directly in the alsa-driver?

Thank you very much!

Marc

> 
> 
> Takashi
> 
