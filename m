Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUAROdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 09:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUAROdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 09:33:07 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:63691 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S261606AbUAROdD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 09:33:03 -0500
Date: Sun, 18 Jan 2004 16:32:54 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Romain Lievin <romain@rlievin.dyndns.org>
Cc: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: True story: "gconfig" removed root folder...
Message-ID: <20040118143253.GR3713@actcom.co.il>
References: <1074177405.3131.10.camel@oebilgen> <20040118142148.GB2273@rlievin.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHiQ9nAwW5IGN2dL"
Content-Disposition: inline
In-Reply-To: <20040118142148.GB2273@rlievin.dyndns.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hHiQ9nAwW5IGN2dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2004 at 03:21:48PM +0100, Romain Lievin wrote:

> -	if (conf_write(fn))
> -		text_insert_msg("Error", "Unable to save configuration !");
> +	/* protect against 'root directory' bug */
> +	trailing =3D fn[strlen (fn)-1];
> +	stat (fn, &sb);

What if stat() fails?=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--hHiQ9nAwW5IGN2dL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFACpkVKRs727/VN8sRAgeXAKCq3xFtjGzKnGBIcz0vjFeT59ADSgCdEX9Y
m8giAhuPKIT39Ju8ZT3B4R4=
=g7R4
-----END PGP SIGNATURE-----

--hHiQ9nAwW5IGN2dL--
