Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUDKLsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 07:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUDKLsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 07:48:32 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:49035 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262325AbUDKLsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 07:48:30 -0400
Date: Sun, 11 Apr 2004 12:45:57 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Paul Wagland <paul@wagland.net>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, "J. Ryan Earl" <heretic@clanhk.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: amd64 questions
Message-ID: <20040411114557.GB22258@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Paul Wagland <paul@wagland.net>,
	"J. Ryan Earl" <heretic@clanhk.org>, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@muc.de>
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <407826DF.9030506@clanhk.org> <20040410184904.GA12924@colin2.muc.de> <20040410190230.GD1056@selene> <A716F1DA-8BAC-11D8-A41D-000A95CD704C@wagland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <A716F1DA-8BAC-11D8-A41D-000A95CD704C@wagland.net>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 11, 2004 at 01:37:46PM +0200, Paul Wagland wrote:
> 
> On Apr 10, 2004, at 21:02, Hugo Mills wrote:
> 
> >On Sat, Apr 10, 2004 at 08:49:04PM +0200, Andi Kleen wrote:
> >>>line either?  Or we can if we use AMD64 [DM] libraries with a AMD64
> >>>kernel?  DM = Device Mapper right?
> >>
> >>You can't use Device Mapper with 32bit user tools on a 64bit kernel
> >>right now.
> >
> >   Well, you can, because that's what I'm doing on this machine. Joe
> >Thornber posted a patch[1] here a few weeks ago which fixes the
> >problem in a "sealing-wax-and-string" kind of way. It Works For
> >Me(tm), which is about all you can say about it -- it's not the
> >prettiest piece of code, even to my non-kernel eyes. :)
> 
> Ah, yes, but you missed the bit slightly later in the thread where Andi 
> requested that this not be added to the kernel since it would then 
> break all currently existing 64bit DM user tools. Newly compiled ones 
> would, of course, work, but you introduce a DM user tool versioning 
> problem, where the old 64 bit utils need to be used with old kernels, 
> and the new tools need to be used with the new kernels. As far as I 
> understood, this is the "official" line for the mainstream kernel. It 
> is my hope that the disties all decide to use Thornbers patch when they 
> do release, but only time will tell...

   Sorry, I probably wasn't making myself clear.

   I'm well aware of the issues surrounding this patch, and the fact
that it's never going to get into mainline kernels. However, it _does_
allow you to use DM with 32-bit user-space + 64-bit kernel, which was
my only point.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- The English language has the mot juste for every occasion. ---    

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAeS/1ssJ7whwzWGARAgyxAJ9frJw30FTmA8gDTGj4CYd/+v8epACgsau3
aNajsMWKHtCaFZlkYnrxkKQ=
=OO87
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
