Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313713AbSDPPOI>; Tue, 16 Apr 2002 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313714AbSDPPOH>; Tue, 16 Apr 2002 11:14:07 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12682 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S313713AbSDPPOG>; Tue, 16 Apr 2002 11:14:06 -0400
Date: Tue, 16 Apr 2002 16:14:02 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: Incremental Patch Building Script
Message-ID: <20020416161402.I1451@redhat.com>
In-Reply-To: <Pine.NEB.4.44.0204161404310.12986-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.4.43.0204160710290.12000-100000@fermi.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2002 at 07:11:46AM -0700, Robin Johnson wrote:

> >   interdiff -z patch-2.4.19-pre6.gz patch-2.4.19-pre7.gz > mydiff
>=20
> I did try interdiff before writing this script, and it wasn't generating
> the right output.

The Linus patches have 'a/' or 'b/' as the first component of the
filename.  Try using 'interdiff -zp1 ...'---the '-p1' option causes
interdiff to ignore the first pathname component.

Tim.
*/

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8vD+6yaXy9qA00+cRAh+MAJ9ZS2sOa8vf/WQyv18JtNEB3IAyWACgvBeV
RKPtnzTh+xz5oAYck+IeUpo=
=nIJD
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--
