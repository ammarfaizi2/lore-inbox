Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTGXSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269961AbTGXSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:35:58 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:4013 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269747AbTGXSfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:35:46 -0400
Date: Thu, 24 Jul 2003 14:49:07 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: John Bradford <john@grabjohn.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: some kernel config menu suggested tweaks
In-Reply-To: <200307241845.h6OIjsYD000632@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0307241437260.21205@localhost.localdomain>
References: <200307241845.h6OIjsYD000632@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jul 2003, John Bradford wrote:

> > 1) i mentioned this before, i think, but after one deselects
> >    Power management, should ACPI Support and CPU Frequency
> >    scaling still be available?
> >
> >    the "make xconfig" menu display suggests a submenu 
> >    structure there, which clearly isn't the case.
> >
> >
> > 2) can all of the low-level SCSI drivers be made deselectable
> >    in one swell foop?  folks might want SCSI support just for
> >    generic support and SCSI (ide-scsi) emulation, but have no
> >    interest in low level SCSI drivers.
> >
> >    so it would be convenient to be able to select the generic
> >    support, and yet not have to deselect low-level drivers
> >    and PCMCIA SCSI adapter support painfully, one at a time.
> >
> > 3) can all of ATM support be deselected with a single click?
> >    in the same way "PCMCIA network device support" is done just
> >    above it under "Networking options"?
> 
> A lot of these add extra complications for anybody not wanting a
> 'simple' kernel config.  _Please_ don't re-design everything the same
> way as the once-simple filesystems menu.
> 
> Too much prompting is irritating for advanced users, and they are the
> people who are likely to compiling the most kernels, rather than
> sticking with the kernel that came with their distribution.

ok, this one i *am* going to take a stand on -- you're making no
sense whatsoever, so just put down the keyboard and step back.

all of the above three suggestions are for the purpose of either
simplifying the current menu structure or making it more consistent
with the way the rest of the menus are presented.  none of them
increase the complexity of *anything*.

how the heck can you refer to "A lot of these" in the context
of three suggestions?  get a grip, dude.

and as the complete rookie who took it upon himself to learn
the Kconfig structure so i could bring some order to the filesystems
menu, well, frankly, i *like* that structure, and i haven't heard
any complaints.  you seriously think the original structure was
*clearer*?

since i don't have the ability to actually hack down at the code
level, i figured i could still contribute by making it easier for
newbies like myself with simpler and more consistent menus.
apparently, this might not be worth the effort after all.

thanks ever so much for the encouragement.

rday


