Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTILXXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTILXXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:23:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45815 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261950AbTILXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:23:08 -0400
Date: Sat, 13 Sep 2003 01:23:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: macro@ds2.pg.gda.pl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030912232304.GX27368@fs.tum.de>
References: <200309122138.h8CLc32K007912@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309122138.h8CLc32K007912@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 11:38:03PM +0200, Mikael Pettersson wrote:
>...
> GOOD_APIC is Intel P5MMX, Intel P6 and above, and AMD K7 and above.
> Nothing else has GOOD_APIC: P5 Classic because of the bug, and the
> rest because they don't have local APIC at all.

Ah, thanks for this information.

Considering this, I can simply do the following in my proposal of 
offering every CPU type to the user?

config X86_BAD_APIC
	bool
	depends on CPU_586TSC
	default y


> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

