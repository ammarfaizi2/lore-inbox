Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbSJOVdG>; Tue, 15 Oct 2002 17:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSJOVdF>; Tue, 15 Oct 2002 17:33:05 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:46046 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S264865AbSJOVcz>; Tue, 15 Oct 2002 17:32:55 -0400
Date: Tue, 15 Oct 2002 22:38:45 +0100
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Cc: davej@codemonkey.org.uk
Subject: Re: JBD Documentation added in BK-current
Message-ID: <20021015223845.A14095@computer-surgery.co.uk>
References: <20021008212310.A13265@mars.ravnborg.org> <20021014230314.A19801@computer-surgery.co.uk> <20021015201648.A3462@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021015201648.A3462@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Oct 15, 2002 at 08:16:48PM +0200
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2002 at 08:16:48PM +0200, Sam Ravnborg wrote:
> On Mon, Oct 14, 2002 at 11:03:15PM +0100, Roger Gammans wrote:
> >=20
> > Well. I'm not surprised there are a few I couldn't find an SGML referen=
ce
> > for the linuxdoc dtd , or a tutorial when I wrote it, so I guessed by l=
ooking
> > at other documents and source code.=20
> >=20
> > > [I'm cleaning up the mess in the Makefile after JBD was added right n=
ow].
> >=20
> > Did I really make it that messy?
> The infrastructure in the docbook makefile has changed since 2.4.
>=20
> Took a look in the journal-api.sgml file, based on the comments you gave.
> I had to do a little more to crete .html without warnings.
> I've submitted this to Linus and trivial.. as well.
>=20
> Browsing the resulting file I wonder why there are references to several
> jbd files, but they do not include docgen comments.
> Are there some patches missing in 2.5 that updates the comments?

And in 2.4 AFAICT. There is a lot of documentation in the those
c and h files if you look.

The original patch didn;t two thing at once ( bad I know)=20
   1 ) split the internal algorithm and public api comments
   2 ) reformat the api comments for docgen.
  =20
This result in something like 40 extra ps/pdf pages of docs, two
things occur to that there may have been some conflict in the
the .c files when merge due to the time between diff and applying, also
it appears davej passed the file to linux so as small stuff so the docgen
changes prolly need to come throught the ext3 team rather than dave.

If the later is the case it'll prolly fix itself it the fullness as time
as the ext3 team are reviewing the docs.., arent they Andrew??

TTFN
--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9rIrlqQ3nO4jeCz4RAlXxAJ9QJUQg1TPe+DHkCTrhetVrRFUqFQCePHt/
rwtzAxSw9DYKU4dRcQuZJCk=
=AB4W
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
