Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946748AbWKJXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946748AbWKJXKq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWKJXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:10:46 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60039 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1424455AbWKJXKp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:10:45 -0500
Message-Id: <200611102310.kAANAgOf019164@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-kernel@vger.kernel.org, madduck@madduck.net
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
In-Reply-To: Your message of "Fri, 10 Nov 2006 23:54:00 +0100."
             <45550308.1090408@wpkg.org>
From: Valdis.Kletnieks@vt.edu
References: <455496CA.5040405@wpkg.org> <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu>
            <45550308.1090408@wpkg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163200242_4028P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 18:10:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163200242_4028P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Nov 2006 23:54:00 +0100, Tomasz Chmielewski said:

> You use old smartmontools :)
> 
> -o on / -S on is not supported for sata, unless you use a CVS version of 
> smartmontools.

OK, thanks - the Fedora RPM from several days ago is still 5.36 based,
I just pulled the CVS version and it starts up much more nicely.  Only quirk:

Nov 10 18:04:32 turing-police smartd[18988]: Device: /dev/sda, opened 
Nov 10 18:04:32 turing-police smartd[18988]: Device /dev/sda: SATA disks accessed via libata are supported by Linux kernel versions 2.6.15-rc1 and above. Try adding '-d ata' or '-d sat' to the smartd.conf config file line. 

Well, yeah. I'm on 2.6.19-rc5-mm1 and the config file *has* '-d ata' already. ;)
I'd file a bug report against that, except it's time for me to leave the office
and forage for some dinner. :)

--==_Exmh_1163200242_4028P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFVQbycC3lWbTT17ARAocgAKDmyLl12TNv8qoy4uDV0DM0p5obmgCeNe8+
o3Zfd+axCTGXBVqdeJqEqCU=
=3lXH
-----END PGP SIGNATURE-----

--==_Exmh_1163200242_4028P--
