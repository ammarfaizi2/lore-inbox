Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289032AbSANU3e>; Mon, 14 Jan 2002 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSANU2U>; Mon, 14 Jan 2002 15:28:20 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:63752 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S289022AbSANU01>; Mon, 14 Jan 2002 15:26:27 -0500
Date: Mon, 14 Jan 2002 14:26:05 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric S. Raymond" <esr@thyrsus.com>, arjan@fenrus.demon.nl
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114142605.A4702@twoflower.internal.do>
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114145035.E17522@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 02:50:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> wrote:
> arjan@fenrus.demon.nl <arjan@fenrus.demon.nl>:
> > Of course there are other settings that do have impact (CPU type mostly,
> > maybe memory layout) but other than that... distros already ship several
> > binary versions (last I counted Red Hat ships 11 or so with RHL72) to
> > account for CPU type and amount etc.
> 
> OK.  Scenario #2:

Hmm.  This scenario seems totally bogus.

[...]
> Some time back he set up a Linux box for Joe Foonly over at Joe's
> Garage.  Joe calls him back and says "Hey, kid, I gotta problem here.
> Lot of hits on that website and the machine's getting sluggish when
> I'm doing my books with GnuCash on it at the same time.
[...]
> the box is
> an older machine, a 586-based PCI/ISA hybrid from around 1995, and
> only has 32MiB of memory in it.
[...]

Hmmm, 32MiB of RAM on a 586-class machine, and its doing useful work as both a
webserver and running GnuCash?  Care to construct something more real-world?

Even at that:

> Melvin thinks this is no problem, he'll start by building a new kernel
> with some stuff trimmed out to leave more RAM for userspace.  But...
> uh oh!  He nuked that source tree because free disk was getting kind
> of tight, and the .config went with it.  Looks like Melvin's going to
> have to reconstruct his configuration by hand.
> 
> "Crap." Melvin thinks.  "I don't remember what kind of network card I
> compiled in.  Am I going to have to open this puppy up just to eyeball
> the hardware?"

Uh, no.  Try `lsmod`.

> Autoconfigure saves the day.

Autoconfigure not necessary; read the output of lsmod, or read modules.conf.
Problem solved.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
