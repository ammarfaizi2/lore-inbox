Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263712AbUDOErx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 00:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263730AbUDOErx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 00:47:53 -0400
Received: from [210.8.79.18] ([210.8.79.18]:21171 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S263712AbUDOEru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 00:47:50 -0400
Date: Thu, 15 Apr 2004 14:47:36 +1000
To: Dave Jones <davej@redhat.com>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040415044736.GB1472@himi.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20040414170010.GA23419@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 14, 2004 at 06:00:10PM +0100, Dave Jones wrote:
> On Wed, Apr 14, 2004 at 06:18:27PM +0200, Sam Ravnborg wrote:
>  > On Wed, Apr 14, 2004 at 08:40:47AM -0700, walt wrote:
>  > > I pulled the latest changesets just now and found this weird behavio=
r:
>  > >=20
>  > > 'make' and 'make install' worked as expected, but 'make modules_inst=
all'
>  > > just deleted all the old modules, ran depmod, and then installed no =
new
>  > > modules -- nothing.
>  > >=20
>  > > I finally found that doing another 'make' fixed whatever the problem
>  > > was and allowed modules_install to work properly the second time.
>  > >=20
>  > > This happened on two different machines, so I'm fairly sure it wasn't
>  > > just me having a brainfart.
>  >=20
>  > This is my second report about this.
>  > But you gave some new info "work properly the second time".
>  > This was not the case for the other person.
>=20
> Make this the third.  I just saw it happen here too.
> 'make bzImage ; make modules ; make modules_install' fails in the above w=
ay.
> Doing a 'make' seems to work.
>=20
I've seen the same problem doing 'make; make install
modules_install'. I haven't tried doing make again before
modules_install - I'll do that when I have time.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAfhPoQPlfmRRKmRwRAlQLAJ98ZRgRBXCujmC6ig1Csfs7BI27DgCgxDGz
+ZxmGzdBDN2gw3g88mbkHhw=
=QY/n
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
