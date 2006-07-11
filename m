Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWGKK2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWGKK2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWGKK2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:28:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18960 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750958AbWGKK2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:28:24 -0400
Date: Tue, 11 Jul 2006 12:28:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Adam =?utf-8?Q?Tla=C5=82ka?= <atlka@pg.gda.pl>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org,
       rlrevell@joe-job.com, galibert@pobox.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
Message-ID: <20060711102822.GK13938@stusta.de>
References: <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe> <20060710132810.551a4a8d.atlka@pg.gda.pl> <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl> <20060710235934.GC26528@dspnet.fr.eu.org> <1152578344.21909.12.camel@mindpipe> <20060711085952.f1254229.atlka@pg.gda.pl> <Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz> <20060711110811.947e15ed.atlka@pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060711110811.947e15ed.atlka@pg.gda.pl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 11:08:10AM +0200, Adam Tlałka wrote:
> On Tue, 11 Jul 2006 09:58:26 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
>...
> > You're a bit mixing things:
> > 
> > a) we're not trying to be more compatible than OSS code in kernel, if you 
> >    like to do the mixing in kernel, simply write a new ALSA lowlevel 
> >    driver which will do it; I'm sure when the quality of your code will be 
> >    good,  we'll include it to the ALSA tree, but we are not going this
> >    way unless someone else will maintain this code
> 
> OSS kernel compatibility is only partial and aoss method is not fully compatible either

Except for some corner cases, ALSA is capable of emulating the 
in-kernel OSS.

And considering the low number of applications that are still OSS-only, 
I doubt it's really that important improving the OSS emulation even 
further.

But this is open source software, so feel free to send patches.

> I will try to write some code but I have very little free time for that so I am trying
> to convince people to rethinking the case 
>...

This is not how open source software works.

If you think something is missing, you have to implement it.

If you spend your "very little free time" on such discussions instead, 
you are not only wasting the time you could spend on implementing what 
you are thinking of but also the limited time of other developers.

> Regards

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

