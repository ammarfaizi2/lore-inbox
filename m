Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267527AbTAGWVi>; Tue, 7 Jan 2003 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbTAGWVh>; Tue, 7 Jan 2003 17:21:37 -0500
Received: from owl.ewu.edu ([146.187.128.22]:53266 "EHLO OWL.ewu.edu")
	by vger.kernel.org with ESMTP id <S267527AbTAGWVg>;
	Tue, 7 Jan 2003 17:21:36 -0500
Date: Tue, 07 Jan 2003 06:28:10 -0800
From: Kaleb Pederson <kibab@icehouse.net>
Subject: Re: windows=stable, linux=5 reboots/50 min
In-reply-to: <20030107095406.GH2141@vagabond>
To: linux-kernel@vger.kernel.org
Message-id: <200301070628.17747.kibab@icehouse.net>
MIME-version: 1.0
Content-type: multipart/signed; charset=iso-8859-1;
 boundary="Boundary-02=_BQuG+U/NJpFgMWP"; micalg=pgp-sha1;
 protocol="application/pgp-signature"
Content-transfer-encoding: 7bit
User-Agent: KMail/1.5
References: <LDEEIFJOHNKAPECELHOAKEJFCCAA.kibab@icehouse.net>
 <20030107095406.GH2141@vagabond>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_BQuG+U/NJpFgMWP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

I'm now pretty sure that it is a hardware failure of some type.  Windows was 
stable last night for about four hours of compiling, graphics manipulations, 
etc.  But, when I got home after being gone for several hours, Windows 
started exhibiting the same behavior.  I presume it is Linux sensitivity to 
hardware that made it show up 5 days sooner.  I'm presume, at this point, 
that it is either the motherboard or one of the processors.

Thank you everyone for your suggestions.  Of the many messages I received, the 
following were good and relevant to my system and I will try them to see if 
it does make a difference.

1) Try disabling apm/acpi in bios (I had done this in the kernel, not in 
bios).
2) Try a uniprocessor kernel or booting with only one processor
3) mount /var synchronous to see if anything shows up in the logs (I had 
checked the logs and nothing was getting written to it.  I had forgotten that 
you could make the whole file system synchronous; I'll try this.)
4) Increase voltage to the processors and see if it helps.

Per some other questions, I'm not using scsi nor do I have an intel 82801DB 
chip onboard.

Thanks again for the help.

--Kaleb
PS: Please CC me any responses that go to the list.
--Boundary-02=_BQuG+U/NJpFgMWP
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+GuQBeAVt8Tl/2kURAlfPAJ996TUctyXkPnSrXp13eLk2Vvh69QCgqhnn
XGaWuCB0APt6DxYYMrPRAi4=
=Jdur
-----END PGP SIGNATURE-----

--Boundary-02=_BQuG+U/NJpFgMWP--

