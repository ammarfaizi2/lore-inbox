Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTJONcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJONcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:32:42 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:7084 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S263189AbTJONck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:32:40 -0400
Date: Wed, 15 Oct 2003 15:32:31 +0200
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015133231.GK9850@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, wli@holomorphy.com,
	linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031014121753.GA610@krispykreme> <20031014053154.469255e5.akpm@osdl.org> <20031014124457.GB610@krispykreme> <20031014164004.5f698467.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/hqscKNKvKAHUg2m"
Content-Disposition: inline
In-Reply-To: <20031014164004.5f698467.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/hqscKNKvKAHUg2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Tue, Oct 14, 2003 at 04:40:04PM -0700, Andrew Morton wrote:
> + *	min_free_kbytes =3D lowmem_kbytes / sqrt(lowmem_kbytes)

you do have a strange sqrt here ;)

if you do a 'x*=3D2' at the start of your int_sqrt, your results
are closer to a real sqrt.

then, to get similar min_free_kbytes results, you could do
	min_free_kbytes =3D int_sqrt(2*lowmem_kbytes);

which is easier to understand, me thinks ;)

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--/hqscKNKvKAHUg2m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/jUxuj/Eaxd/oD7IRAhNZAKCCpu7gK9n7zVNcx1K5/5Eqo3KDwQCcDoSn
icY8rTfKWp4LoOiMqbnZjEM=
=lSzs
-----END PGP SIGNATURE-----

--/hqscKNKvKAHUg2m--
