Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUBDIWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUBDIWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:22:24 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7676 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266314AbUBDIWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:22:21 -0500
Date: Wed, 4 Feb 2004 09:22:14 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Han Boetes <han@mijncomputer.nl>, James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: Voyager requires SMP?
Message-ID: <20040204082213.GT4443@fs.tum.de>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040128083645.GI2650@boetes.org> <20040130025142.GE3004@fs.tum.de> <20040130060028.GB13535@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130060028.GB13535@boetes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 07:00:06AM +0100, Han Boetes wrote:
> Adrian Bunk wrote:
> > On Wed, Jan 28, 2004 at 09:36:23AM +0100, Han Boetes wrote:
> > > 
> > > Hmmm my build breaks with:
> > > 
> > >   LD      .tmp_vmlinux1
> > > arch/i386/kernel/built-in.o(.init.text+0x1342): In function `setup_memory':
> > > : undefined reference to `find_smp_config'
> > >...
> > 
> > You have a Voyager machine?
> > You didn't enable SMP support?
> > 
> > Could you retry the compilation with SMP support enabled?
> 
> Andrew already replied to me in private. Seems like I accidentally 
> selected the wrong processor-type during the make oldconfig. I hoped
> nobody would notice ;)

But your mail showed something that should be fixed:

@James:
Is X86_VOYAGER=y and SMP=n a valid configuration that should compile, or 
should X86_VOYAGER select SMP?

> # Han

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

