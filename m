Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279510AbRJ2Uxm>; Mon, 29 Oct 2001 15:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279506AbRJ2Ux2>; Mon, 29 Oct 2001 15:53:28 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:1313 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S279490AbRJ2Uwe>; Mon, 29 Oct 2001 15:52:34 -0500
Date: Mon, 29 Oct 2001 14:53:07 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: Harald Dunkel <harri@synopsys.COM>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 3c59x:command 0x3002 did not complete! Status=0xffff
Message-ID: <20011029145307.A8312@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Harald Dunkel <harri@synopsys.COM>, Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BDD9FF4.D54DC0C9@Synopsys.COM> <3BDDA4C0.F4391EC@zip.com.au> <3BDDB312.589D2E04@Synopsys.COM> <3BDDB4E0.C90BFACB@zip.com.au> <3BDDBD60.3540EFCA@Synopsys.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDDBD60.3540EFCA@Synopsys.COM> from Harald Dunkel on 10/29/2001 14:34
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is the NIC sharing interrupts or I/O ports with
the SCSI HBAs?


On 10/29/2001 21:34 +0100, Harald Dunkel wrote:
>>	Andrew Morton wrote:
>>	>=20
>>	> The PCI bus is screwed up.  I haven't seen this before.
>>	> Is the machine otherwise stable?  What's special about bringing
>>	> up PPPoE?  Have you tested the machine well against other hosts
>>	> on the LAN?
>>=09
>>	The eth0 has the address 192.168.1.1 . When I do a ping 192.168.1.2,
>>	then I get an error message, too:
>>=09
>>	Oct 29 21:28:49 bilbo kernel: scsi0: PCI error Interrupt at seqaddr =3D =
0x8
>>	Oct 29 21:28:49 bilbo kernel: scsi0: Data Parity Error Detected during a=
ddress or write data phase
>>	Oct 29 21:28:49 bilbo kernel: eth0: Transmit error, Tx status register f=
f.
>>	Oct 29 21:28:49 bilbo kernel:   Flags; bus-master 1, dirty 1(1) current =
1(1)
>>	Oct 29 21:28:49 bilbo kernel:   Transmit list ffffffff vs. df231240.
>>	Oct 29 21:28:49 bilbo kernel:   0: @df231200  length 8000002a status 800=
0002a
>>	Oct 29 21:28:49 bilbo kernel:   1: @df231240  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   2: @df231280  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   3: @df2312c0  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   4: @df231300  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   5: @df231340  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   6: @df231380  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   7: @df2313c0  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   8: @df231400  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   9: @df231440  length 00000000 status 000=
00000
>>	Oct 29 21:28:49 bilbo kernel:   10: @df231480  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel:   11: @df2314c0  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel:   12: @df231500  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel:   13: @df231540  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel:   14: @df231580  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel:   15: @df2315c0  length 00000000 status 00=
000000
>>	Oct 29 21:28:49 bilbo kernel: eth0: Updating statistics failed, disablin=
g stats as an interrupt source.
>>	Oct 29 21:28:49 bilbo kernel: eth0: Host error, FIFO diagnostic register=
 ffff.
>>	Oct 29 21:28:49 bilbo kernel: eth0: PCI bus error, bus status ffffffff
>>	Oct 29 21:28:49 bilbo kernel: scsi1: PCI error Interrupt at seqaddr =3D =
0x8
>>	Oct 29 21:28:49 bilbo kernel: scsi1: Data Parity Error Detected during a=
ddress or write data phase
>>=09
>>=09
>>	PPPoE was not involved in this. It wasn't even started.
>>=09
>>	Maybe the NIC is broken?=20
>>=09
>>=09
>>	Regards
>>=09
>>	Harri
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO93BscPlnI9tqyVmEQJWxQCglM12zucIJJUKLVnQ4XYxfxjseLwAoL4J
UiFbD9KjZBusE8dWVOHHV0WJ
=lZum
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
