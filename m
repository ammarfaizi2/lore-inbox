Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTANVzR>; Tue, 14 Jan 2003 16:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTANVzQ>; Tue, 14 Jan 2003 16:55:16 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33922 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265355AbTANVzQ>; Tue, 14 Jan 2003 16:55:16 -0500
Message-Id: <200301142204.h0EM45rO016689@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing argv[0] under Linux. 
In-Reply-To: Your message of "Tue, 14 Jan 2003 21:55:02 GMT."
             <b020vm$bpm$1@ncc1701.cistron.net> 
From: Valdis.Kletnieks@vt.edu
References: <20030114185934.GA49@DervishD> <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
            <b020vm$bpm$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-715193155P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jan 2003 17:04:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-715193155P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jan 2003 21:55:02 GMT, Miquel van Smoorenburg <miquels@cistron.nl>  said:

> If you want to modify argv[0] etc, loop over argv[], count howmuch
> space there is (strlen(argv[0] + 1 + strlen(argv[1] + 1 ... etc)
> and make sure you do NOT write a string longer than that. Also
> make sure that you end the string with a double \0

Or steal the code that's already been done - sendmail and wu-ftpd both have
code to do this....

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-715193155P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+JIlUcC3lWbTT17ARAgoFAKDodDJDGD9mvmp3m2r3P1QObP4ElwCg8M+l
Qm9jIwcyd+aNbShO0ZNb9WY=
=yqap
-----END PGP SIGNATURE-----

--==_Exmh_-715193155P--
