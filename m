Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLaMNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbTLaMNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 07:13:06 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:19586 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264339AbTLaMNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 07:13:02 -0500
Subject: RE: memory leak in call_usermodehelper()
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Srikumar Subramanian <SrikumarS@ami.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Boopathi Veerappan <BoopathiV@ami.com>
In-Reply-To: <8CCBDD5583C50E4196F012E79439B45C0568D7F6@atl-ms1.megatrends.com>
References: <8CCBDD5583C50E4196F012E79439B45C0568D7F6@atl-ms1.megatrends.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rvrzXt9MyMUSOkH14yWI"
Organization: Red Hat, Inc.
Message-Id: <1072872769.4292.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 31 Dec 2003 13:12:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rvrzXt9MyMUSOkH14yWI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-31 at 06:22, Srikumar Subramanian wrote:

>=20
> Is there any alternative to call_usermodehelper in kernel 2.4.20?
>=20
most of all don't implement your own syscalls!

> Hi,
> I am using 2.4.20-8 Redhat 9 kernel.
>=20

well clearly not quite since you're adding syscalls to it.
Also 2.4.20-8 isn't the current Red Hat Linux 9 kernel; 2.4.20-27.9 is.


--=-rvrzXt9MyMUSOkH14yWI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8r1BxULwo51rQBIRAtM+AJ9DMKe1WCXiFU/+hUGZbeBj4J0dawCghpuF
3p3FqREmnOWCtO8fFYQ81nE=
=R23u
-----END PGP SIGNATURE-----

--=-rvrzXt9MyMUSOkH14yWI--
