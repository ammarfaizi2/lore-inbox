Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVA1Azq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVA1Azq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVA1Awj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:52:39 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:24893 "EHLO xs4all.vs19.net")
	by vger.kernel.org with ESMTP id S261352AbVA1Ar7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:47:59 -0500
Date: Fri, 28 Jan 2005 01:47:55 +0100
From: Jasper Spaans <jasper@vs19.net>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, ajgrothe@yahoo.com
Subject: Re: crypto algoritms failing?
Message-ID: <20050128004755.GA6676@spaans.vs19.net>
References: <20050127233007.GA4678@spaans.vs19.net> <Xine.LNX.4.44.0501271938070.7174-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501271938070.7174-100000@thoron.boston.redhat.com>
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6+20040907i
X-Broken-Reverse-DNS: no host name found for IP address 192.168.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 27, 2005 at 07:38:43PM -0500, James Morris wrote:
> > Is this supposed to happen?
>=20
> No.  What is your kernel version?

Current bitkeeper + latest swsusp2 patches and hostap driver, however, those
two don't come near touching the crypto stuff[1] so they're not really on my
suspect shortlist, but I'll see if I can find time to build a vanilla one
tomorrow (that is, without swsusp/hostap).. right now, it's time to sleep in
my local timezone..


Groet,
--=20
Jasper Spaans                                       http://jsp.vs19.net/
 01:40:46 up 10207 days, 17:27, 0 users, load average: 6.00 6.00 6.12

[1] hostap however does use some crypto algoritms, if I'm not mistaken, but
    its modules are not loaded in that stage of booting

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB+Yu7N+t4ZIsVDPgRAj7PAKCgELsvDN9Q5VNbuCkMqqBHi1pgKgCeLqcx
dw5nSNqL4YqAWFYlwLDdfZU=
=uGV8
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
