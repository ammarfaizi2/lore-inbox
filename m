Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129278AbQJZWw5>; Thu, 26 Oct 2000 18:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQJZWwh>; Thu, 26 Oct 2000 18:52:37 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:47887
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S129278AbQJZWw1>;
	Thu, 26 Oct 2000 18:52:27 -0400
Date: Thu, 26 Oct 2000 15:52:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
Subject: Re: [PATCH] address-space identification for /proc
Message-ID: <20001026155225.B30463@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, linus@goop.org
In-Reply-To: <20001026154527.A30463@goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001026154527.A30463@goop.org>; from jeremy@goop.org on Thu, Oct 26, 2000 at 03:45:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 26, 2000 at 03:45:27PM -0700, I wrote:
> +	buffer += sprintf("ASID: %p\n", mm);

Obviously, this should be:

+	buffer += sprintf("ASID:\t%p\n", mm);

for consistency.

	J

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAjn4takACgkQf6p1nWJ6IgIoiQCY7f6nElj3d/FS/mGBGYtmugTT
3gCdGNeJVwktI+fDfpXkIRXuVrAVGuo=
=POCB
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
