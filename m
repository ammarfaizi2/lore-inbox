Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWAFAfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWAFAfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAFAfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:35:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932325AbWAFAfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:35:44 -0500
Date: Fri, 6 Jan 2006 01:35:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Oberritter <obi@linuxtv.org>
Cc: Holger Waechtler <holger@qanu.de>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Linux-dvb <Linux-dvb@linuxtv.org>
Subject: Re: [linux-dvb-maintainer] DVB at76c651.c driver seems to be dead code
Message-ID: <20060106003543.GO12313@stusta.de>
References: <20050210235605.GN2958@stusta.de> <420C7C83.4070309@qanu.de> <1108123869.3535.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108123869.3535.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:11:08PM +0100, Andreas Oberritter wrote:
> On Fri, 2005-02-11 at 10:36 +0100, Holger Waechtler wrote:
> > Adrian Bunk wrote:
> > 
> > >I didn't find any way how the drivers/media/dvb/frontends/at76c651.c 
> > >driver would do anything inside kernel 2.6.11-rc3-mm2. All it does is to 
> > >EXPORT_SYMBOL a function at76c651_attach that isn't used anywhere.
> > >
> > >Is a patch to remove this driver OK or did I miss anything?
> > >  
> > >
> > 
> > no, please let it there. This driver is the GPL'd part of the dbox2 
> > driver which is not part of the official kernel tree.
> 
> (Actually all dbox2 drivers are GPL-licensed, you can get them at
> cvs.tuxbox.org)
> 
> > Since frontend and demod drivers are reusable elsewhere and mainstream 
> > hardware that makes use of this demodulator may show up every week it's 
> > just stupid to remove this code as long we know it is working and 
> > continously tested by the dbox2 folks.
> > 
> > Instead it may make sense to move the dbox2 sources into the mainstream 
> > source tree. Andreas, what do you think?
> 
> It has been a long term goal since months, but I don't have the time for
> it now. We are still waiting for mpc8xx to become stable in 2.6.

Are thre any news regarding merging code actually using at76c651.c?

> Regards,
> Andreas

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

