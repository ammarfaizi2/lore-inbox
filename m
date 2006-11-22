Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755292AbWKVQJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbWKVQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbWKVQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:09:59 -0500
Received: from systemlinux.org ([83.151.29.59]:49585 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1755292AbWKVQJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:09:58 -0500
Date: Wed, 22 Nov 2006 17:05:49 +0100
From: Andre Noll <maan@systemlinux.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>, Mel Gorman <mel@skynet.ie>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061122160549.GD27761@skl-net.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Content-Disposition: inline
In-Reply-To: <200611221142.21212.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11:42, Andi Kleen wrote:
> ject    : x86_64: Bad page state in process 'swapper'
> > References : http://lkml.org/lkml/2006/11/10/135
> >              http://lkml.org/lkml/2006/11/10/208
> > Submitter  : Andre Noll <maan@systemlinux.org>
> > Handled-By : David Rientjes <rientjes@cs.washington.edu>
> > Status     : problem is being debugged
>=20
> Does this still happen with -rc6?=20

Unfortunately, yes. I tried rc6, current git, and currrent git + David
Rientjes' patch. They all show the same behaviour.

> It's probably another bug in the memmap parsing rewrite (Mel cc'ed)=20
> but the debugging information in the standard kernel unfortunately
> doesn't give enough output to find out where it happens.

Feel free to send me a debugging patch..

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFZHVdWto1QDEAkw8RAtwtAJ427PoIMpKmGq18RHkisycRRx3naACdHfvm
FkuAAJ8ZvZSksKVjoAqPIjo=
=lyEX
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
