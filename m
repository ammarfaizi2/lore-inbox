Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSANUH0>; Mon, 14 Jan 2002 15:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSANUGX>; Mon, 14 Jan 2002 15:06:23 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:26758
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289001AbSANUF4>; Mon, 14 Jan 2002 15:05:56 -0500
Date: Mon, 14 Jan 2002 14:50:35 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114145035.E17522@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m16QCNJ-000OVeC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Mon, Jan 14, 2002 at 07:02:29PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arjan@fenrus.demon.nl <arjan@fenrus.demon.nl>:
> Of course there are other settings that do have impact (CPU type mostly,
> maybe memory layout) but other than that... distros already ship several
> binary versions (last I counted Red Hat ships 11 or so with RHL72) to
> account for CPU type and amount etc.

OK.  Scenario #2:

Tillie's nephew Melvin is a junior-grade geek.  He's working his way
through college doing website administration for small businesses.  He
doesn't know C, but he can hack his way around Perl and a little PHP,
and he can type "configure; make".  He's been known to wear a penguin
T-shirt.

Some time back he set up a Linux box for Joe Foonly over at Joe's
Garage.  Joe calls him back and says "Hey, kid, I gotta problem here.
Lot of hits on that website and the machine's getting sluggish when
I'm doing my books with GnuCash on it at the same time.  But what with
the recession and all, I don't want to go buying new hardware if I can
help it."

Melvin thinks to himself "OK, let's see if we can't tune this sucker a
bit."  He runs top(1) and sees a bad shortage of free RAM; the box is
an older machine, a 586-based PCI/ISA hybrid from around 1995, and
only has 32MiB of memory in it.  But Joe doesn't want to spend money
on hardware and, since money is tight all over and Joe took care of
the state inspection for Melvin's car a few weeks ago without getting
around to billing him yet, Melvin kind of needs to make the best of
the situation.

Melvin thinks this is no problem, he'll start by building a new kernel
with some stuff trimmed out to leave more RAM for userspace.  But...
uh oh!  He nuked that source tree because free disk was getting kind
of tight, and the .config went with it.  Looks like Melvin's going to
have to reconstruct his configuration by hand.

"Crap." Melvin thinks.  "I don't remember what kind of network card I
compiled in.  Am I going to have to open this puppy up just to eyeball
the hardware?" Doing that would take time Melvin was planning to spend
chatting up a girl geek he's noticed over at the computer lab.

Autoconfigure saves the day.  Possibly it even helps Melvin get laid.
--
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Freedom, morality, and the human dignity of the individual consists
precisely in this; that he does good not because he is forced to do
so, but because he freely conceives it, wants it, and loves it.
	-- Mikhail Bakunin 
