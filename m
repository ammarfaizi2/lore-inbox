Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUENOMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUENOMM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUENOML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:12:11 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:52996 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261186AbUENOKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:10:18 -0400
Date: Fri, 14 May 2004 16:09:58 +0200
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Michal Ludvig <michal@logix.cz>, Andrew Morton <akpm@osdl.org>,
       jmorris@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
Message-ID: <20040514140958.GA8645@ghanima.endorphin.org>
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
	<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
	<40A37118.ED58E781@users.sourceforge.net>
	<20040513113028.085194a3.akpm@osdl.org>
	<40A3C639.4FD98046@users.sourceforge.net>
	<40A4CA28.4E575107@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <40A4CA28.4E575107@users.sourceforge.net>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085407799.3f43@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 04:31:20PM +0300, Jari Ruusu wrote:
> Michal Ludvig wrote:
> > On Thu, 13 May 2004, Jari Ruusu wrote:
> > > Andrew Morton wrote:
> > > > Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> > > > >  The cryptoloop implementation is busted in more than one way, so=
 it is
> > > > >  useless for security needs:
> > > >
> > > > Is dm-crypt any better?
> > >
> > > Nope. dm-crypt has same exploitable cryptographic flaws.
> >=20
> > Could you be more descriptive?
>=20
> cryptoloop and dm-crypt on-disk formats are FUBAR: precomputable cipherte=
xts
> of known plaintext, and weak IV computation. Anything that claims
> "cryptoloop compatible", and only that, is completely FUBAR. dm-crypt is
> such. IOW, there are now _two_ backdoored device crypto implementations in
> mainline.

Jari, you're starting to annoy me. You have been campaigning with FUD
against cryptoloop/dm-crypt for too long now. There are NO exploitable
security holes in neither dm-crypt nor cryptoloop. There is room for
improving both IV deducation schemes, but it's a theoretic weakness, one
which should be corrected nonetheless. However, modern ciphers are designed
to resist known-plaintext attacks. The default setup of loop-aes' initrd is
a greater threat to security, but wait for my paper on this. In the
meantime, stop spreading FUD, especially stop abusing the term "backdoored"!

Clemens

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFApNM2W7sr9DEJLk4RAjPKAJ9dXEUrU75EeEIa+29maxA0vvUhdQCbBvvQ
f2PGfWfFAssfLR8Kr8BF2S4=
=M5Zo
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
