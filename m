Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRKITSt>; Fri, 9 Nov 2001 14:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRKITSp>; Fri, 9 Nov 2001 14:18:45 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:273 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S280031AbRKITRl>; Fri, 9 Nov 2001 14:17:41 -0500
Date: Fri, 9 Nov 2001 11:17:30 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Anders Peter Fugmann'" <afu@fugmann.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ACPI multible power entries
Message-ID: <20011109111730.B22072@one-eyed-alien.net>
Mail-Followup-To: "Grover, Andrew" <andrew.grover@intel.com>,
	'Anders Peter Fugmann' <afu@fugmann.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D724@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D724@orsmsx111.jf.intel.com>; from andrew.grover@intel.com on Fri, Nov 09, 2001 at 11:10:59AM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I see this too on 2.4.14.  The boot messages indicate that one is
fixed-feature, whatever that means, and is being ignored.  But there are
still two entries in the /proc tree.

I'm also getting a crash when I try to shutdown -- NULL pointer dereference
because something-or-other gets passed a NULL scope.  Is this the right
place to report this, or should I be sending that data to another list.

Matt

On Fri, Nov 09, 2001 at 11:10:59AM -0800, Grover, Andrew wrote:
> We should already be handling multiple power button definitions, so I'm
> confused why you're still seeing the problem. Could you please send me yo=
ur
> dmesg output and /proc/acpi/dsdt output?
>=20
> Thanks -- Regards -- Andy
>=20
> > -----Original Message-----
> > From: Anders Peter Fugmann [mailto:afu@fugmann.dhs.org]
> > Sent: Friday, November 09, 2001 4:01 AM
> > To: andrew.grover@intel.com
> > Cc: linux-kernel@vger.kernel.org
> > Subject: [PATCH] fix ACPI multible power entries
> > Importance: High
> >=20
> >=20
> > Hi.
> >=20
> > In trying to get ACPI to work on my system, i was stumbled to see two=
=20
> > button entries under /proc/acpi/button/.
> >=20
> > Attached is a patch which corrects this behaviour.
> > The patch applies to 2.4.14.
> >=20
> > Regards
> > Anders Fugmann
> >=20
> >=20
> >=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE77CvKz64nssGU+ykRApbEAKCSvP4+1zy5tvZAArsJciqDaXyu/wCePGPo
TK71mwZKIjJjc1KCa4/cKCw=
=R8wJ
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
