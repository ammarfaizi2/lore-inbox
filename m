Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSKMT5U>; Wed, 13 Nov 2002 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSKMT5U>; Wed, 13 Nov 2002 14:57:20 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:41118 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262415AbSKMT5S>; Wed, 13 Nov 2002 14:57:18 -0500
Date: Wed, 13 Nov 2002 21:03:53 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux-kernel@vger.kernel.org
Subject: Re: penalty-imposing resource limits
Message-ID: <20021113200353.GA1109@admingilde.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021111061119.GF79406@episec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20021111061119.GF79406@episec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

On Mon, Nov 11, 2002 at 01:11:19AM -0500, ari wrote:
> my processor was experiencing heat-related problems.  I dealt with
> this as any proactively lazy person would, in that instead of buying a
> new heat sink, i modified my kernel to deal with the issue, and wrote a
> small command-line program as an interface.

i'm currently working on similar problems for my diploma thesis.
i haven't looked at your code but i guess it'll get a little bit
more complicated...

i'm using resource containers as resource principal for accounting
of arbitrary resources (right now the code supports cpu usage
and an estimate of energy consumed by the cpu -- calculated
from the processors performance counters)

user can set arbitrary limits for resource usage of processes,
process groups, entire machine, you name it...

a friend of mine is working on messuring/estimating/controlling
cpu temperature based on this system as a semester thesis.



there are still a lot of rough edges everywhere but i hope
i can do some cleanup and be able to do a real release of the code
after my thesis is done (will happen early next year)
if there is interest, i can point to some code, but there's
no real doku yet...

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  [Tali on IRCnet]  [tali.home.pages.de] _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /
			    -
Wer bereit ist, grundlegende Freiheiten aufzugeben, um sich=20
kurzfristige Sicherheit zu verschaffen, der hat weder Freiheit=20
noch Sicherheit verdient.
			Benjamin Franklin  (1706 - 1790)

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE90rAoj/Eaxd/oD7IRAnDIAJ9rN7QKpj6/4awLHERr+yaD8wirAQCeIc2t
U6+N2MVgWZ2PAnjyTaCnM7w=
=sjO9
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
