Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUIFJEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUIFJEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 05:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267689AbUIFJEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 05:04:51 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:39849 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267668AbUIFJEl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 05:04:41 -0400
Date: Mon, 6 Sep 2004 11:03:34 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes unnessary print of space
Message-ID: <20040906090334.GF28697@thundrix.ch>
References: <413C0CC5.4000807@sw.ru> <chh5a5$tle$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <chh5a5$tle$1@sea.gmane.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Salut,

On Mon, Sep 06, 2004 at 04:57:55PM +0900, Kalin KOZHUHAROV wrote:
> I may be just a newbie, but why call prink with no arguments?
> Does it do something?

Actually, there is an argument: a NULL terminated string of size 0.

It  pokes   the  klogd.   This   can  be  done  much   better  through
wake_up_klogd() though.

			    Tonnerre

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBPCfm/4bL7ovhw40RAq+PAJ0bB+6HQpS3H4HdPDS8mxel8UgqnwCfZbzA
EP9SvhxEHOtfDaTmvk+2DBQ=
=GMR3
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
