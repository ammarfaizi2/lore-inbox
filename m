Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUIBHTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUIBHTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267747AbUIBHS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:18:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18384 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267721AbUIBHQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:16:33 -0400
Subject: Re: [CIFS] fix recent cifs symlink change so as not call kfree on
	null path
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: stevef@stevef95.austin.ibm.com
In-Reply-To: <200409020707.i82774GW018405@hera.kernel.org>
References: <200409020707.i82774GW018405@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NIPVQ74zMBUOFMny8S4l"
Organization: Red Hat UK
Message-Id: <1094109388.2823.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 09:16:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NIPVQ74zMBUOFMny8S4l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-02 at 00:59, Linux Kernel Mailing List wrote:
> ChangeSet 1.1891, 2004/09/01 17:59:07-05:00, stevef@stevef95.austin.ibm.c=
om
>=20
> 	[CIFS] fix recent cifs symlink change so as not call kfree on null path
> =09

free(NULL) is perfectly fine...

--=-NIPVQ74zMBUOFMny8S4l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBNsjMxULwo51rQBIRAsBfAKCZ97NWytvZsB0d10J2fIkGXWQeFQCfSMO2
eB3T+NujLiNrwxlvC6/3SKI=
=cMC6
-----END PGP SIGNATURE-----

--=-NIPVQ74zMBUOFMny8S4l--

