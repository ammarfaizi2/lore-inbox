Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWARFuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWARFuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWARFuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:50:17 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40839 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751328AbWARFuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:50:16 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Paul Mundt <lethal@linux-sh.org>,
       John Richard Moser <nigelenki@comcast.net>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Date: Wed, 18 Jan 2006 16:50:03 +1100
Cc: Paul Cameron Davies <pauld@cse.unsw.edu.au>
Subject: Re: Huge pages and small pages. . .
Message-ID: <20060118055003.GD11721@cse.unsw.EDU.AU>
References: <43CD3CE4.3090300@comcast.net> <Pine.LNX.4.61.0601171358240.1682@chaos.analogic.com> <43CD481A.6040606@comcast.net> <20060117231802.GA14314@linux-sh.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <20060117231802.GA14314@linux-sh.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 18, 2006 at 01:18:02AM +0200, Paul Mundt wrote:
> Transparent superpages would certainly be nice. There's already various
> superpage implementations floating around, but not without their
> drawbacks. You might consider the Shimizu superpage patch for x86 if
> you're not too concerned about demotion when trying to swap out the page.
> 
> There's some links on this subject on the ia64 wiki:
> 
> 	http://www.gelato.unsw.edu.au/IA64wiki/SuperPages

Hi,

I'm working on superpages, targeted at Itanium, and I just updated
the WiKi page to explain a bit more where I'm at.

http://www.gelato.unsw.edu.au/IA64wiki/Ia64SuperPages

We're also looking at other things, like completely abstracting out
the 3 level page table to allow us to experiment with VM schemes more
appropriate for large, sparse address spaces and superpages.

This is far from realistic migrate into the kernel stuff (so not
really for here), but if sufficient (say 5 or 10) people drop me a
reply email to say they're interested I can start a low-traffic list
where we can discuss long term (far-fetched?) VM implementation ideas,
share patches, etc.

> Since this topic seems to come up rather frequently, perhaps it would be
> worthwhile documenting some of this on the linux-mm wiki.

Yes, I'll look at putting something in there too.

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDzdcLWDlSU/gp6ecRAixHAKCTuRrWrN4cn5UhoIdK4wKoKh+IfgCfX1xM
D1WOw4gFSuOrCwqKE65Mh4c=
=czkf
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
