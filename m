Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280718AbRKBQOX>; Fri, 2 Nov 2001 11:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280719AbRKBQOM>; Fri, 2 Nov 2001 11:14:12 -0500
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:6826 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280718AbRKBQOJ>; Fri, 2 Nov 2001 11:14:09 -0500
Message-ID: <3BE2C64A.C7EB2258@mandrakesoft.com>
Date: Fri, 02 Nov 2001 11:14:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via onboard audio
In-Reply-To: <1004716867.4883.8.camel@smiddle>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Middleditch wrote:
> 
> Hi!
> 
> I've recently purchased a Compaq Presario 700 laptop that has a Via
> motherboard with onboard audio.
> 
> When I load the via82cxxx_audio driver (kernel 2.4.12), I hear the
> speakers pop, but no sound ever plays.  I'm check the mixer, and the
> volume is up as necessary.  Interrupts are occuring for the device in
> /proc/interrupts.  All the necessary (that I know of) modules are
> loaded, such as sound/soundcore/ac97_codec.

Are master volume -and- PCM volume up to 75-95%?  (do not exceed 98%)

Here is a patch that is outstanding and waiting for Linus to apply, you
can try this:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.14/via-audio-2.4.14.6.patch.bz2

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

