Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268174AbUIPP5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUIPP5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268355AbUIPP5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:57:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268176AbUIPPxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:53:04 -0400
Subject: Re: input: Disable the AUX LoopBack command in i8042.c on Compaq
	ProLiant
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
In-Reply-To: <200409161509.i8GF90iJ021552@hera.kernel.org>
References: <200409161509.i8GF90iJ021552@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uukXCIB3lqfy/CkUgFP7"
Organization: Red Hat UK
Message-Id: <1095349977.2698.17.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 17:52:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uukXCIB3lqfy/CkUgFP7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-06-02 at 13:44, Linux Kernel Mailing List wrote:
> ChangeSet 1.1722.87.1, 2004/06/02 13:44:20+02:00, vojtech@suse.cz
>=20
> 	input: Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
> 	       8-way Xeon ProFusion systems, as it causes crashes and reboots
> 	       on these machines. DMI data is used for determining if the
> 	       workaround should be enabled.
> =09
> 	Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
>=20

is there any reason you do this in dmi_scan.c and not via the "new"
since some time method where the user gives the dmi code a table with
callbacks instead ????


--=-uukXCIB3lqfy/CkUgFP7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBSbbZxULwo51rQBIRAjiUAKCDrM51bxyVOlxUe0PvPUFDLTdi5QCfUwtl
XH8WwT8sYbh5tNxHBtmvibg=
=EbYn
-----END PGP SIGNATURE-----

--=-uukXCIB3lqfy/CkUgFP7--

