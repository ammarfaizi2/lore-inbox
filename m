Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312482AbSCUUjC>; Thu, 21 Mar 2002 15:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312485AbSCUUix>; Thu, 21 Mar 2002 15:38:53 -0500
Received: from warande3094.warande.uu.nl ([131.211.123.94]:51042 "EHLO
	warande3094.warande.uu.nl") by vger.kernel.org with ESMTP
	id <S312482AbSCUUij>; Thu, 21 Mar 2002 15:38:39 -0500
Date: Thu, 21 Mar 2002 21:38:35 +0100
From: Guus Sliepen <guus@warande3094.warande.uu.nl>
To: Patrick McHardy <kaber@trash.net>
Cc: linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Updated Equalize patch
Message-ID: <20020321203835.GT20420@sliepen.warande.net>
Mail-Followup-To: Guus Sliepen <guus@sliepen.warande.net>,
	Patrick McHardy <kaber@trash.net>,
	linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9A4270.56C09FCB@trash.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mSjbC2tVdWE/Wop"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-oi: oi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+mSjbC2tVdWE/Wop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2002 at 09:28:32PM +0100, Patrick McHardy wrote:

> I've updated the equalize patch to apply on 2.4.18.
> The patch also addresses two race conditions in
> ip_route_input(..) and ip_route_output_key(..).
> The rt_hash_table entry is only read locked although elements
> from the chain can be freed if there is a matching entry with
> RTCF_EQUALIZE set.

Thank you very much! I've added it to the FTP site. I'd like to know if
there is anything the patch does that can't be done with the bonding
module, because otherwise I'd suggest using the latter (it's much
cleaner and handles all Ethernet protocols).

--=20
Met vriendelijke groet / with kind regards,
  Guus Sliepen <guus@sliepen.warande.net>

--+mSjbC2tVdWE/Wop
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8mkTLAxLow12M2nsRAshAAJ9sNYsn/ktRLBYIaGfAezrZLazd8ACffK1e
Mb7NFQJAqlib7JJjeTmc0QA=
=vRZT
-----END PGP SIGNATURE-----

--+mSjbC2tVdWE/Wop--
