Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279576AbRJ2WYT>; Mon, 29 Oct 2001 17:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279577AbRJ2WYK>; Mon, 29 Oct 2001 17:24:10 -0500
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:49158 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S279576AbRJ2WX5>;
	Mon, 29 Oct 2001 17:23:57 -0500
Date: Mon, 29 Oct 2001 16:24:33 -0600
From: Taral <taral@taral.net>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: /proc/net/ip_conntrack problems
Message-ID: <20011029162433.D18498@taral.net>
In-Reply-To: <20011028220854.A17685@taral.net> <3974.1004329672@kao2.melbourne.sgi.com> <20011028223651.B17685@taral.net> <20011029131916.D20280@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20011029131916.D20280@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2001 at 01:19:16PM -0800, Mike Fedyk wrote:
> Because you would need the buffer size to hit the moving target of any of
> the boundaries of the lines.  So you would need (for the example above)
> buffer sizes of:
> 153
> 291
> 460
> 611
> 778
> 778
>=20
> 16k blocks would hold all of those...

Wrong again. /proc/net/ip_conntrack has code to support incrementally
reading the file. It's broken, I'm just not sure _how_ it's broken.

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvd1yEACgkQoQQF8xCPwJRiQACfdcl7vtZ4gqmSpA8uWDE8MVkM
60wAnRbHwEwC4LnlUv7MOpg/XtAnYDBw
=Ymjd
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
