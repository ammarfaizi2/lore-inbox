Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUIXG54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUIXG54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 02:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbUIXGyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 02:54:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:52442 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268530AbUIXGwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 02:52:12 -0400
Date: Fri, 24 Sep 2004 02:52:07 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace "linker".
Message-ID: <20040924065207.GR30131@ruslug.rutgers.edu>
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <1095331899.18219.58.camel@uganda> <20040921124623.GA6942@uganda.factory.vocord.ru> <20040924000739.112f07dd@zanzibar.2ka.mipt.ru> <20040923215447.GD30131@ruslug.rutgers.edu> <1095997232.17587.8.camel@uganda> <20040924054844.GO30131@ruslug.rutgers.edu> <1096006470.17587.37.camel@uganda> <1096007404.17587.49.camel@uganda> <20040924063231.GP30131@ruslug.rutgers.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Content-Disposition: inline
In-Reply-To: <20040924063231.GP30131@ruslug.rutgers.edu>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2004 at 02:32:31AM -0400, Luis R. Rodriguez wrote:
> On Fri, Sep 24, 2004 at 10:30:04AM +0400, Evgeniy Polyakov wrote:
> >=20
> > BTW, it can also restrict userspace event notification in following way:
> > when someone sends a message to notify group A of
> > registering/unregistering of device with id {x,y} then connector can
> > check if this group A is registered through callback_register_gpl(it is
> > not exist for now, but can be created as a copy of callback_register() )
> > or not. If it is GPL - send notify, else - execute=20
> > "mail -s "shit happens" linux-kernel@vger.kernel.org"=20
> > in the way /sbin/hotplug is called.
> > BTW, this decision also can be obtained from external policy module.
> >=20
> > As you may think connector in current implementation is quite powerful
> > interface( if I will not praise it, who will? :) ), and somebody can
> > make bad things a bit easier with it, but it is also very flexible and
> > can be tuned to suit your needs.
> >=20
> > I'm open for discussion :)
>=20
> Kernel maintainers:=20
>=20
> What do you think? Can a driver which requires access to binary
> callbacks be included as part of the stock kernel as GPL if Evgeniy's
> Connector provides some sort of kernel "jail" for the callback
> functionality?=20
>=20
> 	Luis
>=20

BTW just wanted to say I realize all this is rediculous, I'm just
testing waters ;)

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU8QXat1JN+IKUl4RAiDnAJwPFH9r2jWf+Tf2E4DUVa4cA8EqIwCeOR1Q
79499n7yUrERNbzNeVnKScI=
=oqnr
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--
