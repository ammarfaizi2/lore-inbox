Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTIZWrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTIZWrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:47:36 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47607 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261696AbTIZWrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:47:35 -0400
Date: Sat, 27 Sep 2003 00:47:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [0/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030926224722.GG2881@fs.tum.de>
References: <20030925180223.GC15696@fs.tum.de> <20030926223848.GI29898@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926223848.GI29898@lug-owl.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 12:38:48AM +0200, Jan-Benedict Glaw wrote:
> On Thu, 2003-09-25 20:02:23 +0200, Adrian Bunk <bunk@fs.tum.de>
> wrote in message <20030925180223.GC15696@fs.tum.de>:
> > Changes since the last set of patches:
> > [1/4]
> > - changed the i386 CPU selection from a choice to single options for
> >   every cpu
> 
> If only "slow" CPUs are selected (i386 .. Pentium Classic/MMX), I'd
> really like to see HZ=100 (or even less) because on these machines, the
> timer interrupt handler consumes a measureable amount of time...

AFAIR there was a patch floating around that added a config option for 
HZ. With such a patch integrated it would be eeasy to integrate this 
into my patch.

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

