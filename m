Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275533AbTHMUuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275534AbTHMUuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:50:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6118 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275533AbTHMUuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:50:14 -0400
Date: Wed, 13 Aug 2003 22:50:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: davidsen@tmr.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       wowbagger@sktc.net
Subject: Re: time for some drivers to be removed?
Message-ID: <20030813205006.GL569@fs.tum.de>
References: <200308132055.h7DKtTkH002249@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308132055.h7DKtTkH002249@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:55:29PM +0100, John Bradford wrote:
> > > > Interesting question - whatever I guess. We don't have an existing convention.
> > > > How many drivers have we got nowdays that failing on just SMP ?
> > > 
> > > I 2.6.0-test2 tested on i386 with a .config that is without support for
> > > modules and compiles as much as possible statically into the kernel.
> > > Without claiming completeness, I found this way besides the complete Old
> > > ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
> > > on UP.
> >
> > Should those be made to depend on SMP (not SMP) perhaps? They are probably
> > high candidates for fixing if they work UP.
> 
> Especially since a lot of the time, 'works on UP, but not on SMP',
> really means, 'broken on UP and SMP, but the bug is much more
> difficult to trigger on UP'.

Please reread my mail:
"that compile due to cli/sti issues only on UP".

This clearly disproves your theory.

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

