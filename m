Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312427AbSCUVFp>; Thu, 21 Mar 2002 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSCUVFg>; Thu, 21 Mar 2002 16:05:36 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:53858 "EHLO
	warande3094.warande.uu.nl") by vger.kernel.org with ESMTP
	id <S312427AbSCUVFW>; Thu, 21 Mar 2002 16:05:22 -0500
Date: Thu, 21 Mar 2002 22:05:20 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: Patrick McHardy <kaber@trash.net>
Cc: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Updated Equalize patch
Message-ID: <20020321210520.GU20420@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	Patrick McHardy <kaber@trash.net>,
	linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9A4270.56C09FCB@trash.net> <20020321203835.GT20420@sliepen.warande.net> <3C9A489D.DD8993C1@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pDtNmxPr5KTxcQ6Z"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pDtNmxPr5KTxcQ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2002 at 09:54:53PM +0100, Patrick McHardy wrote:

> > > I've updated the equalize patch to apply on 2.4.18.
[...]
> > Thank you very much! I've added it to the FTP site. I'd like to know if
> > there is anything the patch does that can't be done with the bonding
> > module, because otherwise I'd suggest using the latter (it's much
> > cleaner and handles all Ethernet protocols).
[...]
> I've not tried the bonding module but afaik it can't be used with ppp
> links

True, it works only with Ethernet devices AFAIK. But from what I saw the
design of the bonding device might actually be made to work with ppp
devices as well...

> and has to be supported by the other end so equalize looks like

That's not true.

> the only way to do it, especially since i've got only very few high
> bandwidth connections and one link is a lot slower than the other so i
> can't rely on normal multipath routing to distribute traffic correct.

Aha. I'll try out your updated patch later, but can you tell me if it
works without warnings or errors for you? What is the maximum throughput
you get?

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--pDtNmxPr5KTxcQ6Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8mksPAxLow12M2nsRAtlfAJ0bFqYroT8QmdYsrFGdNrTUx+QtgQCdGngq
J5LCcikt66rBltlC/K1h6e8=
=EYjx
-----END PGP SIGNATURE-----

--pDtNmxPr5KTxcQ6Z--
