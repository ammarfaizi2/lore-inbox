Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbTILWvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTILWvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:51:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51960 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261937AbTILWvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:51:47 -0400
Date: Sat, 13 Sep 2003 00:51:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: davej@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030912225138.GU27368@fs.tum.de>
References: <200309122009.h8CK9KZp006128@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309122009.h8CK9KZp006128@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 10:09:20PM +0200, Mikael Pettersson wrote:
>...
> > > - Which CPUs exactly need X86_ALIGNMENT_16?
> >
> >Unsure. This could use testing on a few systems.
> 
> K7s and P5s (and 486s too if I remember correctly) strongly prefer
> code entry points and loop labels to be 16-byte aligned. This is
> due to the way code is fetched from L1.
>...

Hm, that's pretty different from the definition in -test5:

config X86_ALIGNMENT_16
        bool
        depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || 
          MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
        default y



> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

