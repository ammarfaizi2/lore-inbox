Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131861AbQLHFZs>; Fri, 8 Dec 2000 00:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131890AbQLHFZi>; Fri, 8 Dec 2000 00:25:38 -0500
Received: from alcove.wittsend.com ([130.205.0.20]:30220 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S131861AbQLHFZ3>; Fri, 8 Dec 2000 00:25:29 -0500
Date: Fri, 8 Dec 2000 00:53:37 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
Message-ID: <20001208005337.A26577@alcove.wittsend.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3A30552D.A6BE248C@timpanogas.org> <20001207221347.R6567@cadcamlab.org> <3A3066EC.3B657570@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <3A3066EC.3B657570@timpanogas.org>; from jmerkey@timpanogas.org on Thu, Dec 07, 2000 at 09:43:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 09:43:24PM -0700, Jeff V. Merkey wrote:

> Peter Samuelson wrote:
> > 
> > [Jeff Merkey]
> > > Do folks not know this NTFS driver will trash hard drives?  We need
> > > to alert folks DO NOT USE WRITE NTFS MODE in those versions we know
> > > are busted.

> > Here's an idea: let's make r/w support a separate CONFIG option, and
> > label it "DANGEROUS".

> > Oh wait, we already do that.

> > Perhaps we should warn users to back up their NTFS partitions before
> > trying this option.  Put that warning in the help text for
> > CONFIG_NTFS_RW.

> > Oh wait, we already do that too.

> > How stupid does one have to be in order to enable an option labeled
> > "DANGEROUS" for a non-experimental system?

> Agree.  We need to disable it, since folks do not read the docs
> (obviously).  Of course, we could leave it on, and I could start
> charging money for these tools -- there's little doubt it would be a
> lucrative business.  Perhaps this is what I'll do if the numbers of
> copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> our time to support, so I will have to start charging for it.

	Huh?

	How disabled do you want it.  It can't even be enabled unless
you enabled experimental code options.  Then, it's disabled by default
and you first have to enable the R/O NTFS.  Then you have to explicitly
select the option to enable RW access that is clearly labeled DANGEROUS.
This thing is not armed and dangerous due to an act of ommision.  It's
live and active only through three acts of commision.

	About the only thing left, short of removing it from the kernel
entirely, is to make the option a hidden control option, like some of the
debugging options, that requires editing a header file or a Makefile to
enable.  Is that what you are looking for?

> Jeff

> Jeff   


> > 
> > Peter

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
