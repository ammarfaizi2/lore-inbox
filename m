Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSEIPyS>; Thu, 9 May 2002 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSEIPyR>; Thu, 9 May 2002 11:54:17 -0400
Received: from vpl.usc.edu ([128.125.21.202]:11140 "EHLO vpl.usc.edu")
	by vger.kernel.org with ESMTP id <S313687AbSEIPyQ>;
	Thu, 9 May 2002 11:54:16 -0400
Date: Thu, 9 May 2002 08:54:13 -0700
From: Joaquin Rapela <rapela@usc.edu>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org, sailer@ife.ee.ethz.ch, hb9jnx@hb9w.che.eu
Subject: Re: es1371 sound problem
Message-ID: <20020509085413.E2389@plato.usc.edu>
In-Reply-To: <20020507215024.B11180@plato.usc.edu> <20020508095713.1f661dd1.kristian.peters@korseby.net> <20020508142014.A1665@plato.usc.edu> <20020509093017.79f29936.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > May  8 12:08:39 vpl kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5903
> > (Cirrus Logic CS4297)
> 
>   ^^^^^^^^^^^^^ 
>      Maybe you own a Cirrus Logic soundcard instead ?
>      ac97 reports that your soundcard uses a codec from Cirrus L.
>      See /usr/src/linux/Documentation/sound/cs46xx maybe
>      It could be possible that your sndconfig from RedHat detects a wrong one..

Unsuccesfully I tried to load cs46xx or cs4232 from sndconfig.
qqqqqqqqqqqqqqqqqqqqqqu modprobe error tqqqqqqqqqqqqqqqqqqqqqqk
x                                                              x 
x The following error occurred running the modprobe program:   x 
x
x 
x /lib/modules/2.4.7-10/kernel/drivers/sound/cs46xx.o:
x 
x init_module: No such device
x 
x /lib/modules/2.4.7-10/kernel/drivers/sound/cs46xx.o: insmod x 
x /lib/modules/2.4.7-10/kernel/drivers/sound/cs46xx.o failed
x 
x /lib/modules/2.4.7-10/kernel/drivers/sound/cs46xx.o: insmod x 
x sound-slot-0 failed
x 

> So you can try to modprobe cs46xx or cs4232 for a Cirrus Logic Soundcard - but I suspect that this won't work correctly. Or try to load ac97_codec and ac97 only. Those es1371 soundcards have 2 dsps. ;-) But one should be enough for now.
> 
> If your model is not a Creative one try to use ES1370. Try lspci -n for that.
> The PCI ID "1274:1371" should indicate that your card is from Creative, the ID "1274:5000" incidates that it is from Ensoniq.

lspci -n reports a Creative soundcard:

00:0c.0 Class 0401: 1274:1371 (rev 08)

I am cc Thomas Sailer the author of the module.

Thanks for your great comments, Joaco

> 
> *Kristian
> 
>   :... [snd.science] ...:
>  ::                             _o)
>  :: http://www.korseby.net      /\\
>  :: http://gsmp.sf.net         _\_V
>   :.........................:

-- 
Joaquin Rapela
PhD Student, Visual Processing Group
University of Southern California
3650 South McClintock Ave.
Olin Hall of Engineering 500
Los Angeles, CA 90089-1451
tel/fax: (213) 821-2070
----------------------------------

"Respectfully keep at your studies constantly, and then you will have results."

                                                                     Confucius
