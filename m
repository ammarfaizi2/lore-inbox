Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbUAKEMm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 23:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbUAKEMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 23:12:42 -0500
Received: from h80ad2593.async.vt.edu ([128.173.37.147]:51843 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265755AbUAKEMj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 23:12:39 -0500
Message-Id: <200401110412.i0B4CWe8024839@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robert Love <rml@ximian.com>
Cc: jlnance@unity.ncsu.edu, linux-kernel@vger.kernel.org
Subject: Re: Laptops & CPU frequency 
In-Reply-To: Your message of "Sat, 10 Jan 2004 22:17:41 EST."
             <1073791061.1663.77.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <20040111025623.GA19890@ncsu.edu>
            <1073791061.1663.77.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_993915776P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Jan 2004 23:12:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_993915776P
Content-Type: text/plain; charset=us-ascii

On Sat, 10 Jan 2004 22:17:41 EST, Robert Love said:

> The MHz value in /proc/cpuinfo should be updated as the CPU speed
> changes - that is, it is not calculated just at boot, but it is updated
> as the speed actually changes.

Yes, it should.  However, I remember chasing down a similar bug in the
SpeedStep code back around 2.5.73-75 timeframe (which managed to manifest as
the audio chipset latching onto the wrong clocking, no less - it wasn't till
later that I noticed that the frequency and bogomips numbers in /proc/cpuinfo
were bogus too).  I admit never checking if either the original code or the
patch were backported to 2.4.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105859009128595&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=105691055706753&w=2

(the final actual fix ended up being slightly different, but that was the bug).

Feel free to hit "delete" if this is irrelevant...

--==_Exmh_993915776P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAAM0wcC3lWbTT17ARAnUnAKDpaXwmCUbg2++M27V5ZRp8kZnoqwCgkf1A
jJFf61/Q/fJVg3giNrM/GIo=
=HKeo
-----END PGP SIGNATURE-----

--==_Exmh_993915776P--
