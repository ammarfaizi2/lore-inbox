Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270199AbRHISGs>; Thu, 9 Aug 2001 14:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270233AbRHISGj>; Thu, 9 Aug 2001 14:06:39 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:25388 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S270199AbRHISGd>; Thu, 9 Aug 2001 14:06:33 -0400
Date: Thu, 9 Aug 2001 13:06:41 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: Setting up MTRRs for 4096MB RAM
Message-ID: <20010809130641.B10425@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <Pine.LNX.4.21.0108091306550.18150-100000@willow.commerce.uk.net> <9kuils$q67$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9kuils$q67$1@cesium.transmeta.com> from H. Peter Anvin on 08/09/2001 12:53
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08/09/2001 10:53 -0700, H. Peter Anvin wrote:
>>=09
>>	Intel MTRRs have to be a multiple of 2, so you'd need 2 MTRRs if you
>>	wanted to cover 3 GB.  0x80000000 is a multiple of 2; 0xC0000000
>>	isn't, and 0xFFFFFFFF definitely isn't, although 0x100000000 is.

Since when? Seems to me bit 0 of 0xC0000000 is 0, therefore it is
a multiple of two. Perhaps you meant "power of 2" (i.e. only one bit
set in the binary representation)?


			tw


--=20
twalberg@mindspring.com

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO3LRL8PlnI9tqyVmEQLd2gCff1lmpJPLwEgsmVUkAGjuEr8VGa4AoJo3
2dZ8eg+uXY+Jer/5wkWudlGj
=s/4K
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
