Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUBNQrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBNQrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:47:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1274 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262353AbUBNQrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:47:13 -0500
Date: Sat, 14 Feb 2004 17:47:07 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Peter Lieverdink <peter@cc.com.au>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 PPC ALSA snd-powermac
Message-ID: <20040214164707.GL1308@fs.tum.de>
References: <1076483508.13791.6.camel@kahlua> <s5hr7x1bzvr.wl@alsa2.suse.de> <1076540202.13791.19.camel@kahlua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076540202.13791.19.camel@kahlua>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 09:56:42AM +1100, Peter Lieverdink wrote:
> On Wed, 2004-02-11 at 22:48, Takashi Iwai wrote:
> > At Wed, 11 Feb 2004 18:11:48 +1100,
> > Peter Lieverdink wrote:
> > > 
> > > [1  <text/plain (quoted-printable)>]
> > > Is it just me or does 'make menuconfig' in kernel 2.6.2 on ppc not give
> > > me an option to enable i2c? It's supposed to be in Character Devices,
> > > no? The ALSA snd-powermac module needs i2c and upon a 'modprobe
> > > snd-powermac' spews forth:
> > 
> > does the attached patch work?
> 
> Unfortunately:
> 
> cafuego@chocomel:/usr/src/linux-2.6.2$ make-kpkg clean; make-kpkg
> --revision chocomel.1 kernel-image
> [...]
> LD      .tmp_vmlinux1
> sound/built-in.o(.text+0x28770): In function `daca_init_client':
> : undefined reference to `i2c_smbus_write_byte_data'
>...

Please send your .config .

> - Peter.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

