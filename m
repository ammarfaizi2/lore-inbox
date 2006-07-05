Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWGEXkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWGEXkp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWGEXkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:40:45 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5826 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965069AbWGEXko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:40:44 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Thu, 6 Jul 2006 09:40:31 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.30@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.30@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1742868.3FXNgBZFvS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607060940.40678.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1742868.3FXNgBZFvS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Sorry for coming late to the party. I received a request to provide a Suspe=
nd2=20
patch for current -mm this morning, so I've only just had impetus to look a=
t=20
the impact of klibc.

On Wednesday 28 June 2006 15:17, H. Peter Anvin wrote:
> This removes the part of resume from disk that have been replaced by
> functionality in kinit.
>
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

This patch doesn't look right to me. After it is applied, the user will hav=
e=20
no way of saying that they don't want to resume (noresume). I assume the=20
removal of resume=3D isn't a problem because you're expecting them to use t=
hat=20
other undocumented way of setting resume=3D that Pavel mentioned a while ag=
o?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1742868.3FXNgBZFvS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErE34N0y+n1M3mo0RAgAYAJ0ZtbDL7j/34AdfKmvCCsJgayOQxgCghDti
D0PMECdWlhSoVf7fRqIaV0A=
=gTL5
-----END PGP SIGNATURE-----

--nextPart1742868.3FXNgBZFvS--
