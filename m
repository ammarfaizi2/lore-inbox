Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbUCPIAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbUCPIAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:00:08 -0500
Received: from studorgs.rutgers.edu ([128.6.24.131]:43422 "EHLO
	ruslug.rutgers.edu") by vger.kernel.org with ESMTP id S263502AbUCPIAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:00:01 -0500
Date: Tue, 16 Mar 2004 01:38:56 -0500
From: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       prism54-devel@prism54.org, netdev <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org, jgarzik@redhat.com
Subject: Re: Prism54 Driver Project Complete
Message-ID: <20040316063856.GH24063@ruslug.rutgers.edu>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	"Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
	prism54-devel@prism54.org, netdev <netdev@oss.sgi.com>,
	linux-kernel@vger.kernel.org, jgarzik@redhat.com
References: <20040316055249.GE24063@ruslug.rutgers.edu> <4056983B.9010609@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <4056983B.9010609@pobox.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 01:01:31AM -0500, Jeff Garzik wrote:
> There still needs to be a central "maintainer" of prism54, someone who=20
> sends patches either directly to me, or via Jean to me (maintainer's=20
> choice).  Ideally, it is best to funnel patches from everybody through=20
> driver-maintainer -> subsystem maintainer -> Marcelo|Andrew|Linus.  That=
=20
> only breaks down when the driver or subsystem maintainer is too slow,=20
> and doesn't follow the "release early, release often" precept :)
>=20
> Open source is about lack of control, and trusting that community and=20
> consensus will produce superior software over the long run...  but lack=
=20
> of control doesn't mean lack of organization :)
>=20
> 	Jeff


Well in that case we'll also act as the "official" prism54 patch
recipients/senders. And by "we" I mean any of the prism54 developers
listed on our project page. We can do this but we can only do this if the
patches are sent to *us* based on clean bk trees. It's important that
patches are sent to *us* prior to inclusion in the kernel since this
driver is not the normal 1-file driver. If a patch goes into the driver
in the kernel tree but not ours it's going to be a pain mantaining our
tree / writing patches for you (as was done just now), specially since
we're still a heavily active driver project.=20

So for now then, I'm going to update our CVS repository to match the
kernel tree and we'll soon send you patches with the latest changes.
Please only accept then patches/changes for the driver if its passed throug=
h us (if
this is possible). It's not that that we don't want people to contribute
it's just that this is the way it has to be in order to make our live's
easiers as mantainers of the driver.

I'm already subscribed to the netdev list and I'll keep my eyes open for
any wide-kernel changes/patches and apply them too. I'll ask the others
to do the same.

Is this an OK plan?

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVqEAat1JN+IKUl4RAqgWAKCw8GoeTtwije6vLh9JGMHu941oIACgiXfR
HLMam8KXLB4l4sArfWuie9g=
=uCD2
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
