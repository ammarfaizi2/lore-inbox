Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279995AbRJ3PjY>; Tue, 30 Oct 2001 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279994AbRJ3PjO>; Tue, 30 Oct 2001 10:39:14 -0500
Received: from mclean.mail.mindspring.net ([207.69.200.57]:20270 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S279974AbRJ3Pi5>; Tue, 30 Oct 2001 10:38:57 -0500
Date: Tue, 30 Oct 2001 09:39:13 -0600
From: Tim Walberg <twalberg@mindspring.com>
To: GOMBAS Gabor <gombasg@inf.elte.hu>
Cc: Tim Walberg <twalberg@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030093913.B8312@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	GOMBAS Gabor <gombasg@inf.elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org> <3BDE6A80.3A68A44E@mvista.com> <20011030075043.B4904@mindspring.com> <20011030154733.B27230@pandora.inf.elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030154733.B27230@pandora.inf.elte.hu> from GOMBAS Gabor on 10/30/2001 08:47
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hmm... ever hear of NTP? My general rule of thumb:
Never trust any CMOS clock; let the kernel keep track
of time and periodically update the CMOS clock so
that you (hopefully) get a reasonable starting point
when you boot. Trusting any clock with a cheap power
source to provide accurate time-keeping is an exercise
in futility... (and it's not necessarily the power
source's fault - even an outrageously expensive power
source doesn't guarantee good time-keeping). I think
of a CMOS clock as kind of a book mark. If the book
mark gets lost, I can still find where I left off,
it just takes a little more work.


			tw

On 10/30/2001 15:47 +0100, GOMBAS Gabor wrote:
>>	On Tue, Oct 30, 2001 at 07:50:43AM -0600, Tim Walberg wrote:
>>=09
>>	> Wouldn't it be fairly simple for the kernel to just remember the (wall
>>	> clock) time at boot, and uptime just subtract that from the current
>>	> (wall clock) time?
>>=09
>>	So every people with faulty CMOS batteries would have 30+ years of
>>	uptime. And if the CMOS date is ahead of the real one and the admin
>>	sets it back, you will get negative uptimes etc. If you want such
>>	amusements, it is far easier to write an uptime program that just calls
>>	random() instead of asking the kernel :)
>>=09
>>	Gabor
>>=09
>>	--=20
>>	Gabor Gombas                                       Eotvos Lorand Univers=
ity
>>	E-mail: gombasg@inf.elte.hu                        Hungary
End of included message



--=20
twalberg@mindspring.com

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO97Jn8PlnI9tqyVmEQK8rwCeLqVi5rGs5+O0mvzv5dlV4zcsLgIAnRbv
PNkbeg/FP4YMiJRU4ZEikh1+
=w6qh
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
