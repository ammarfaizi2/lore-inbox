Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbTFCMTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbTFCMTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:19:33 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:20382 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S264737AbTFCMTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:19:32 -0400
Date: Tue, 3 Jun 2003 14:32:56 +0200
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030603123256.GG1253@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwhGNBny+TwOF9uv"
Content-Disposition: inline
In-Reply-To: <1054519757.161606@palladium.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wwhGNBny+TwOF9uv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Jun 02, 2003 at 02:09:17AM +0000, Linus Torvalds wrote:
> And I personally don't normally do "grep for random function
> declarations", that just sounds like a contrieved example.  I grep for
> specific function names to find usage, and then it's _doubly_ important
> to see that the return (and argument) types match and make sense.
well, but it is nice to be able to grep for the declaration of a
function like

	grep "^where_is_it" *.c

without showing all the uses of that function.

also, putting the return type on its own line makes sure that
the function name is always at the same position.
this greatly enhances readability (at least for me ;)

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--wwhGNBny+TwOF9uv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3JV3j/Eaxd/oD7IRAn5EAJwLiex+o0aT66Mb7yxbYSZjmCtCCACggiJ6
9G4n5Wyj/YXEPSo4bObf+M0=
=8skR
-----END PGP SIGNATURE-----

--wwhGNBny+TwOF9uv--
