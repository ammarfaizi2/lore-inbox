Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271920AbTG2TdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271922AbTG2TdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:33:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48876 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271920AbTG2TdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:33:16 -0400
Date: Tue, 29 Jul 2003 21:33:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: time for some drivers to be removed?
Message-ID: <20030729193309.GQ28767@fs.tum.de>
References: <Pine.LNX.4.53.0307240817520.19533@localhost.localdomain> <20030727153118.GP22218@fs.tum.de> <3F23F6EB.7070502@sktc.net> <1059324018.13442.0.camel@dhcp22.swansea.linux.org.uk> <3F241DC0.7080408@sktc.net> <1059338443.13875.2.camel@dhcp22.swansea.linux.org.uk> <20030727205638.GD22218@fs.tum.de> <1059339370.13871.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059339370.13871.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 09:56:11PM +0100, Alan Cox wrote:
> On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> > That's no problem for me.
> > 
> > The only question is how to call the option that allows building only on
> > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> > would you suggest OBSOLETE_ON_SMP?
> 
> Interesting question - whatever I guess. We don't have an existing convention.
> How many drivers have we got nowdays that failing on just SMP ?

I 2.6.0-test2 tested on i386 with a .config that is without support for
modules and compiles as much as possible statically into the kernel.
Without claiming completeness, I found this way besides the complete Old
ISDN4Linux subsystem 36 drivers that compile due to cli/sti issues only
on UP.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

