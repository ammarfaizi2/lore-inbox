Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTF2Unt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTF2Um5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:42:57 -0400
Received: from h80ad24fc.async.vt.edu ([128.173.36.252]:6273 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265762AbTF2UmT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:42:19 -0400
Message-Id: <200306292056.h5TKuPEA005995@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking. 
In-Reply-To: Your message of "Sun, 29 Jun 2003 21:33:33 BST."
             <1056918812.16255.15.camel@dhcp22.swansea.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu> <20030628171036.4af51e08.akpm@digeo.com> <200306291810.h5TIApEA002032@turing-police.cc.vt.edu>
            <1056918812.16255.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1548410243P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 Jun 2003 16:56:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1548410243P
Content-Type: text/plain; charset=us-ascii

On Sun, 29 Jun 2003 21:33:33 BST, Alan Cox said:

> > Hmm.. wonder why it's 40K rather than the expected 50K...
> 
> Lots of laptops clock the i810 audio off an existing clock and software
> fix up the difference. Saves components.

And works fine until the speedstep stuff leaves you running at 1.6G
but jiffies_per_loop set for 1.2G, which is why mdelay(50) only
waited 40ms.  ;)

--==_Exmh_-1548410243P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+/1J5cC3lWbTT17ARAgf3AKCw3DwVkYyeTNjX5WmRgutQxsLYrgCeJynS
cSbhYOgGDkrfZZODmtt5Z+I=
=hcBs
-----END PGP SIGNATURE-----

--==_Exmh_-1548410243P--
