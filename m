Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbTIOGwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbTIOGwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:52:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:37112 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262466AbTIOGwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:52:16 -0400
Date: Mon, 15 Sep 2003 08:52:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Michael Neuffer <neuffer@neuffer.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030915065211.GB126@fs.tum.de>
References: <20030913222443.GN27368@fs.tum.de> <20030913222659.GO27368@fs.tum.de> <20030915064623.GA6772@neuffer.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915064623.GA6772@neuffer.info>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 08:46:23AM +0200, Michael Neuffer wrote:
> Quoting Adrian Bunk (bunk@fs.tum.de):
> > [...]
> > - help text changes/updates
> > [...]  
> > -config M686
> > +config CPU_686
> >  	bool "Pentium-Pro"
> >  	help
> > -	  Select this for Intel Pentium Pro chips.  This enables the use of
> > -	  Pentium Pro extended instructions, and disables the init-time guard
> > -	  against the f00f bug found in earlier Pentiums.
> > +	  Select this for Intel Pentium Pro chips.
> > [...one example left]  
> 
> 
> Hi Adrian

Hi Michael,

> Is there a valid reason why you removed most of the
> descriptions ? I think a bit of a background on the
> CPU selections is helpful and interesting, especially 
> for newcommers. You've cut it down so far, that you 
> could also put there "Read Variable Name" or 
> "No help available"  instead.

With the CPU selection scheme I propose this is no longer true. 
Especially the f00f workaround is no longer disabled when configuring 
for a Pentium Pro or above, it's only enabled when you select the older 
Pentium - but this setting is now independend of the Pentium Pro 
setting.

> Cheers
>    Mike 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

