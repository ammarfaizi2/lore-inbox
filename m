Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUDWUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUDWUsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUDWUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:48:05 -0400
Received: from seraph3.grc.nasa.gov ([128.156.10.12]:42893 "EHLO
	seraph3.grc.nasa.gov") by vger.kernel.org with ESMTP
	id S261419AbUDWUsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:48:00 -0400
Date: Fri, 23 Apr 2004 16:44:34 -0400
From: Wesley Eddy <weddy@grc.nasa.gov>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TCP rto estimation patch
Message-ID: <20040423204434.GA7492@grc.nasa.gov>
Reply-To: weddy@grc.nasa.gov
References: <20040423142445.GC501@grc.nasa.gov> <200404231735.i3NHZRp3012111@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <200404231735.i3NHZRp3012111@eeyore.valparaiso.cl>
X-People-Whose-Mailers-Cant-See-This-Header-Are-Lame: true
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2004 at 01:35:27PM -0400, Horst von Brand wrote:
>=20
> Why RTT_ALPHA and RTTVAR_BETA, and not just RTT_BETA? Or even RTO_xxx?
>

Per the spec, alpha is used to compute rtt and beta likewise for rttvar.
=20
> Is there any reason to change them, ever? What happens if you change them?
> Restrictions on values? All this should go with such a patch IMHO (at lea=
st
> pointers to relevant discussion).

The information isn't relevant since the patch didn't change them, and if
you were interested in changing the values then simple google search
would return a plethora of research on RTT estimation.

> Must go over it with a fine comb to make sure no unrelated 2 or 3 got
> replaced... out of my league, sorry.

There are stray constants all over the place, which is something that
even freshman computer science students are taught to avoid.  This patch
represents a minor improvement to that situation.

-Wes

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAiYAyzBuYqbnj3IwRAjhPAKCBRdDgGsALp9DTh5qFK+41cTEb6QCfUENV
XM5O6g2f/gEt/3X2IoG5xAw=
=Dfxq
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
