Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRHVQBd>; Wed, 22 Aug 2001 12:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272037AbRHVQBY>; Wed, 22 Aug 2001 12:01:24 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:34093 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272038AbRHVQBQ>; Wed, 22 Aug 2001 12:01:16 -0400
Date: Wed, 22 Aug 2001 11:01:30 -0500
From: Tim Walberg <twalberg@mindspring.com>
To: Travis Shirk <travis@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
Message-ID: <20010822110130.A20693@mindspring.com>
Reply-To: Tim Walberg <twalberg@mindspring.com>
Mail-Followup-To: Tim Walberg <twalberg@mindspring.com>,
	Travis Shirk <travis@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net> from Travis Shirk on 08/22/2001 10:46
X-PGP-RSA-Key: 0x0C8BA2FD at www.pgp.com (pgp.ai.mit.edu)
X-PGP-RSA-Fingerprint: FC08 4026 8A62 C72F 90A9 FA33 6EEA 542D
X-PGP-DSS-Key: 0x6DAB2566 at www.pgp.com (pgp.ai.mit.edu)
X-PGP-DSS-Fingerprint: 4E1B CD33 46D0 F383 1579  1CCA C3E5 9C8F 6DAB 2566
X-URL: http://www.concentric.net/~twalberg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Not much help debugging it, but I can say I've seen the same
thing numerous times on kernels 2.4.[4678] and various -ac
patches (as well as stock kernels). I've tried disabling certain
"newer" features (kernel pppoe for example) and upgrading some
of the other software on the box that was suspect due to it being
relatively active at the time of crash (samba, X, etc.) but have
had no luck yet. I wish I had a serial console to plug in to
see if that turned anything up, because SysRQ doesn't even respond.

On a lighter note, I'm currently running 2.4.8-ac2, and while
the problem isn't gone, it does seem to be less frequent, so I'm
thinking I might try moving to a later 2.4.8-ac or even 2.4.9 if
I get the time this weekend.

I didn't see this at all on 2.4.2, which I ran for a couple
months, so my guess is it's related to something that changed
in 2.4.3 (which I skipped) and 2.4.4, but I haven't had the time
to even consider an exhaustive search through all those possibilities.

Good luck, and let me know if you find anything...

				tw

On 08/22/2001 09:46 -0600, Travis Shirk wrote:
>>	Hello,
>>=09
>>	Ever since I upgraded to the 2.4.x (currently running 2.4.8)
>>	kernels, my machine has been locking up every other day
>>	or so.  Does anyone have any hints/tips for figuring out
>>	what is going on.
>>=09
>>	The symptons are total lock-up of the machine.  No mouse
>>	movement, all GUI monoitors freeze, and I cannot switch to a
>>	virtual console.  I'm not able to ping the locked machine or
>>	ssh/telnet into it either.  So I'm left wondering....how and
>>	the hell to I debug this problem.  It'd be nice to have some
>>	more information to go on or post to the list.
>>=09
>>	I'm running on a dual PIII 850, and this problem occurs with
>>	2.4.7 and 2.4.8.
>>=09
>>	Any suggestions?
>>=09
>>	Travis
>>=09
>>	--=20
>>	Travis Shirk <travis at pobox dot com>
>>	Mathematics is God and Knuth is our prophet.
>>=09
>>	-
>>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>>	the body of a message to majordomo@vger.kernel.org
>>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>	Please read the FAQ at  http://www.tux.org/lkml/
End of included message



--=20
twalberg@mindspring.com

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.1i

iQA/AwUBO4PXV8PlnI9tqyVmEQLCyQCg1xDoAS5EEf87cvsc9bkw2471nXcAoPLR
ILkEn4onP75h/M8bgNQKMzCy
=sRdc
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
