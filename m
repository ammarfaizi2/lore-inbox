Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280750AbRKBR4G>; Fri, 2 Nov 2001 12:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280752AbRKBRz4>; Fri, 2 Nov 2001 12:55:56 -0500
Received: from mail028.mail.bellsouth.net ([205.152.58.68]:30682 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280750AbRKBRzj>; Fri, 2 Nov 2001 12:55:39 -0500
Message-ID: <3BE2DE14.BA41C530@mandrakesoft.com>
Date: Fri, 02 Nov 2001 12:55:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via onboard audio
In-Reply-To: <1004716867.4883.8.camel@smiddle> 
		<3BE2C64A.C7EB2258@mandrakesoft.com> <1004723574.4883.16.camel@smiddle>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Middleditch wrote:
> 
> On Fri, 2001-11-02 at 11:14, Jeff Garzik wrote:
> > Sean Middleditch wrote:
> > >
> > > Hi!
> > >
> > > I've recently purchased a Compaq Presario 700 laptop that has a Via
> > > motherboard with onboard audio.
> > >
> > > When I load the via82cxxx_audio driver (kernel 2.4.12), I hear the
> > > speakers pop, but no sound ever plays.  I'm check the mixer, and the
> > > volume is up as necessary.  Interrupts are occuring for the device in
> > > /proc/interrupts.  All the necessary (that I know of) modules are
> > > loaded, such as sound/soundcore/ac97_codec.
> >
> > Are master volume -and- PCM volume up to 75-95%?  (do not exceed 98%)
> >
> 
> Yup, played with them all a lot, I know I tried ranges that match that.
> 
> > Here is a patch that is outstanding and waiting for Linus to apply, you
> > can try this:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.14/via-audio-2.4.14.6.patch.bz2
> 
> Hmm, I'm sticking with the Alan kernels, mostly just to comply with RH
> packages (which is what's on my laptop, despite my usual Debian bias).  Is
> this included there?

yes, it's already included in recent 2.4.13-acXX patches.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

