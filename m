Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTH2Iu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 04:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264486AbTH2Iu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 04:50:26 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:45806 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264474AbTH2IuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 04:50:25 -0400
Subject: Re: We have ethtool_ops, any thoughts on miitool_ops?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: David T Hollis <dhollis@davehollis.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3F4EB6F4.3010007@davehollis.com>
References: <3F4EB6F4.3010007@davehollis.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T9rEAiV/4BWfwADBLbOW"
Organization: Red Hat, Inc.
Message-Id: <1062147016.4999.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 29 Aug 2003 10:50:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T9rEAiV/4BWfwADBLbOW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-29 at 04:14, David T Hollis wrote:
> If a driver is converted to use ethtool_ops, it does not seem to have=20
> the ability to support mii-tool any longer.  RedHat uses mii-tool to=20
> check for link before running dhclient so that you don't have to wait=20
> forever for dhclient to timeout if the connection is down (laptops,=20
> etc).=20

this is legacy; the road to the future for this is ethtool + the link
status change notification stuff=20

--=-T9rEAiV/4BWfwADBLbOW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/TxPIxULwo51rQBIRAi/0AJ4rgnVVyasMax3IuJmoF906lNuk1wCfbx7l
orPpAmkmMLdrBH+IcFrzUJ4=
=rAmc
-----END PGP SIGNATURE-----

--=-T9rEAiV/4BWfwADBLbOW--
