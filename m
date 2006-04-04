Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWDDVCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWDDVCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDDVCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750871AbWDDVCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:02:49 -0400
Message-ID: <4432DF23.50004@redhat.com>
Date: Tue, 04 Apr 2006 14:03:31 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mtk-manpages@gmx.net,
       nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net> <20060404205055.GA5745@agluck-lia64.sc.intel.com>
In-Reply-To: <20060404205055.GA5745@agluck-lia64.sc.intel.com>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1508F2E1914071C18C18FD4E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1508F2E1914071C18C18FD4E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Luck, Tony wrote:
> Is it too late to fix __NR_sys_kexec_load (since it is out in the
> wild now?)

It's not too late IMO.  The only real users are the libcs.  And in fact,
I'm already checking for __NR_sync_file_range and not the sys_ variant.
 Andrew, please change it.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig1508F2E1914071C18C18FD4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEMt8j2ijCOnn/RHQRAnx+AKCI1xThoPCk3ey/eU99H+hZQU2JLwCeJvM+
8k4zShjlaHNs+XzsSWeAZI4=
=QW4S
-----END PGP SIGNATURE-----

--------------enig1508F2E1914071C18C18FD4E--
