Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUHMKyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUHMKyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUHMKyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:54:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59079 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265087AbUHMKyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:54:18 -0400
Date: Fri, 13 Aug 2004 12:54:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-ID: <20040813105412.GW13377@fs.tum.de>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408131231480.20635@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:32:55PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Fri, 13 Aug 2004, Adrian Bunk wrote:
> 
> >  config W1
> >  	tristate "Dallas's 1-wire support"
> > +	select NET
> 
> What's wrong with a simple dependency?

it's common practice to make it easier for people configuring the kernel 
to use select instead of depends in such cases.

It's also relatively safe since NET itself doesn't has any dependencies.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

