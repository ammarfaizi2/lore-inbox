Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTDVQv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTDVQv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:51:27 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17792 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263251AbTDVQvZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:51:25 -0400
Message-Id: <200304221703.h3MH3ILq002147@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67 
In-Reply-To: Your message of "Tue, 22 Apr 2003 17:28:18 +0200."
             <Pine.LNX.4.44.0304221722160.1536-100000@pau.intranet.ct> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0304221722160.1536-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1469244855P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Apr 2003 13:03:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1469244855P
Content-Type: text/plain; charset=us-ascii

On Tue, 22 Apr 2003 17:28:18 +0200, Pau Aliagas <linuxnow@newtral.org>  said:

> I have a Dell Latitude Laptop with a Xircom Cardbus ethernet + modem card.
> If I boot with the card inserted booting stops like this:
> ........
> socket status = 30000006

That's a known bug with pcmcia - Russel posted a fix which seems to be in:

  http://patches.arm.linux.org.uk/pcmcia-20030421.diff


--==_Exmh_1469244855P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+pXXVcC3lWbTT17ARAr87AJ4jwlovGpS0UIlJOWfTrXnJZXptyQCePT2S
+V4sXd+ATng/PpwXIBTy9oE=
=LRc4
-----END PGP SIGNATURE-----

--==_Exmh_1469244855P--
