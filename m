Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUDJTFM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 15:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUDJTFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 15:05:12 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:30602 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S261232AbUDJTFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 15:05:03 -0400
Date: Sat, 10 Apr 2004 20:02:30 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: "J. Ryan Earl" <heretic@clanhk.org>, linux-kernel@vger.kernel.org
Subject: Re: amd64 questions
Message-ID: <20040410190230.GD1056@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Andi Kleen <ak@muc.de>, "J. Ryan Earl" <heretic@clanhk.org>,
	linux-kernel@vger.kernel.org
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <407826DF.9030506@clanhk.org> <20040410184904.GA12924@colin2.muc.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <20040410184904.GA12924@colin2.muc.de>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 10, 2004 at 08:49:04PM +0200, Andi Kleen wrote:
> > So let me get this straight, we can't use LVM with AMD64 under the 2.6 
> 
> No, you completely misunderstood.
> 
> > line either?  Or we can if we use AMD64 [DM] libraries with a AMD64 
> > kernel?  DM = Device Mapper right?
> 
> You can't use Device Mapper with 32bit user tools on a 64bit kernel
> right now.

   Well, you can, because that's what I'm doing on this machine. Joe
Thornber posted a patch[1] here a few weeks ago which fixes the
problem in a "sealing-wax-and-string" kind of way. It Works For
Me(tm), which is about all you can say about it -- it's not the
prettiest piece of code, even to my non-kernel eyes. :)

   Hugo.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=107908531723751&w=2

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
             --- Ceci est un travail pour l'Australien. ---              

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAeETGssJ7whwzWGARAsiUAJ96cIeObwsDbBAEdKD4VPXFP91T8wCffwti
dfvu2py35CURqmBEJiRJgcw=
=qnbA
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
