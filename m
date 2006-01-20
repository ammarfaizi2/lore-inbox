Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWATJwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWATJwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 04:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWATJwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 04:52:39 -0500
Received: from mail.gmx.net ([213.165.64.21]:14004 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750773AbWATJwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 04:52:38 -0500
X-Authenticated: #2769515
Date: Fri, 20 Jan 2006 10:53:58 +0100
From: Martin Langer <martin-langer@gmx.de>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120095358.GA3683@tuba>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137745550.43d09e8ebde13@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137745550.43d09e8ebde13@webmail.uni-halle.de>
X-Public-Key-URL: http://www.langerland.de/martin/martinlanger.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 09:25:50AM +0100, Clemens Ladisch wrote:
> Krzysztof Halasa wrote:
> 
> > Adrian Bunk <bunk@stusta.de> writes:
> >
> > > 3. no ALSA drivers for the same hardware
> > >
> > > SOUND_ACI_MIXER
> >
> > Never heard
> 
> A chip used on miroPCM (ISA) cards.  An ALSA driver has been written for it,
> and it seems the ACI stuff is supported.  (This driver is not yet in the
> kernel tree.)
> 
> Martin, has your miro.c a complete implementation of what is in aci.c?

Not all card models are tested, yet. It could be possible that 
something is broken. There is a lack of bugreports for ISA cards...

Be aware that the driver for the radio part of the miroSOUND PCM20 
still depends on the OSS aci driver. Someone has to move those files 
drivers/media/radio/miropcm20* to ALSA. Meanwhile I got a miroSOUND 
PCM20 and so I'm still waiting that the ALSA miro driver will be moved 
into the kernel tree for doing it... 

Any plans about moving ALSA miro driver into the kernel? Or is there 
something completely wrong which has to be fixed at first?


martin


