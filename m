Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVAXTHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVAXTHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVAXTGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:06:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261576AbVAXTFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:05:51 -0500
Date: Mon, 24 Jan 2005 20:05:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Jurriaan <thunder7@xs4all.nl>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1: SuperIO scx200 breakage
Message-ID: <20050124190546.GP3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124175449.GK3515@stusta.de> <20050124214336.2c555b53@zanzibar.2ka.mipt.ru> <20050124184111.GA9335@middle.of.nowhere> <20050124222302.6f962097@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124222302.6f962097@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:23:02PM +0300, Evgeniy Polyakov wrote:
> On Mon, 24 Jan 2005 19:41:11 +0100
> Jurriaan <thunder7@xs4all.nl> wrote:
> 
> > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > Date: Mon, Jan 24, 2005 at 09:43:36PM +0300
> > > On Mon, 24 Jan 2005 18:54:49 +0100
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > 
> > > > It seems noone who reviewed the SuperIO patches noticed that there are 
> > > > now two modules "scx200" in the kernel...
> > > 
> > > They are almost mutually exlusive(SuperIO contains more advanced), 
> > > so I do not see any problem here.
> > > Only one of them can be loaded in a time.
> > > 
> > > So what does exactly bother you?
> > > 
> > lsmod in bugreports giving unspecific results, for example.
> 
> If you load scx200 from superio subsystem, then obviously you can not
> use old i2c/acb modules which require old scx200.
> And vice versa.
> 
> One needs to load exactly what he wants.

You did not understand what Jurriaan said:

Even if it was working, "lsmod" would not be able to tell which of the 
two modules was loaded.

This would cause much headache for many people.

> > Kind regards,
> > Jurriaan
> 
> 	Evgeniy Polyakov

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

