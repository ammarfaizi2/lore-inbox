Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVH3SJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVH3SJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVH3SJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:09:33 -0400
Received: from smtp.nuit.ca ([66.11.160.83]:2170 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S932173AbVH3SJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:09:32 -0400
Date: Thu, 22 Sep 2005 03:15:25 -0400
From: "SR, ESC" <simon@nuit.ca>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.6.13: jfsCommit
Message-ID: <20050922071522.GA5915@pylon>
References: <20050830115950.GA8764@pylon> <1125420432.9223.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <1125420432.9223.3.camel@kleikamp.austin.ibm.com>
X-GPG-KeyServer: hkp://subkeys.pgp.net
X-Operating-System: Debian GNU/Linux
User-Agent: mutt-ng devel-r316 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le mar 2005-08-30 a 12:48:17 -0400, Dave Kleikamp <shaggy@austin.ibm.com> a=
 dit:
> On Tue, 2005-08-30 at 07:59 -0400, SR, ESC wrote:
> > hi,
> >=20
> > i encountered an OOPS during boot here. dropped the machine into xmon
> > even. during boot, i got what's in the attached file
> > (kernel_bug_2.6.13_jfsCommit).
>=20
> I think the problem may be a recent change to jfs_delete_inode.  Does
> this patch fix the problem?

so far so good. box seems "happy". no Oopses. thank you very much :).

simon

--=20
make zImage, not war.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQGVAwUBQzJaCGqIeuJxHfCXAQKdtgv9GsM+r/EbPvtAUe1kuRSyw72WTR6vRI+n
mqIDPEV2HTnYnAICMWPiRcZoRdMoNV/8K2KAcpkWt/m3Ml59HBXRGATancyx9Zv1
7cjBp25Gm4OpPO0uTLNTeiMKtpMU0R8Wy5N7FLkUUBjj1zNB9JmgFTqyNrawmrit
v0h9dUMRSeuNlSBGhlYYBLJnQBlajf+1jjx6BaVx9YfMd4/GvImhdjHt+IKbd25t
cQ+b9LeIU/LMPKMukI2ltbdZIqFDtmPt2h620QXydCi7hdaUXq9jhOj6Jk9I0EEG
KyUVvCYiqBS+71DIHbupqGyna4mWaq3ntqIZfA0OzIJWez/T0YCIBqGwh1g99b9G
ONorxaPkG1KnMswvnbMIXtKCdZKsakJJwXmgU/fgh+1xQSkLQHM0FNmLD+2qqOuS
62aV7iTp47dh2f7cEPBB1LNs1ZoH6bOjlMlRPnvaT+pPIoZzaw/E1G8oR4Polmo9
rFaGPPUnlcPrlAiEWX146eOhbO5+2sF9
=Mq9R
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
