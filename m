Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbTEISyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbTEISyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:54:36 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:49637 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263286AbTEISyf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:54:35 -0400
Date: Fri, 9 May 2003 22:07:08 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509190708.GA29959@actcom.co.il>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz> <20030508201509.A19496@infradead.org> <20030509074208.GA14991@actcom.co.il> <20030509080808.GA6254@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20030509080808.GA6254@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2003 at 01:08:08AM -0700, Greg KH wrote:
> On Fri, May 09, 2003 at 10:42:08AM +0300, Muli Ben-Yehuda wrote:
> >=20
> > For example, a rogue process is calling settimeofday() on your router
> > once a month(!). How are you going to find it? There's no LSM hook for
> > settimeofday()
>=20
> Yes there is.  Check the capable hook for CAP_SYS_TIME.  LSM modules can
> get that info quite easily.

Indeed, I missed the fact that LSM modules have a capable
hook. Nonetheless, my original point stands: LSM and hooking kernel
objects are great for security and auditing, hijacking system calls
can be quite useful for debugging, both kernel and userspace.

Thanks,=20
Muli.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+u/xcKRs727/VN8sRAoSkAKCvO8IRxFp1YAtEJkIgglarztSHQgCfdfQi
y0yhNcpCF41pR4an7N89Ta8=
=vRm+
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
