Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280751AbRKBRxg>; Fri, 2 Nov 2001 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280750AbRKBRx0>; Fri, 2 Nov 2001 12:53:26 -0500
Received: from [208.232.58.25] ([208.232.58.25]:49854 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280748AbRKBRxW>;
	Fri, 2 Nov 2001 12:53:22 -0500
Subject: Re: Via onboard audio
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BE2C64A.C7EB2258@mandrakesoft.com>
In-Reply-To: <1004716867.4883.8.camel@smiddle> 
	<3BE2C64A.C7EB2258@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 12:52:53 -0500
Message-Id: <1004723574.4883.16.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-02 at 11:14, Jeff Garzik wrote:
> Sean Middleditch wrote:
> > 
> > Hi!
> > 
> > I've recently purchased a Compaq Presario 700 laptop that has a Via
> > motherboard with onboard audio.
> > 
> > When I load the via82cxxx_audio driver (kernel 2.4.12), I hear the
> > speakers pop, but no sound ever plays.  I'm check the mixer, and the
> > volume is up as necessary.  Interrupts are occuring for the device in
> > /proc/interrupts.  All the necessary (that I know of) modules are
> > loaded, such as sound/soundcore/ac97_codec.
> 
> Are master volume -and- PCM volume up to 75-95%?  (do not exceed 98%)
> 

Yup, played with them all a lot, I know I tried ranges that match that.

> Here is a patch that is outstanding and waiting for Linus to apply, you
> can try this:
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.14/via-audio-2.4.14.6.patch.bz2

Hmm, I'm sticking with the Alan kernels, mostly just to comply with RH
packages (which is what's on my laptop, despite my usual Debian bias).  Is
this included there?

Thanks!
Sean Etc.

> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


