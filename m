Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269718AbTGXSpa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 14:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269935AbTGXSpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 14:45:30 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:23168 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S269718AbTGXSp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 14:45:28 -0400
Date: Thu, 24 Jul 2003 20:10:32 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307241910.h6OJAWnm000706@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, rpjday@mindspring.com
Subject: Re: some kernel config menu suggested tweaks
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 1) i mentioned this before, i think, but after one deselects
> > >    Power management, should ACPI Support and CPU Frequency
> > >    scaling still be available?
> > >
> > >    the "make xconfig" menu display suggests a submenu 
> > >    structure there, which clearly isn't the case.
> > >
> > >
> > > 2) can all of the low-level SCSI drivers be made deselectable
> > >    in one swell foop?  folks might want SCSI support just for
> > >    generic support and SCSI (ide-scsi) emulation, but have no
> > >    interest in low level SCSI drivers.
> > >
> > >    so it would be convenient to be able to select the generic
> > >    support, and yet not have to deselect low-level drivers
> > >    and PCMCIA SCSI adapter support painfully, one at a time.
> > >
> > > 3) can all of ATM support be deselected with a single click?
> > >    in the same way "PCMCIA network device support" is done just
> > >    above it under "Networking options"?
> > 
> > A lot of these add extra complications for anybody not wanting a
> > 'simple' kernel config.  _Please_ don't re-design everything the same
> > way as the once-simple filesystems menu.
> > 
> > Too much prompting is irritating for advanced users, and they are the
> > people who are likely to compiling the most kernels, rather than
> > sticking with the kernel that came with their distribution.
>
> ok, this one i *am* going to take a stand on -- you're making no
> sense whatsoever, so just put down the keyboard and step back.
>
> all of the above three suggestions are for the purpose of either
> simplifying the current menu structure or making it more consistent
> with the way the rest of the menus are presented.  none of them
> increase the complexity of *anything*.
>
> how the heck can you refer to "A lot of these" in the context
> of three suggestions?  get a grip, dude.
>
> and as the complete rookie who took it upon himself to learn
> the Kconfig structure so i could bring some order to the filesystems
> menu, well, frankly, i *like* that structure, and i haven't heard
> any complaints.  you seriously think the original structure was
> *clearer*?
>
> since i don't have the ability to actually hack down at the code
> level, i figured i could still contribute by making it easier for
> newbies like myself with simpler and more consistent menus.
> apparently, this might not be worth the effort after all.
>
> thanks ever so much for the encouragement.

It's not personal, please accept my apologies if it seemed that way,
it's just a co-incidence that the couple of things I don't like were
done by you :-).

The point I'm trying to make is that if you've been using Linux for
years, all these 'clean-ups', that might seem to make things easier
and more organised for new users, really just add extra levels of
indirection for experienced users.

The filesystem menu, for example, I could previously just skip down in
make menuconfig, selecting and deselecting what I wanted.  Now, I have
to go in and out, and in and out, just to see what's selected and
what's not.  Sure, it might look nice to a new user who doesn't like
to see a lot of options they don't necessarily understand, but it
wastes the time of more experienced users.

Oh well, I'll just go back to the:

vi .config
make oldconfig

kernel configurator.

:-(.

John.
