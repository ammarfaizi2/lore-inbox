Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272417AbRIRP7d>; Tue, 18 Sep 2001 11:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272420AbRIRP7X>; Tue, 18 Sep 2001 11:59:23 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:47623 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272417AbRIRP7P>; Tue, 18 Sep 2001 11:59:15 -0400
Date: Tue, 18 Sep 2001 10:59:32 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: Hubert Mantel <mantel@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010918105932.D19504@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Hubert Mantel <mantel@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20010917151957.A26615@codepoet.org> <9o5pfu$f03$1@ns1.clouddancer.com> <20010917223203.DACE3783EE@mail.clouddancer.com> <20010918174312.H6102@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918174312.H6102@suse.de> from Hubert Mantel on 09/18/2001 10:43
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/18/2001 17:43 +0200, Hubert Mantel wrote:
>>=09
>>	You only have one single SCSI adapter?
>>=09
>>	I tried several things so far, and it seems you need the following to=20
>>	trigger the problem: You need at least two SCSI adapters that require=20
>>	different drivers (so two AHA2940s are not sufficient) and the drivers=
=20
>>	need to be loaded as modules.
>>	                                                                  -o)


I would amend that a bit - it doesn't seem to have to be only two SCSI
drivers, because I've seen the same with a 2.4.9-ac9 system with aic7xxx
(with sg, sd, and sr) combined with usb-storage (which also uses sd).
Granted usb-storage is kinda pseudo-SCSI, but it's not truly a SCSI
low level driver.

				tw


--=20
twalberg@mindspring.com

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO6dvYsPlnI9tqyVmEQJUrwCeMpmbc5/t1IfdtXCCixlVSkP8oDsAnjZ2
7kobFsejeAPcvpRMu00WgRgX
=7jX+
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
