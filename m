Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWAQSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWAQSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAQSnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:43:15 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:44182 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S932357AbWAQSnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:43:13 -0500
Date: Tue, 17 Jan 2006 13:41:14 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Samuel Ortiz <samuel.ortiz@nokia.com>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060117184114.GB20298@shaftnet.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"John W. Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <samuel.ortiz@nokia.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <Pine.LNX.4.58.0601152038540.19953@irie> <20060116170951.GA8596@shaftnet.org> <Pine.LNX.4.58.0601162020260.17348@irie> <20060116190629.GB5529@tuxdriver.com> <1137450281.15553.87.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <1137450281.15553.87.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Tue, 17 Jan 2006 13:41:16 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2006 at 10:24:41PM +0000, Alan Cox wrote:
> If I have told my equipment to obey UK law I expect it to do so. If I
> hop on the train to France and forget to revise my configuration I'd
> prefer it also believed the APs

It's not that you might forget to revise your configuration, but that=20
the vast majority of users will not revise anything, and still expect=20
things to "just work".  Kind of like multi-band cell phones. =20

This isn't that big of a deal in the 2.4GHz band, but when you start
talking about 5GHz, especially in France, things get a lot trickier.

Of course, all of this automagic "just work" crap only affects the STAs.=20
For AP operation, we have to trust the user to set the correct locale --
I don't see any way of including a sane "just-works" default in the
stock kernel.org tree, so I think the default should be be "none".  This
way the user is forced to explicitly set the regdomain in order for the
AP startup to succeed.

=2E..and pray that the AP isn't migrating to a different regdomain, but=20
there's really nothing anyone can do about that.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDzTpKPuLgii2759ARAgO4AJ9CD7o+BR/IqBN8UhpANGQBstW2sACggIUA
vTd3Ct+uIXzCoaTrMycNhAw=
=oR+o
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
