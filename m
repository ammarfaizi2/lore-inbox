Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272474AbTGZMhn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 08:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272475AbTGZMhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 08:37:43 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:2975 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272474AbTGZMhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 08:37:39 -0400
Date: Sat, 26 Jul 2003 08:30:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Tomas Szepe <szepe@pinerecords.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: some kernel config menu suggested tweaks
In-Reply-To: <20030726121432.GB6560@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.53.0307260821570.30928@localhost.localdomain>
References: <Pine.LNX.4.53.0307241256430.20528@localhost.localdomain>
 <20030726121432.GB6560@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003, Tomas Szepe wrote:

> > [rpjday@mindspring.com]
> > 
> > 1) i mentioned this before, i think, but after one deselects
> >    Power management, should ACPI Support and CPU Frequency
> >    scaling still be available?
> > 
> >    the "make xconfig" menu display suggests a submenu 
> >    structure there, which clearly isn't the case.
> 
> Why don't you go ahead and send a patch?
> 
> > 2) can all of the low-level SCSI drivers be made deselectable
> >    in one swell foop?  folks might want SCSI support just for
> >    generic support and SCSI (ide-scsi) emulation, but have no
> >    interest in low level SCSI drivers.
> 
> Add a SCSI lowlevel drivers submenu (~4 lines of Kconfig).
> 
> > 3) can all of ATM support be deselected with a single click?
> >    in the same way "PCMCIA network device support" is done just
> >    above it under "Networking options"?
> 
> Send a patch.

i'd be happy to, but based on my previous experience sending
in a few patches, it's just not worth the aggravation any more.

just one of my patches that got adopted took, literally, several
weeks of being dropped on the floor with no reason why.  and i
had to resubmit it, slightly updated, for every BK rev of the
kernel since the previous patch wouldn't apply cleanly --
it might be a line or two off, which would require remaking
the patch and resubmitting it *again*.  at which point, it
would be dropped on the floor *again*.

don't get me wrong -- i understand that there has to be some
form of QA in accepting kernel patches, and after a while, 
regular submitters can build up a reputation.

but, at this point, it's not terribly useful to encourage people
to submit patches if those patches are just tossed.

it's like the classic catch-22:

  "we can't hire you.  you don't have enough experience doing
    this job."
  "ok, so how do i get experience?"
  "well, you have to do this job for a while."

uh, right.  so, while there's not much point in my submitting
patches, i can still toss suggestions from the sidelines, unless
you have some ideas.  i'm certainly open to advice.

rday
