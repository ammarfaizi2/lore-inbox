Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317204AbSFBP7p>; Sun, 2 Jun 2002 11:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317210AbSFBP7o>; Sun, 2 Jun 2002 11:59:44 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:5586 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317204AbSFBP7n>; Sun, 2 Jun 2002 11:59:43 -0400
Date: Sun, 2 Jun 2002 09:59:18 -0600
Message-Id: <200206021559.g52FxIg09558@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Eduard Bloch <edi@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Too many mixer devices in devfs
In-Reply-To: <20020602134025.GA1296@zombie.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch writes:
> Hello,
> 
> I noticed this behaviour in 2.4.18 and it is still reproducible with
> 2.4.19pre8. With devfs, the /dev/sound/ directory allways contains four
> mixer devices, even when all sound drivers are unloaded. There are also
> other device files that do not appear and disappear when not needed. If
> this is a feature (what I doubt), then it is a very bad one. It is not
> consitent with default devfs behaviour or even other versions of it.
> 
> # ls /dev/sound
> audio
> dspW
> mixer0
> mixer1
> mixer2
> mixer3
> sequencer
> sequencer2

I don't see this behaviour on my box. I get exactly the devices I
expect. I have the es1371 driver. Perhaps your driver has been broken
in a recent patch. Go find out who hacked it last and harass them :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
