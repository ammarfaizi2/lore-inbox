Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271814AbRH2B7n>; Tue, 28 Aug 2001 21:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271834AbRH2B7Y>; Tue, 28 Aug 2001 21:59:24 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:33313 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271814AbRH2B7T>; Tue, 28 Aug 2001 21:59:19 -0400
Date: Tue, 28 Aug 2001 20:59:29 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: Dale Amon <amon@vnl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vger triggering alerts
Message-ID: <20010828205929.C1878@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
In-Reply-To: <OF24A34168.0F477E02-ON85256B29.0052E00A@raleigh.ibm.com> <20010829015050.F27869@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010829015050.F27869@vnl.com> from Dale Amon on 08/28/2001 19:50
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've seen similar from a number of sites. You might want
to run the packets through ethereal or tcpdump or similar
to verify it, but the ones I've investigated have ended up
being ECN packets - seems snort isn't yet smart enough to
understand the ECN extensions to TCP...

				tw


On 08/29/2001 01:50 +0100, Dale Amon wrote:
>>	Any one have an idea why I'd be getting these snort alerts
>>	from vger mail transactions?
>>=09
>>	[**] [111:4:1] spp_stream4: WINDOW VIOLATION detection [**]
>>	08/27-01:01:27.806453 199.183.24.194:45473 -> 194.46.0.61:25
>>	TCP TTL:49 TOS:0x0 ID:25963 IpLen:20 DgmLen:74 DF
>>	***AP*** Seq: 0x3DFC914F  Ack: 0xC8CF2D66  Win: 0x16D0  TcpLen: 32
>>	TCP Options (3) =3D> NOP NOP TS: 137819194 96190743=20
>>=09
>>	--=20
>>	------------------------------------------------------
>>	Use Linux: A computer        Dale Amon, CEO/MD
>>	is a terrible thing          Village Networking Ltd
>>	to waste.                    Belfast, Northern Ireland
>>	------------------------------------------------------
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO4xMgMPlnI9tqyVmEQIxkACgrDgahvgdlyHARhe3u02XOzHjkHYAoK8X
dygyt0gg9QUjzmrW1noEpv37
=nC/N
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
