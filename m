Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267199AbUHTP3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267199AbUHTP3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHTP3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:29:03 -0400
Received: from cantor.suse.de ([195.135.220.2]:11406 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267199AbUHTP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:28:55 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mj@ucw.cz, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz>
	<4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz>
	<4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz>
	<20040819150704.GB1659@merlin.emma.line.org>
	<4124C46B.nail83H31GJ2S@burner>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 20 Aug 2004 17:28:52 +0200
In-Reply-To: <4124C46B.nail83H31GJ2S@burner> (Joerg Schilling's message of
 "Thu, 19 Aug 2004 17:16:59 +0200")
Message-ID: <hoy8k9kevf.fsf@reger.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> Please let us cluse this duplicate discussion here.
> It does not give new informstion and it takes a lot of my time.
>
>>From matthias.andree@gmx.de  Thu Aug 19 17:07:13 2004
>
>>Non-issue.  SuSE 9.1 PRO:
>
>>$ rpm -qf /usr/bin/cdrecord
>>cdrecord-2.01a27-21
>>$ /usr/bin/cdrecord -version
>>ZY=EF=BF=BD$: Operation not permitted. WARNING: Cannot set RR-scheduler
>>ZY=EF=BF=BD$: Permission denied. WARNING: Cannot set priority using setpr=
iority().
>>ZY=EF=BF=BD$: WARNING: This causes a high risk for buffer underruns.
>
> What you see is 2 SuSE created bugs :-(
>
> 1)	printing this message at all in this special case
>
> 2)	SuSE using non initialized variables.

I agree and I'm sorry about that.

Thanks, I've filed bugreports for those and those will be fixed soon,

Andreas
=2D-=20
 Andreas Jaeger, aj@suse.de, http://www.suse.de/~aj
  SUSE Linux AG, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
   GPG fingerprint =3D 93A3 365E CE47 B889 DF7F  FED1 389A 563C C272 A126

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBJhi2OJpWPMJyoSYRAn8BAKCEWcAZNGxJLQ+QOia4DGJPukWa1QCcDiBB
rgAEOFaGw1mTgXw8TYjgNmc=
=792p
-----END PGP SIGNATURE-----
--=-=-=--
