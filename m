Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755264AbWKMUel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbWKMUel (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbWKMUel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:34:41 -0500
Received: from nsm.pl ([195.34.211.229]:37573 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1755264AbWKMUek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:34:40 -0500
Date: Mon, 13 Nov 2006 21:34:21 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: kvm-devel@lists.sourceforge.net
Subject: overriding BIOS (was: Re: [ANNOUNCE] kvm howto)
Message-ID: <20061113203421.GA5363@irc.pl>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	kvm-devel@lists.sourceforge.net
References: <20061105171424.GA7045@irc.pl> <64F9B87B6B770947A9F8391472E0321608EBF537@ehost011-8.exch011.intermedia.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <64F9B87B6B770947A9F8391472E0321608EBF537@ehost011-8.exch011.intermedia.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2006 at 12:15:02AM -0800, Dor Laor wrote:
> The BIOS check is a must, it checks bit #0 of MSR_IA32_FEATURE_CONTROL,
> if it set this means that software cannot write to the MSR. If bit #2 is
> clear too then when executing vmxon you'll get #GP.
>=20
> So the check should better be there...

  You were right, just writing to this MSR (via kvm_enable) halts my laptop.
 Which is kinda strange, as this solution works on Intel Mac Minis.

  Anyway, complaint to Lenovo sent and got ignored.

--=20
Tomasz Torcz       ,,(...) today's high-end is tomorrow's embedded processo=
r.''
zdzichu@irc.-nie.spam-.pl                      -- Mitchell Blank on LKML


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFWNbN10UJr+75NrkRAiRpAJ9ty7lPXEGB2fozU0guHnYjlUWLJwCgj5X4
or3+JkxSDoLaACGrV6ale3k=
=U77b
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
