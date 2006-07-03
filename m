Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWGCPBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWGCPBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGCPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:01:15 -0400
Received: from pool-72-66-205-146.ronkva.east.verizon.net ([72.66.205.146]:24261
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751012AbWGCPBO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:01:14 -0400
Message-Id: <200607031500.k63F0rO2014091@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Daniel Bonekeeper <thehazard@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
In-Reply-To: Your message of "Mon, 03 Jul 2006 14:44:10 +0300."
             <44A9030A.1020106@gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
            <44A9030A.1020106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151938852_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Jul 2006 11:00:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151938852_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 14:44:10 +0300, Alon Bar-Lev said:

> I hate when vendors like ATI, Conexant and UPEK publish binary drivers
> without publishing the chipset spec... They should decide whether
> their IP is on the software part or on the hardware part, if it is on
> the hardware part, they are making money in selling the hardware. If
> it is on the software part, there is no reason why not providing the
> information for others to write software to work with the primitive
> hardware. So in either case there should be full hardware interface
> disclosure.

That's all fine and good, if the hardware design is entirely either
stuff designed to open specs (for instance, the actual PCI interface
chips, which *have* to behave a given way for the PCI bus to work) or
your own design.

Things get much more difficult if your hardware design ends up incorporating
somebody else's intellectual property, and they insist on such obfuscation
as part of the licensing terms.  You then have two choices:

1) Refuse to build and sell the board under such onerous requirements.

2) Realize that 95% of the computers that could possibly use your board
are running Windows and don't care about an open-source driver *anyhow*,
accept the fact that you'll not be able to sell to that last 5%, and
build it anyhow...

Only one of these choices generates revenue for your company.

--==_Exmh_1151938852_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqTEkcC3lWbTT17ARAszLAJ4uHODWXjewKBRv+Azx96a+cKOztwCgpNbz
Ozx89Hs1wzXCpM1/iD8vxKE=
=v52+
-----END PGP SIGNATURE-----

--==_Exmh_1151938852_4949P--
