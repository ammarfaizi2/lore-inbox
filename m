Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTHBTrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTHBTrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:47:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16125 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265531AbTHBTrO (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:47:14 -0400
Date: Sat, 2 Aug 2003 21:47:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: John Bradford <john@grabjohn.com>, Riley@Williams.Name,
       Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030802194705.GF16426@fs.tum.de>
References: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk> <20030730104421.GC28767@fs.tum.de> <20030730160403.GF12849@louise.pinerecords.com> <20030730161839.GB19356@fs.tum.de> <20030731091525.GI12849@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731091525.GI12849@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 11:15:25AM +0200, Tomas Szepe wrote:
> > [bunk@fs.tum.de]
> > 
> > On Wed, Jul 30, 2003 at 06:04:03PM +0200, Tomas Szepe wrote:
> > > > [bunk@fs.tum.de]
> > > > 
> > > > If a _user_ of a stable kernel notices "it doesn't even compile" this 
> > > > gives a very bad impression of the quality of the Linux kernel.
> > > 
> > > The keyword in this sentence is "stable."
> > > Could you maybe come up with this again at around 2.6.40? :)
> > 
> > The first stable kernel of the 2.6 kernel series will be 2.6.0.
> 
> There are going to be a zillion drivers that don't compile by the
> time 2.6.0 is released, which is precisely when lkml will see a whole
> new wave of people willing to fix things so I really don't think
> hiding the problems behind CONFIG_BROKEN or whatever is reasonable.

Note that we aren't talking about problems that ae easy to fix, such 
problems are already fixed. We are talking about drivers that are broken 
for many months.

Besides this, "a whole new wave of people willing to fix things" isn't
necessarily positive - for several of the broken drivers there were
alredy broken "fixes" posted. Some of these drivers need a non-trivial 
fix by someone who knows what he is doing.

> Tomas Szepe <szepe@pinerecords.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

