Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267735AbUG3QUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267735AbUG3QUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUG3QUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:20:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50409 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267735AbUG3QU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:20:29 -0400
Date: Fri, 30 Jul 2004 17:20:23 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Gigabit Ethernet support for forcedeth
Message-ID: <20040730162023.GD8175@redhat.com>
References: <20040730100421.GB8175@redhat.com> <410A4A1C.4040608@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDs+MzjklnCQZgvp"
Content-Disposition: inline
In-Reply-To: <410A4A1C.4040608@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eDs+MzjklnCQZgvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2004 at 03:16:12PM +0200, Manfred Spraul wrote:

> Tim Waugh wrote:
>=20
> >Works fine if I back out that patch.
> >
> >=20
> >
> The patch rewrites the phy initialization. Backing it out is not really=
=20
> a solution: I have one report that it fixes the link detection, without=
=20
> the patch no link is detected.

I wasn't suggesting it as a solution, just trying to provide data.
Now you have a report that it breaks link detection. :-)

> Which phy is used by your board? Could you enable dprintk (near line=20
> 115) and reload the driver?

I've enabled dprintk and captured *.debug syslog output from a normal
boot.  Here is the result:

http://cyberelk.net/tim/tmp/forcedeth-debug

Hope you can make some sense of it.  Let me know what else I can try.

Tim.
*/

--eDs+MzjklnCQZgvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBCnVH9gevn0C09XYRAvkWAKCoERrlwZEh6wkPpEJgkUL+aKRbTgCfQm37
IJDSCPFEKRab4LMuS00SXWo=
=wcgB
-----END PGP SIGNATURE-----

--eDs+MzjklnCQZgvp--
