Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRC3Pus>; Fri, 30 Mar 2001 10:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRC3Puj>; Fri, 30 Mar 2001 10:50:39 -0500
Received: from staffnet.com ([207.226.80.14]:2834 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S131477AbRC3Pua>;
	Fri, 30 Mar 2001 10:50:30 -0500
Message-ID: <3AC4AB1A.1D30F40A@staffnet.com>
Date: Fri, 30 Mar 2001 10:49:46 -0500
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 cs4232 is not SMP safe
In-Reply-To: <20010328200644.C3544@suse.de> <E14iKnd-0006DT-00@the-village.bc.nu> <20010328211050.A21273@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:;;@localhost.localdomain (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> 
> On Wed, Mar 28, Alan Cox wrote:
> 
> > > But it still jumps into xmon. How can we make that driver SMP safe?
> > > There is no maintainer address in the files.
> >
> > CS4232 has no maintainer. I've had no SMP x86 problems reported with it for
> > a long time but that may be chance
> 
> Well, the alsa driver loads but it can not play sound, all you get is a
> strange noise. The same driver (alsa/kernel) works on a UP ppc machine
> (a B50). I will try to get an UP kernel for that machine, it worked once
> around 2.4.3-pre.
I have been using a Dell SMB dual PII/300 box with cs4232 playing my
MP3s
in a loop 24x7 for nearly a year without any glitches.  I have tried it
with 2.2 kernels and 2.4.0.  

The only problem I have had with the box and sound driver was that I 
had to set the PCI quirks flag to 1 (thanks to Alan for pointing me to
it)
to keep it from crashing when playing sound and accessing the floppy 
(this got QUITE embarassing when I was doing some custom work for some 
high-level folks a while back).

However, I have one beef with the driver.  Each time it starts a cut,
I get a loud pop from the speaker.  This appears to be a startup
transient and is not present on my other sound card in the box,
a SoundBlaster Vibra 16.  This pop happens on ANY play application,
playing ANY file (esdplay, play[sox], vplay, xmms, etc.).

Cheers,
--
Wade Hampton
