Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVDAHDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVDAHDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDAHDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:03:44 -0500
Received: from dea.vocord.ru ([217.67.177.50]:3981 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262579AbVDAHDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:03:21 -0500
Subject: Re: connector.h
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331173101.769f5c67.akpm@osdl.org>
References: <20050331173101.769f5c67.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zWP+XoO/nNrKkRDHHnbC"
Organization: MIPT
Date: Fri, 01 Apr 2005 11:09:54 +0400
Message-Id: <1112339394.9334.70.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:03:15 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zWP+XoO/nNrKkRDHHnbC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 17:31 -0800, Andrew Morton wrote:
> >=20
> > struct cb_id
> > {
> > 	__u32			idx;
> > 	__u32			val;
> > };
>=20
> It is vital that all data structures be skilfully commented - they are th=
e
> key to understanding the code.  Why the struct exists, which actor passes
> it to which other actor(s), whether the data structure is communicated wi=
th
> userspace, what other data structures it is aggregated with or linked to,
> locking rules, etc.

It is described in Documentation/connector/connector.txt.
Should it also be placed here?

> > struct cn_msg
> > {
>=20
> Please do
>
> 	struct cn_msg {

Neither structure declaration should have opening brace on the new
string?

> >=20
> > #define CN_CBQ_NAMELEN		32
>=20
> Commentary?

Maximum allowed callback name - name will be truncated if=20
it exceeds that limit.

I will place this doc in the code.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-zWP+XoO/nNrKkRDHHnbC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTPPCIKTPhE+8wY0RApSdAJ4yeleVE6L0Kw0p+bpQi14IRxPchwCdHnEn
EnPdi9gFafKIhhKTUORZMrk=
=V51j
-----END PGP SIGNATURE-----

--=-zWP+XoO/nNrKkRDHHnbC--

