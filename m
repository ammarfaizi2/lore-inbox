Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUJNAWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUJNAWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269926AbUJNAWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:22:55 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:23196 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S269798AbUJNAWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:22:52 -0400
Date: Thu, 14 Oct 2004 02:19:34 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
Subject: Re: single linked list header in kernel?
Message-ID: <20041014001934.GB19436@thundrix.ch>
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de> <416D4255.9080501@nortelnetworks.com> <pan.2004.10.13.18.25.41.367757@smurf.noris.de> <416D7A0E.50503@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <416D7A0E.50503@nortelnetworks.com>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Wed, Oct 13, 2004 at 12:55:10PM -0600, Chris Friesen wrote:
> I wonder how many places use the double-linked lists because they're ther=
e,=20
> not because they actually need them.  If its significant, there could be=
=20
> some space savings due to only needing one pointer rather than two.

Actually, linked lists are mostly  used in structure sets, which means
that one  pointer more or less  doesn't hurt too much,  compared to an
O(N)  overhead  in  certain  edit  actions on  the  list  (prepending,
deleting, moving).

Seems that  you can  only write  small *or* fast  code. But  that's no
news.

			    Tonnerre

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBbcYV/4bL7ovhw40RAvbaAJ4rGjr2FkgjgaDDnm6ggt4vS7pGwwCgip12
hpsOn4yjLJWAljOKQ2NiRd8=
=En/0
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
