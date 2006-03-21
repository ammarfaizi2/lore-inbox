Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWCUJmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWCUJmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWCUJmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:42:35 -0500
Received: from [213.151.39.204] ([213.151.39.204]:36505 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S932364AbWCUJmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:42:35 -0500
Subject: Re: [PATCH] hci_usb: implement suspend/resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <1137602323.4543.29.camel@localhost>
References: <1137540084.4543.15.camel@localhost>
	 <1137589998.27515.8.camel@localhost>  <1137602323.4543.29.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ITYaJOE0i3RIvTmCxmPp"
Date: Tue, 21 Mar 2006 10:42:10 +0100
Message-Id: <1142934130.3964.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ITYaJOE0i3RIvTmCxmPp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-01-18 at 19:39 +0100, Johannes Berg wrote:
> The attached patch implements suspend/resume for the hci_usb bluetooth
> driver by simply killing all outstanding urbs on suspend, and re-issuing
> them on resume.
>=20
> This allows me to actually use the internal bluetooth "dongle" in my
> powerbook after suspend-to-ram without taking down all userland programs
> (sdpd, ...) and the hci device and reloading the module.

Can someone push this patch for 2.6.17 now that 2.6.16 is out? Or is
there still anything fundamentally wrong with it? I've been waiting for
it forever now ;)

johannes

--=-ITYaJOE0i3RIvTmCxmPp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARB/KbqVg1VMiehFYAQJCwBAAwU8c841r0DoSI8W92Xp8TwxfF1U9vISY
9fFhZWCYu4YJmLZ3WKb7gEdZimXHojHb0xES8EoJaRzWDqG1e7MdExV4wCJdPh/t
PrCkNcBwKbW7uZVsrLLsBDeR+M+we1t31KNxcnXkN8zaBAdRzfwIV/8AxUYdxQjy
IWwoc26FSjcvS98jm+xErQgCTqQADAll0TkxMh/qHbrsRWHwFAkAODpZZQAiCK05
qjI+EM4vN9FxFwlZeVpFxPwZdn20lku8NvlJdjQBXtM8nMwjy6lW1FSZsnchr6aZ
OyLPnuwTbA2KsCQ+y43KIxv3R1WMSqYA+dyxgMf/TUxT19VAGI/imDyGCsvRfz2Q
zwCTEugLZbmkEl6Eql6QcuwGKMvgcuMEvVlXmfs9ao3dsxF+NUAQwYR1irMgSFd/
VuOz1Jk/0s7QKq0wa+tYbZgz7ZFX43zWx69P/ib5Lm2geEXgpY/1DUG+RUb+0CKD
w9Phypv2h2/g3m0x2/z9u2UAfgQS6vLy63X+YLN7g7la1DEPvk24wB0JbUR6Wodb
19u7fvqWt+4S1oHoUytcCPkmdEZpVnHgqs2hOsQWhc9f46yV1iwexcVao8FOsXI1
PZ+ggdoJqUqdfak+iEQIPt8swceHgJItiD00qiNVPF4acBlGkOXYWexjHuRCHJQe
4FExgR41cNI=
=n6MQ
-----END PGP SIGNATURE-----

--=-ITYaJOE0i3RIvTmCxmPp--

