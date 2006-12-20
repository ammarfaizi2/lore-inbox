Return-Path: <linux-kernel-owner+w=401wt.eu-S964890AbWLTUwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWLTUwO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbWLTUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:52:14 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51305 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964890AbWLTUwN (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:52:13 -0500
Message-Id: <200612202052.kBKKqCYr023771@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: davids@webmaster.com
Cc: Marek Wawrzyczny <marekw1977@yahoo.com.au>, valdis.kletnietks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
In-Reply-To: Your message of "Wed, 20 Dec 2006 11:29:00 PST."
             <MDEHLPKNGKAHNMBLJOLKMEOHAHAC.davids@webmaster.com>
From: Valdis.Kletnieks@vt.edu
References: <MDEHLPKNGKAHNMBLJOLKMEOHAHAC.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1166647932_3391P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Dec 2006 15:52:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1166647932_3391P
Content-Type: text/plain; charset=us-ascii

On Wed, 20 Dec 2006 11:29:00 PST, David Schwartz said:

> Let's not let the perfect be the enemy of the good. Remember, the goal is to
> allow consumers to know whether or not their system's hardware
> specifications are available. It's not about driver availability -- if the
> hardware specifications are available and a driver is not, that's not the
> hardware manufacturer's fault.

My point was "their system's hardware specifications" is, for some popular
vendors, a *very* fuzzy notion. You can't (for instance) say "specs are
available for a Dell Latitude D820" - there are configurations that specs are
available for, and configs that aren't.  My D820 has an NVidia card in it - we
know the answer there.  Do you give a different answer for a D820 that has the
Intel i950 graphics chipset instead?

Even more annoying, Dell often *changes* the vendor - the line item for the DVD
drive says "8X DVD+/-RW" (other choices include 24X CD-ROM and 24X CD-RW/DVD).
Mine showed up with a Philips SDVD8820 - but it's possible that some other D820
will get some other vendor's DVD (I've seen 2 C820's ordered at the same time,
they showed up with 2 different vendor's "24X CD-RW/DVD").  It's possible that
some poor guy is going to get a D820 that has a DVD that we have a known
buggy driver for - what do we tell *them*?

It's *easy* to do a "semi-good" that tells you if there's drivers for the
hardware config you're running the program on. But there's 2 problems:

a) You probably already know the answer
b) By the time you can run the program, it's often too late....

So given those 2 points, what actual value-added info does this *give*, over
and above 'lspci' and friends?  I suppose maybe for a install CD, it gives
a quick way to cleanly abort the install with a "Don't bother continuing
unless it's OK that your graphics/wireless/whatever won't work".  On the
other hand, the installer should have a grasp on this *already*....

Perfect may be the enemy of the good, but the good is also the enemy of
stuff claiming to be good but misses on an important design goal...

--==_Exmh_1166647932_3391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFiaJ8cC3lWbTT17ARAh9iAJ4kkAwey+wLYC8iytLJZj4f4wBWkgCg+Yv/
VJFchJaWSgmrwn9t2/n2Xwc=
=DnSB
-----END PGP SIGNATURE-----

--==_Exmh_1166647932_3391P--
