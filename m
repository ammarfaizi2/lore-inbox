Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280387AbRKBQCB>; Fri, 2 Nov 2001 11:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280714AbRKBQBv>; Fri, 2 Nov 2001 11:01:51 -0500
Received: from [208.232.58.25] ([208.232.58.25]:55201 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280387AbRKBQBf>;
	Fri, 2 Nov 2001 11:01:35 -0500
Subject: Via onboard audio
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 11:01:07 -0500
Message-Id: <1004716867.4883.8.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've recently purchased a Compaq Presario 700 laptop that has a Via
motherboard with onboard audio.

When I load the via82cxxx_audio driver (kernel 2.4.12), I hear the
speakers pop, but no sound ever plays.  I'm check the mixer, and the
volume is up as necessary.  Interrupts are occuring for the device in
/proc/interrupts.  All the necessary (that I know of) modules are
loaded, such as sound/soundcore/ac97_codec.

I tried the ALSA drivers as well, and had less success.  For them, I had
to use the Via 686a driver (/proc/pci reports that I have a VT82C686). 
However, althouh the driver loaded, and I head my speakers pop, ALSA
utils reported that i had no configured sound cards, and no OSS based
utils worked (/dev/dsp and /dev/mixer reported invalid devices).  I did
go thru and make sure my ALSA /dev entries were created and correct.

So now I'm back to the OSS drivers, but still no luck.  If there's
anymore information I can post to figure out how to get this to work, or
maybe modify some drivers, please let me know what I need to do.  I
don't want to have to use another OS just to hear sound.  ~,^

Thanks everyone,
Sean Etc.

