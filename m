Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUHMLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUHMLBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUHMLBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:01:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42951 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261159AbUHMLBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:01:42 -0400
Date: Fri, 13 Aug 2004 13:01:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-ID: <20040813110137.GY13377@fs.tum.de>
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home> <1092394019.12729.441.camel@uganda> <Pine.LNX.4.58.0408131253000.20634@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408131253000.20634@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 12:54:25PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 13 Aug 2004, Evgeniy Polyakov wrote:
> 
> > On Fri, 2004-08-13 at 14:32, Roman Zippel wrote:
> > > Hi,
> > > 
> > > On Fri, 13 Aug 2004, Adrian Bunk wrote:
> > > 
> > > >  config W1
> > > >  	tristate "Dallas's 1-wire support"
> > > > +	select NET
> > > 
> > > What's wrong with a simple dependency?
> > 
> > W1 requires NET, and thus depends on it.
> > If you _do_ want W1 then you _do_ need network and then NET must be
> > selected.
> 
> A simple "depends on NET" does this as well, I see no reason to abuse 
> select.

In the case of NET the discussion is mostly hypothetically since nearly 
everyone has enabled NET.

But the similar case of USB_STORAGE selecting SCSI is an example where 
select is a big user-visible improvement over depends.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

