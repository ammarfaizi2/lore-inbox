Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTDPIOX (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTDPIOX 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:14:23 -0400
Received: from h80ad2792.async.vt.edu ([128.173.39.146]:3968 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264258AbTDPIOW (for <RFC822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 04:14:22 -0400
Message-Id: <200304160825.h3G8PtMS001267@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4+dev
To: Joseph Fannin <jhf@rivenstone.net>
Cc: Florin Iucha <florin@iucha.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates 
In-Reply-To: Your message of "Wed, 16 Apr 2003 00:41:48 EDT."
             <20030416044144.GA32400@rivenstone.net> 
From: Valdis.Kletnieks@vt.edu
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net>
            <20030416044144.GA32400@rivenstone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1702215697P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Apr 2003 04:25:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1702215697P
Content-Type: text/plain; charset=us-ascii

On Wed, 16 Apr 2003 00:41:48 EDT, Joseph Fannin said:

>     Except that I'm seeing the very same sort of freeze on with a
>  Rage128 card with XFree86 4.2.1.
> 
>     Are we all Debian sid users, perhaps?

Nice try, but I'm seeing it on a RedHat 9-ish laptop with this card:

01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go] (rev a3)

using XFree86 4.3.0 and the binary NVidia 4191 driver.  I hadn't posted because
I figured it was an NVidia problem and tainted  quite thoroughly.

Another data point:  I *dont* see this sort of freeze if I start it with
'NvAGP=1' (use internal agp), but I *do* see it with 'NvAGP=2' or '3'
(which tell it to use the kernel 'agpgart' code).

Sorry Dave, looks like a bug in AGP....

--==_Exmh_1702215697P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+nRORcC3lWbTT17ARAvw6AKDqAa5BfI5nbpovK5xOBqOkZPGVzQCgxA9S
+J4j0UJDQfSS8nusTScLJkk=
=mIYN
-----END PGP SIGNATURE-----

--==_Exmh_1702215697P--
