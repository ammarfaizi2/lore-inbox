Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274869AbTHKWkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274884AbTHKWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:40:22 -0400
Received: from CPE0030ab0b413b-CM023469906297.cpe.net.cable.rogers.com ([24.157.3.237]:64880
	"EHLO imladris.debian.net") by vger.kernel.org with ESMTP
	id S274869AbTHKWkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:40:17 -0400
Date: Mon, 11 Aug 2003 18:40:49 -0400
From: Kyle McMartin <kyle@debian.org>
To: James Morris <jmorris@intercode.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CAST5 Cipher Algorithm for Kernel Cryptographic API.
Message-ID: <20030811224048.GA30195@imladris.debian.net>
References: <200308111456.23587.jeffpc@optonline.net> <Mutt.LNX.4.44.0308120830040.13194-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308120830040.13194-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2003 at 08:31:31AM +1000, James Morris wrote:
> It's already been made into a patch, I just need to get it tested on a=20
> non-x86 box.
>=20
The CAST5 cipher from the kerneli cryptoapi has been tested against
basically every architecture we could get our hands on, using the
test vectors supplied in the RFC.

If you'd like, I can submit a patch.

On the other hand, there really is no point adding CAST5, as
much stronger, much faster algorithms are already in place.

Lastly, if somebody really wants to put CAST in the kernel, I'd suggest
going with CAST6, the AES candidate specified in RFC-2612.

Regards,
--=20
Kyle McMartin <kyle@debian.org>
0x191FCD8A - 331A 9468 C04D 3A76 5C56  BA68 7EB7 92DF 191F CD8A [DSA]

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE/OBtwfreS3xkfzYoRAnqfAJ99YhLXx6+JQQyu58M61xufbG/ykQCeL9RS
llRuV+b+lZOqKWsvh8wmB80=
=cwTq
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
