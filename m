Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTIMLOA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTIMLOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:14:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24794 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262123AbTIMLN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:13:59 -0400
Date: Sat, 13 Sep 2003 13:13:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030913111350.GC27368@fs.tum.de>
References: <200309131102.h8DB2aoA021591@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309131102.h8DB2aoA021591@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 01:02:36PM +0200, Mikael Pettersson wrote:
> On Sat, 13 Sep 2003 01:23:04 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
> >Considering this, I can simply do the following in my proposal of 
> >offering every CPU type to the user?
> >
> >config X86_BAD_APIC
> >	bool
> >	depends on CPU_586TSC
> >	default y
> 
> That depends on your semantics for CPU_586TSC.
> If it is required for support of pre-MMX P5s, then yes.
> With the current semantics, where a CPU choice simply
> sets a lower bound, then no.

The intention of my "better i386 CPU selection" patch is that you select 
all CPUs you want to support.

The semantics is that e.g. CPU_486 doesn't enable support for Pentiums.

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

