Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136078AbRARWKd>; Thu, 18 Jan 2001 17:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRARWKX>; Thu, 18 Jan 2001 17:10:23 -0500
Received: from rm05-24-167-191-55.ce.mediaone.net ([24.167.191.55]:60177 "EHLO
	calvin.localdomain") by vger.kernel.org with ESMTP
	id <S131565AbRARWKS>; Thu, 18 Jan 2001 17:10:18 -0500
Date: Thu, 18 Jan 2001 16:10:00 -0600
From: Tim Walberg <tewalberg@mediaone.net>
To: "Jorge Boncompte (DTI2)" <jorge@dti2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ERR in /proc/interrupts
Message-ID: <20010118161000.A3487@mediaone.net>
Reply-To: Tim Walberg <tewalberg@mediaone.net>
Mail-Followup-To: Tim Walberg <tewalberg@mediaone.net>,
	"Jorge Boncompte (DTI2)" <jorge@dti2.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes> from Jorge Boncompte (DTI2) on 01/18/2001 15:54
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A quick perusal of the 2.2.18 source code (I don't have
a copy of 2.4.x handy) shows that it's directly
related to the number of IPIs (inter-processor
interrupts) the system has taken. I'm not real
sure under what conditions this occurs, but it's
someplace to start...


			tw


On 01/18/2001 22:54 +0100, Jorge Boncompte (DTI2) wrote:
>>	    What does ERR mean in /proc/interrupts? I have a computer running
>>	2.4.0test12 that has a lot of this ERR's?
>>=09
>>	           CPU0
>>	  0:  116445752          XT-PIC  timer
>>	  1:     389614          XT-PIC  keyboard
>>	  2:          0          XT-PIC  cascade
>>	  5:   34298837          XT-PIC  eth1
>>	  8:          1          XT-PIC  rtc
>>	 10:  400182075          XT-PIC  eth0
>>	 11:   23181909          XT-PIC  ide0, ide1
>>	 14:          4          XT-PIC  ide2
>>	 15:     692215          XT-PIC  ide3
>>	 64:          0            none  acpi
>>	NMI:          0
>>	ERR:    1586756
>>=09
>>	This is an AMD 800 + Tyan K7 mobo.
>>=09
>>	    -Jorge
>>=09
>>	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>	Jorge Boncompte - T=E9cnico de sistemas
>>	DTI2 - Desarrollo de la Tecnolog=EDa de las Comunicaciones
>>	--------------------------------------------------------------
>>	C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
>>	Tlf: +34 957 761395 / FAX: +34 957 450380
>>	--------------------------------------------------------------
>>	jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
>>	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>	Without wicker a basket cannot be done.
>>	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=09
>>=09
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	Please read the FAQ at http://www.tux.org/lkml/
End of included message



--=20
+--------------------------+------------------------------+
| Tim Walberg              | tewalberg@mediaone.net       |
| 828 Marshall Ct.         | www.concentric.net/~twalberg |
| Palatine, IL 60074       |                              |
+--------------------------+------------------------------+

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBOmdptsPlnI9tqyVmEQKEfACePNDzIuu3FlrTdm2fFFihJD7f14cAoOyi
JpnMLOgVy/2yGMP67sVwanWY
=3gp6
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
