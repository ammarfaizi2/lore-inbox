Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWGZO1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWGZO1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWGZO1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:27:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751630AbWGZO1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:27:36 -0400
Message-ID: <44C77C23.7000803@redhat.com>
Date: Wed, 26 Jul 2006 07:28:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru> <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru> <20060726103001.GA10139@infradead.org>
In-Reply-To: <20060726103001.GA10139@infradead.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0F541614E1AF69A90F7C149"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0F541614E1AF69A90F7C149
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig wrote:
>> My personal opinion on existing AIO is that it is not the right design=
=2E
>> Benjamin LaHaise agree with me (if I understood him right),
>=20
> I completely agree with that aswell.

I agree, too, but the current code is not the last of the line.  Suparna
has a st of patches which make the current kernel aio code work much
better and especially make it really usable to implement POSIX AIO.

In Ottawa we were talking about submitting it and Suparna will.  We just
thought about a little longer timeframe.  I guess it could be
accelerated since he mostly has the patch done.  But I don't know her
schedule.

Important here is, don't base any decision on the current aio
implementation.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigE0F541614E1AF69A90F7C149
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEx3wj2ijCOnn/RHQRAlJEAKCohm3ngAyWs0Jo5O16Urun9K9lsgCfcymV
jsPinmGcEThS5CJG75Qh00Q=
=phCc
-----END PGP SIGNATURE-----

--------------enigE0F541614E1AF69A90F7C149--
