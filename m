Return-Path: <linux-kernel-owner+w=401wt.eu-S965127AbWLTPO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWLTPO4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWLTPO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:14:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54009 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965127AbWLTPOz (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:14:55 -0500
Message-Id: <200612200511.kBK5BFo4019459@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
In-Reply-To: Your message of "Tue, 19 Dec 2006 23:57:45 +1100."
             <200612192357.45443.marekw1977@yahoo.com.au>
From: Valdis.Kletnieks@vt.edu
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com> <Pine.LNX.4.62.0612171109180.27120@pademelon.sonytel.be>
            <200612192357.45443.marekw1977@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166591475_3316P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Dec 2006 00:11:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166591475_3316P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Dec 2006 23:57:45 +1100, Marek Wawrzyczny said:
> On Sunday 17 December 2006 21:11, Geert Uytterhoeven wrote:
> > Since `works with' may sound a bit too vague, something like
> > `LinuxFriendly(tm)', with a happy penguin logo?
> 
> It would be really cool to see penguin logos on hardware :)

The little Microsoft flag sticker that was on my Dell Latitude got
replaced with a sticker that has a Tux and 'linux inside' on it. :)

> I had another, probably crazy idea. Would it be possible to utilize the 
> current vendor/device PCI ID database to create Linux friendliness matrix 
> site?
> 
> And if you let yourself get carried away, you can also imagine a little 
> multi-platform utility. It would run on a test system collecting PCI IDs 
> before submitting them to the site  to get the system's overall Linux 
> friendliness rating.

This is a can of worms, and then some.  For instance, let's consider this
Latitude.  *THIS* one has an NVidia Quadro NVS 110M in it.  However, that's
not the default graphics card on a Latitude D820.  So what number do you
put in?  Do you use:

a) the *default* graphics card
b) the one *I* have with the open-source driver
c) the same one, but with the NVidia binary driver?

(Remember that "users" have different criteria than "developers" - most
users would consider this entire thread "intellectual wanking", especially
since the patch that spawned it got withdrawn.  And 'Frames Per Second'
trumps that stupid little 'P' in the oops message.  Failure to understand
this mindset guarantees that your computation of a "friendliness rating"
is yet more intellectual wanking... ;)

Similar issues are involved with the wireless card - the Intel 3945 I
have isn't the default.  Repeat for several different disk options, and
at least 4 or 5 different CD/ROM/DVD options.  Add in the fact that Dell
often changes suppliers for disk and CD/DVD drives, and you have a nightmare
coming...

And then there's stuff on this machine that are *not* options, but don't
matter to me.  I see an 'O2 Micro' Firewire in the 'lspci' output.  I have
no idea how well it works.  I don't care what it contributes to the score.
On the other hand, somebody who uses external Firewire disk enclosures may
be *very* concerned about it, but not care in the slightest about the wireless
card.

Bonus points for figuring out what to do with systems that have some chip
that's a supported XYZ driver, but wired up behind a squirrely bridge with
some totally bizarre IRQ allocation, so you end up with something that's
visible on lspci but not actually *usable* in any real sense of the term...

> Something like that could really help end users to select the right system and 
> would reward those who do the right thing.

"You are trapped in a maze of twisty little configurations, all different..."



--==_Exmh_1166591475_3316P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiMXzcC3lWbTT17ARAgEOAKClJHgAWN1Zo21KaDo8mskiSZt9jQCggF3P
VmeIaxcSDFjiG2nnQ3bM5Io=
=susH
-----END PGP SIGNATURE-----

--==_Exmh_1166591475_3316P--
