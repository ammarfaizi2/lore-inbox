Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTKLXMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTKLXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 18:12:15 -0500
Received: from oobleck.astro.cornell.edu ([132.236.6.230]:5337 "EHLO
	oobleck.astro.cornell.edu") by vger.kernel.org with ESMTP
	id S261748AbTKLXMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 18:12:10 -0500
Date: Wed, 12 Nov 2003 18:12:01 -0500
Message-Id: <200311122312.hACNC1B23224@oobleck.astro.cornell.edu>
From: Joe Harrington <jh@oobleck.astro.cornell.edu>
To: cory.bell@usa.net
CC: linux-kernel@vger.kernel.org, Patricio Rojo <pato@astro.cornell.edu>
In-reply-to: <1068657190.4255.21.camel@homer.oit.pdx.edu> (message from Cory
	Bell on Wed, 12 Nov 2003 09:13:10 -0800)
Subject: Re: Via KT600 support?
CC: jh@oobleck.astro.cornell.edu, Sven Pedersen <sventech@yahoo.com>
Reply-To: jh@oobleck.astro.cornell.edu
References: <1068657190.4255.21.camel@homer.oit.pdx.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also have an Asus A7V600. I'm unsure of the board revision, but I'm
> running BIOS 1005.
 
I am glad to see a positive report with this botherboard (actually,
that was a typo but it's perfectly true, so I'll leave it).  The
problem has turned out to be faulty memory, so I apologize to the list
for wasting your time.  So nobody complains, I used 4 different sticks
of SimpleTech memory in this machine, all with the same results.  They
passed 24 hours of memtest86 with no errors.  But, replacing them with
some Corsair memory fixed the problem.  A Simpletech rep says the
batch that my 4 sticks come from was not a particularly bad batch, but
they are sending boards from another batch that they use in more
applications in hope that it fixes the problem.  They also say this
chipset is particularly finicky about memory.  Needless to say, I
won't be sending them any more of my hard-earned cash: If it says
PC2700 on it, it should perform that way.  This was not "value RAM" to
me.

In case anyone else has similar trouble, I'll answer some of your
questions so it's easier to identify:

> > VC messages indicate problems in different programs each time.
> > Generally the failure happens during package installation, but
> > sometimes it happens earlier.  After the first indication of a
> > problem, one can generally still switch VCs, but eventually that stops
> > working, too.  Frequently, there are several programs indicating
> > problems in the VC screens.

> What are you seeing? Segfaults? Panics? Have you tried the memtest86
> boot option (from the FC1 CDs)?

I ran memtest86 for a day with no errors.  Is there something that can
be done to make its tests more definitive?  Clearly this tool didn't
find the problem, but a few minutes of transferring files did.

VC4 gave messages including:
EIP is at (some process or kernel routine name, different each time)
then a stack and call trace (again, different each time)
then sometimes
Kernel panic: 
also sometimes
Kernel BUG in buffer.c:
sometimes there are several sets of data including the EIP message,
stack trace, etc. for different programs/kernel routines at once.

Sometimes the installer just quits, saying it exited abnormally, and
it does a graceful shutdown without any VC4 errors.

The clues in your report will help a lot now that I have this thing
working.  I wish there were a website for such info, like there is for
laptops.

Thanks again for your report.

--jh--
